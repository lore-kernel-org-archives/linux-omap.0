From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N800 - USB Host mode issues
Date: Wed, 11 Jul 2007 04:03:20 -0700
Message-ID: <20070711110313.GD19166@atomide.com>
References: <468535CE.5070401@gmx.net> <20070703092628.GA7062@atomide.com>
	<20070703202003.4v0diwdzvqnsw4ws@webmail.caflor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070703202003.4v0diwdzvqnsw4ws@webmail.caflor.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: robert.vogt@caflor.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* robert.vogt@caflor.net <robert.vogt@caflor.net> [070708 15:10]:
> Hi Tony,
>
> The new patches seem to be working much better for me.  Now when I enter 
> host
> mode, I get 5V out consistently, and it is at least able to see (and 
> power!)
> the device.  I am not sure how to load the usb-serial driver, however (do I
> need to unload the gadget driver?), as it should be compiled-in to the
> kernel... (or do I need to add the device to the appropriate device 
> driver's
> support table?)

Nice to hear it's working better now :) You can keep g_file_storage
loaded while using it in host mode with serial driver. But if you want
to use g_serial, you must unload g_file_storage.

> Here is what I'm seeing as I plug in the device...
>
> Nokia-N800-10:/proc/driver# cat musb_hdrc
> Status: MHDRC, Mode=Host (Power=e0, DevCtl=19)
> OTG state: a_wait_bcon; inactive
> Options: tusb-omap-dma, otg (peripheral+host), debug=1 [eps=16]
> Peripheral address: c0
> Root port status: 00000100
> TUSB6010: devconf c0010001, phy enable 00800000 drive 0000000a
>        otg 174 timer 005b8d80
>        prcm conf 00000000 mgmt 00a80300; int src 0000a000 mask 00000008
> Gadget driver: g_file_storage
>
> ----- plug in USB-Serial Device -----
>
> Nokia-N800-10:/proc/driver# cat musb_hdrc
> Status: MHDRC, Mode=Host (Power=e0, DevCtl=5d)
> OTG state: a_host; active
> Options: tusb-omap-dma, otg (peripheral+host), debug=1 [eps=16]
> Peripheral address: c0
> Root port status: 00000101
> TUSB6010: devconf c0010001, phy enable 00800000 drive 0000000a
>        otg 171 timer 005b8d80
>        prcm conf 00010000 mgmt 00a80300; int src 00000000 mask 00000008
> Gadget driver: g_file_storage
>
> ----- Sometimes: ------
> Nokia-N800-10:/proc/driver# dmesg -c
> [ 2988.626434] musb_stage0_irq 598: CONNECT (a_host) devctl 5d
> [ 2988.626525] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
> [ 2988.626617] hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
> [ 2988.782623] hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms 
> status
> 0x101
> [ 2988.907653] usb 1-1: new full speed USB device using musb_hdrc and 
> address 8
> [ 2989.032623] usb 1-1: device descriptor read/64, error -71
> [ 2989.266998] usb 1-1: device descriptor read/64, error -71
> [ 2989.501373] usb 1-1: new full speed USB device using musb_hdrc and 
> address 9
> [ 2989.626373] usb 1-1: device descriptor read/64, error -71
> [ 2989.859588] usb 1-1: device descriptor read/64, error -71
> [ 2990.095153] usb 1-1: new full speed USB device using musb_hdrc and 
> address 10
> [ 2990.516967] usb 1-1: device not accepting address 10, error -71
> [ 2990.642028] usb 1-1: new full speed USB device using musb_hdrc and 
> address 11
> [ 2991.063934] usb 1-1: device not accepting address 11, error -71
> [ 2991.064056] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
> [ 2991.064117] hub 1-0:1.0: port 1 enable change, status 00000101
>
> ----- And sometimes: ------
> Nokia-N800-10:/proc/driver# dmesg -c
> [ 3760.898742] musb_stage0_irq 598: CONNECT (a_host) devctl 5d
> [ 3760.898895] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
> [ 3760.899017] hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
> [ 3761.056060] hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms 
> status
> 0x101
> [ 3761.181121] usb 1-1: new full speed USB device using musb_hdrc and 
> address 16
> [ 3761.306060] usb 1-1: device descriptor read/64, error -71
> [ 3761.540466] usb 1-1: device descriptor read/64, error -71
> [ 3761.774841] usb 1-1: new full speed USB device using musb_hdrc and 
> address 17
> [ 3761.837341] musb_stage0_irq 615: BABBLE devctl: 5d
> [ 3761.899841] usb 1-1: device descriptor read/64, error -71
> [ 3762.142059] usb 1-1: device descriptor read/64, error -71
> [ 3762.384185] usb 1-1: new full speed USB device using musb_hdrc and 
> address 18
> [ 3762.806091] usb 1-1: device not accepting address 18, error -71
> [ 3762.929870] usb 1-1: new full speed USB device using musb_hdrc and 
> address 19
> [ 3762.953948] usb 1-1: ep0 maxpacket = 8
> [ 3762.959594] usb 1-1: skipped 4 descriptors after interface
> [ 3762.960327] usb 1-1: default language 0x0409
> [ 3762.964538] usb 1-1: new device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [ 3762.964569] usb 1-1: Product: OBD-II Device Interface
> [ 3762.964599] usb 1-1: Manufacturer: ArborHost.com Consulting
> [ 3762.964660] usb 1-1: device v04d8 p000a is not supported
> [ 3762.964843] usb 1-1: uevent
> [ 3762.965301] usb 1-1: configuration #1 chosen from 1 choice
> [ 3762.965515] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
> [ 3762.965667] usb 1-1:1.0: uevent
> [ 3762.966003] usbtest 1-1:1.0: usb_probe_interface
> [ 3762.966033] usbtest 1-1:1.0: usb_probe_interface - got id
> [ 3762.966400] usb 1-1: adding 1-1:1.1 (config #1, interface 1)
> [ 3762.966552] usb 1-1:1.1: uevent
> [ 3762.966857] usbtest 1-1:1.1: usb_probe_interface
> [ 3762.966918] usbtest 1-1:1.1: usb_probe_interface - got id
> [ 3762.967529] drivers/usb/core/inode.c: creating file '019'
> [ 3762.967620] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
> [ 3762.967681] hub 1-0:1.0: port 1 enable change, status 00000103

Sounds like there is still some flakeyness detecting devices, but it
also seems your serial device needs to be added to the known devices
list if it works with some known driver.

Regards,

Tony
