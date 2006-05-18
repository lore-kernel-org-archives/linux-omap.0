From: theresa tan <ther_joy@yahoo.com>
Subject: can't read configurations for rt2570
Date: Thu, 18 May 2006 04:57:39 -0700 (PDT)
Message-ID: <20060518115739.52182.qmail@web32111.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

I tried to build omap kernel 2.6.16 with rt2570. When I plugged in the Linksys Wireless G network adapter via a usb hub, I got the following errors:
   

T25usb  Driver version 2.0.6  RTUSB  <7>--> NICInitTransmit  RTUSB  <7>--> NICInitRecv  RTUSB  <7><-- NICInitRecv  RTUSB  <7>--> NICInitializeAsic  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7> !!!!!set Rx control = 1  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB
   <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB 
 <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest  ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-110,  usb 1-1.1: USB disconnect, address 3  RTUSB  <7>USBVendorRequest failed ret=-110,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19
 ,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed
 ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,  RTUSB  <7>USBVendorRequest failed ret=-19,    if I disabled the debug messages for the rt2570 driver, i got the following:

/ # hub 1-1:1.0: hub_port_status failed (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?  hub 1-1:1.0: cannot disable port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?  hub 1-1:1.0: cannot disable port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1
 :1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: Cannot enable port 1.  Maybe the
 USB cable is bad?  hub 1-1:1.0: cannot disable port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: cannot reset port 1 (err = -110)  hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?  hub 1-1:1.0: cannot disable port 1 (err = -110)  hub 1-1:1.0: cannot disable port 1 (err = -110)  usb 1-1: reset full speed USB device using ohci and address 2  usb 1-1: device firmware changed  usb 1-1: USB disconnect, address 2  usb 1-1: new full speed USB device using ohci and address 7  usb 1-1: device descriptor read/all, error -110  usb 1-1: new full speed USB device using ohci and address 8  usb 1-1: configuration #1 chosen from 1 choice  usb 1-1: can't set config #1, error -110    Is there someone who had used a rt257
 0 driver in omap? I need your help.

 

Thanks,

ther

		
---------------------------------
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rates starting at 1&cent;/min.
