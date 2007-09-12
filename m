From: "Nazim Khan" <nazim.asad@gmail.com>
Subject: USB WiFi issue: EndPoint Stall Error during firmware upload.
Date: Wed, 12 Sep 2007 10:27:59 +0530
Message-ID: <ef9503490709112157i94580b5te98f7d715a496ffd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I am trying to bring up the USB Wireless Zydas driver of 2.6.18 kernel
on Davinci.
The firmware upload is failing with ENDPOINT Stall Error.
Any clue as to what could be the problem.

Following the snapshot of the console to give more insight into the problem.
-------------------- Console Snapshot---------------------------
<7>usb 1-1: new device strings: Mfr=16, Product=32, SerialNumber=0
<6>usb 1-1: Product: USB2.0 WLAN
<6>usb 1-1: Manufacturer: ZyDAS
<7>DEV: registering device: ID = '1-1'
<7>bus usb: add device 1-1
<7>usb 1-1: uevent
<7>bound device '1-1' to driver 'usb'
<7>DEV: registering device: ID = 'usbdev1.2_ep00'
<6>usb 1-1: configuration #1 chosen from 1 choice
<7>musb_ep_program 649: --> hw0 urb c3527f20 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
<7>musb_h_ep0_irq 1050: <== csr0 0200, qh c35615e0, count 0, urb
c3527f20, stage 0
<7>musb_h_ep0_irq 1145: ep0 STATUS, csr 0060
<7>musb_h_ep0_irq 1050: <== csr0 0041, qh c35615e0, count 0, urb
c3527f20, stage 8
<7>usb 1-1: adding 1-1:1.0 (config #1, interface 0)
<7>DEV: registering device: ID = '1-1:1.0'
<7>bus usb: add device 1-1:1.0
<7>usb 1-1:1.0: uevent
<7>DEV: registering device: ID = 'usbdev1.2_ep01'
<7>DEV: registering device: ID = 'usbdev1.2_ep82'
<7>DEV: registering device: ID = 'usbdev1.2_ep83'
<7>DEV: registering device: ID = 'usbdev1.2_ep04'
<7>CLASS: registering class device: ID = 'usbdev1.2'
<7>class_uevent - name = usbdev1.2
<7>class_device_create_uevent called for usbdev1.2
<7>drivers/usb/core/inode.c: creating file '002'
<7>hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
<7>musb_hub_control 266: port status 00020503
<7>hub 1-0:1.0: port 1 enable change, status 00000503
<7>usb_init()
<7>bus usb: add driver zd1211rw
<7>usb: Matched Device 1-1:1.0 with Driver zd1211rw
<7>zd1211rw 1-1:1.0: usb_probe_interface
<7>zd1211rw 1-1:1.0: usb_probe_interface - got id
<7>usb 1-1: print_id() 0ace:1215 v4810 high
<7>zd1211rw 1-1:1.0: zd_netdev_alloc() netdev->flags 0x1002
<7>zd1211rw 1-1:1.0: zd_netdev_alloc() netdev->features 0x00000000
<7>usb 1-1: request_fw_file() fw name zd1211/zd1211b_ub
<7>CLASS: registering class device: ID = '1-1'
<7>class_uevent - name = 1-1
<7>class->uevent() returned -19
<7>class_uevent - name = 1-1
<7>CLASS: Unregistering class device. ID = '1-1'
<7>class_uevent - name = 1-1
<7>usb 1-1: upload_firmware() firmware device id 0x4810 is equal to
the actual device id
<7>usb 1-1: request_fw_file() fw name zd1211/zd1211b_uphr
<7>CLASS: registering class device: ID = '1-1'
<7>class_uevent - name = 1-1
<7>class->uevent() returned -19
<7>class_uevent - name = 1-1
<7>device class '1-1': release.
<7>CLASS: Unregistering class device. ID = '1-1'
<7>class_uevent - name = 1-1
<7>usb 1-1: upload_code() Total firmware size 5120
<7>usb 1-1: upload_code() transfer size 4096
<7>musb_ep_program 649: --> hw0 urb c3527ce0 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
<7>musb_h_ep0_irq 1050: <== csr0 0200, qh c39f1160, count 0, urb
c3527ce0, stage 0
<7>musb_h_ep0_continue 1013: Sending 64 bytes to c0015000 actual 0
<7>musb_h_ep0_irq 1050: <== csr0 0000, qh c39f1160, count 0, urb
c3527ce0, stage 2
<7>musb_h_ep0_continue 1013: Sending 64 bytes to c0015040 actual 64
<7>musb_h_ep0_irq 1050: <== csr0 0200, qh c39f1160, count 0, urb
c3527ce0, stage 2
<7>musb_h_ep0_continue 1013: Sending 64 bytes to c0015080 actual 128
             ....................   continue ...............................
<7>musb_h_ep0_continue 1013: Sending 64 bytes to c0015f40 actual 3904
<7>musb_h_ep0_irq 1050: <== csr0 0200, qh c39f1160, count 0, urb
c3527ce0, stage 2
<7>musb_h_ep0_continue 1013: Sending 64 bytes to c0015f80 actual 3968
<7>musb_h_ep0_irq 1050: <== csr0 0000, qh c39f1160, count 0, urb
c3527ce0, stage 2
<7>musb_h_ep0_continue 1013: Sending 64 bytes to c0015fc0 actual 4032
<7>musb_h_ep0_irq 1050: <== csr0 0200, qh c39f1160, count 0, urb
c3527ce0, stage 2
<7>musb_h_ep0_irq 1145: ep0 STATUS, csr 0002
<7>musb_h_ep0_irq 1050: <== csr0 0204, qh c39f1160, count 0, urb
c3527ce0, stage 8
<7>musb_h_ep0_irq 1060: STALLING ENDPOINT
<7>musb_h_ep0_irq 1082: aborting
<7>__musb_giveback 285: complete c3527ce0 (-32), dev2 ep0out, 4096/4096
<3>usb 1-1: USB control request for firmware upload failed. Error number -32
<3>usb 1-1: Could not upload firmware code uph. Error number -32
<3>zd1211rw 1-1:1.0: couldn't load firmware. Error number -32
