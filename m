From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Fri, 01 Mar 2013 22:57:04 +0100
Message-ID: <51312430.6060306@gmail.com>
References: <cover.1351870620.git.afzal@ti.com>,<509420D8.1030307@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Afzal, everyone,

On 03.11.2012 08:33, Mohammed, Afzal wrote:
> * Daniel Mack, November 03, 2012 1:06 AM:
> 
>> I'm testing these patches with an AM33xx board that has the first musb
>> port wired to an USB type A plug, but it doesn't yet work for me.
> 
>> So there is no host interface registered. I'm unsure on how to fix this,
>> and I didn't get an answer yet to that question when I asked Felipe
>> about how interface drivers like dsps are supposed to act in order to
>> get host mode back after the recent musb cleanups.
> 
>> What type of hardware do you test this with? Does host mode work for you?
> 
> To add to those details mentioned by Ravi,
> 
> This was tested on Beagle Bone with USB0 as usb-ethernet.
> 
> For purely Kernel part, this series is sufficient (along with
> dependency mentioned in cover letter), considering
> the fact that dt node is strictly not a part of Kernel.
> 
> To test this series, node for usbss should be present in dt.
> Example in dt documentation can be pasted onto dtsi file
> to get USB0 working.

I have to pick up this old thread because I'm still having trouble
understanding how the AM335x musb driver is meant to be used as HCD.

I used to have it working based on 3.7 with a terrible hack that reverts
a couple of old commits partly. Now I started over with a fresh setup
based on Linus' current soon-to-be 3.9-rc tip, actually hoping that the
issues are solved.

On my board, the USB is purely used as host interface, with a type B
plug soldered. In the DT, I'm using the following sniplet in accordance
to the documentation of the bindings:

	usb_otg_hs: usb@47400000 {
		compatible = "ti,musb-am33xx";
		reg = <0x47400000 0x1000	/* usbss */
		       0x47401000 0x800		/* musb instance 0 */
		       0x47401800 0x800>;	/* musb instance 1 */
		interrupt-parent = <&intc>;
		interrupts = <17		/* usbss */
			      18		/* musb instance 0 */
			      19>;		/* musb instance 1 */
		multipoint = <1>;
		num-eps = <16>;
		ram-bits = <12>;
		port0-mode = <3>;
		port1-mode = <3>;
		power = <250>;
		ti,hwmods = "usb_otg_hs";
	};

The relevant config options are

CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_OMAP2PLUS is not set
# CONFIG_USB_MUSB_AM35X is not set
CONFIG_USB_MUSB_DSPS=y
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_USB_GADGET_MUSB_HDRC=y
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_MIDI_GADGET is not set
CONFIG_USB_ZERO=m

At boot time, I only see the following message:

[    1.534776] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)

And when g_zero.ko is loaded, I get:

[   12.137023] udc musb-hdrc.0.auto: registering UDC driver [zero]
[   12.196906]  gadget: adding 'source/sink'/cec4e840 to config
'source/sink'/bf00d544
[   12.205800]  gadget: dual speed source/sink: IN/ep1in, OUT/ep1out,
ISO-IN/ep13, ISO-OUT/ep14
[   12.215862]  gadget: adding 'loopback'/cec4e7c0 to config
'loopback'/bf00d5b8
[   12.224321]  gadget: dual speed loopback: IN/ep1in, OUT/ep1out
[   12.231323]  gadget: Gadget Zero, version: Cinco de Mayo 2008
[   12.238164]  gadget: zero ready
[   12.242250] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[   12.249111] musb-hdrc musb-hdrc.0.auto: new USB bus registered,
assigned bus number 1
[   12.258151] musb-hdrc musb-hdrc.0.auto: supports USB remote wakeup
[   12.265507] usb usb1: default language 0x0409
[   12.271007] usb usb1: udev 1, busnum 1, minor = 0
[   12.276699] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   12.284632] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   12.292992] usb usb1: Product: MUSB HDRC host driver
[   12.298959] usb usb1: Manufacturer: Linux 3.8.0-10238-gbfbdcec-dirty
musb-hcd
[   12.307166] usb usb1: SerialNumber: musb-hdrc.0.auto
[   12.323645] usb usb1: no of_node; not parsing pinctrl DT
[   12.330172] usb usb1: usb_probe_device
[   12.335181] usb usb1: configuration #1 chosen from 1 choice
[   12.342090] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[   12.355237] hub 1-0:1.0: no of_node; not parsing pinctrl DT
[   12.361988] hub 1-0:1.0: usb_probe_interface
[   12.367497] hub 1-0:1.0: usb_probe_interface - got id
[   12.373774] hub 1-0:1.0: USB hub found
[   12.378631] hub 1-0:1.0: 1 port detected
[   12.383515] hub 1-0:1.0: standalone hub
[   12.388330] hub 1-0:1.0: individual port power switching
[   12.394599] hub 1-0:1.0: no over-current protection
[   12.400497] hub 1-0:1.0: Single TT
[   12.404770] hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
[   12.412203] hub 1-0:1.0: power on to power good time: 10ms
[   12.418776] hub 1-0:1.0: local power source is good
[   12.424812] hub 1-0:1.0: enabling power on all ports
[   12.527985] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   12.533836] hub 1-0:1.0: hub_suspend
[   12.537634] usb usb1: bus auto-suspend, wakeup 1

... but lsusb only shows the root hub, not the device which is connected
to the plug.

Also, when statically compiled into the kernel, the zero gadget driver
fails initialization with error code -2, but that's probably a whole
different story. Eventually, what I need is USB host support without
loading any module, as I boot the rootfs from USB under some circumstances.

I'm not sure what I'm missing here. Is there anything that needs extra
configuration to get this going? Is it worth debugging this deeper, or
is anyone else facing the same problem?


Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
