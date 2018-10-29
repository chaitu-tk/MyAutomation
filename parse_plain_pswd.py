#!/usr/bin/env python3.5
import pyshark
import argparse
import os

DESCRIPTION = """
    test
"""
EXAMPLES = """
    ./parse_plain_pswd.py eth0
"""

def initialise_parser():
    parser = argparse.ArgumentParser(description=DESCRIPTION,
                                     formatter_class=argparse.RawDescriptionHelpFormatter,
                                     epilog=EXAMPLES)
    parser.add_argument("-i", "--iface", type=str, required=True,
                        help="the interfaceon which to start live capture")

    return parser
'''
  use packet[LAYER].field_names for parsing..
'''
def packet_captured(packet):
    if int(packet['ETH'].type, 16) == 2048:
        if int(packet['IP'].proto) == 6:
            if int(packet['TCP'].port) == 80 and int(packet['TCP'].len) != 0:
                try:
                    #HTTP layer doesn't have request.method
                    print ("Len is", packet['HTTP'])
                    print ("Len is", packet['HTTP']._ws_expert_message)
                except:
                    print ("Method:", packet['TCP'])

def main():
    parser = initialise_parser()
    args = parser.parse_args()
    if os.geteuid() != 0:
       return (1, "You need to have root privileges to run this script.")

    print (args.iface)
    capture = pyshark.LiveCapture(interface=args.iface)
    # LiveCapture uses file as input hence capture filter doesn't work..
    #capture = pyshark.LiveCapture(interface=args.iface, capture_filter="http.request_method='POST'")
    try:
        capture.apply_on_packets(packet_captured)
    except KeyboardInterrupt:
        print ("Aborting the packet capture")
        exit(0)
    
    

if __name__ == "__main__":
    main()
