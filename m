From: Steve Poulsen <spoulsen@css-design.us>
Subject: USB - HID - Seems to be a stall on some of the messages.
Date: Wed, 26 Sep 2007 16:54:10 -0500
Message-ID: <46FAD502.4090601@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I am creating a USB audio gadget device with HID support.  The device is 
recognized as an audio device without issue, but the HID portion seems 
to get a stall when the report descriptor is requested (see the log 
below).  I rebuilt omap_udc with DEBUG and VERBOSE and am certain that 
this request is not making it to the irq.  Any ideas what may be wrong?  
I apologize is this is a USB issue and not a Linux issue, but I want to 
rule that out.

The log below has two packets expanded.  The first one is received in 
the omap_udc irq.  The next one (and the two retries) is not.


<7>udc: SETUP 00.09 v0001 i0000 l0000
<7>udc: SETUP 01.0b v0000 i0001 l0000
<7>udc: SETUP 01.0b v0000 i0002 l0000
<7>udc: SETUP 80.06 v0305 i0409 l00ff
<7>udc: SETUP 80.06 v0308 i0409 l00ff
<7>udc: SETUP 80.06 v0300 i0000 l00ff
<7>udc: SETUP 80.06 v0305 i0409 l00ff
<7>udc: SETUP 01.0b v0000 i0001 l0000
<7>udc: SETUP 01.0b v0000 i0002 l0000
<7>udc: SETUP 21.0a v0000 i0003 l0000

1    in down    n/a    0.001    GET_DESCRIPTOR_FROM_DEVICE        
1    in up    n/a    0.007    CONTROL_TRANSFER    12 01 01 01 00 00 00 
40    0x00000000
2    in down    n/a    0.007    GET_DESCRIPTOR_FROM_DEVICE        
2    in up    n/a    0.012    CONTROL_TRANSFER    09 02 c7 00 04 01 04 
e0    0x00000000
3    in down    n/a    0.012    GET_DESCRIPTOR_FROM_DEVICE        
3    in up    n/a    0.020    CONTROL_TRANSFER    09 02 c7 00 04 01 04 
e0    0x00000000
4    ??? down    n/a    0.020    SELECT_CONFIGURATION        
4    ??? up    n/a    0.062    SELECT_CONFIGURATION        0x00000000
6    in down    n/a    0.062    GET_DESCRIPTOR_FROM_DEVICE        
6    in up    n/a    0.069    CONTROL_TRANSFER    24 03 31 00 30 00 30 
00    0x00000000
7    in down    n/a    0.070    GET_DESCRIPTOR_FROM_DEVICE        
7    in up    n/a    0.077    CONTROL_TRANSFER    1c 03 31 00 30 00 30 
00    0x00000000
8    in down    n/a    0.079    GET_DESCRIPTOR_FROM_DEVICE        
8    in up    n/a    0.085    CONTROL_TRANSFER    04 03 09 04    0x00000000
9    in down    n/a    0.085    GET_DESCRIPTOR_FROM_DEVICE        
9    in up    n/a    0.092    CONTROL_TRANSFER    24 03 31 00 30 00 30 
00    0x00000000
10    inout down    n/a    0.092    SELECT_INTERFACE        
10    inout up    n/a    0.100    SELECT_INTERFACE        0x00000000
11    inout down    n/a    0.100    SELECT_INTERFACE        
11    inout up    n/a    0.108    SELECT_INTERFACE        0x00000000
12    out down    n/a    0.109    CLASS_INTERFACE    -    
12    out up    n/a    0.115    CONTROL_TRANSFER    -    0x00000000
URB Header (length: 80)
SequenceNumber: 12
Function: 0008 (CONTROL_TRANSFER)
PipeHandle: 8895ca20

SetupPacket:
0000: 21 0a 00 00 03 00 00 00
bmRequestType: 21
  DIR: Host-To-Device
  TYPE: Class
  RECIPIENT: Interface
bRequest: 0a  


No TransferBuffer

13    in down    n/a    0.115    GET_DESCRIPTOR_FROM_INTERFACE        
13    in up    n/a    0.116    CONTROL_TRANSFER        0xc0000004
URB Header (length: 80)
SequenceNumber: 13
Function: 0008 (CONTROL_TRANSFER)
PipeHandle: 8895ca20

SetupPacket:
0000: 81 06 00 22 03 00 60 00
bmRequestType: 81
  DIR: Device-To-Host
  TYPE: Standard
  RECIPIENT: Interface
bRequest: 06  
  GET_DESCRIPTOR
Descriptor Type: 0x0022
  unknown


TransferBuffer: 0x00000000 (0) length
14    in down    n/a    0.116    GET_DESCRIPTOR_FROM_INTERFACE        
14    in up    n/a    0.117    CONTROL_TRANSFER        0xc0000004
15    in down    n/a    0.117    GET_DESCRIPTOR_FROM_INTERFACE        
15    in up    n/a    0.118    CONTROL_TRANSFER        0xc0000004
4398    out down    n/a    0.226    CLASS_INTERFACE    -    
4398    in up    n/a    0.227    CONTROL_TRANSFER    01    0x00000000
4399    out down    n/a    0.227    CLASS_INTERFACE    -    
4399    in up    n/a    0.229    CONTROL_TRANSFER    01    0x00000000
4400    out down    n/a    0.229    CLASS_INTERFACE    -    
4400    in up    n/a    0.230    CONTROL_TRANSFER        0xc0000004
