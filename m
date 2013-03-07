From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Thu, 07 Mar 2013 13:51:48 +0100
Message-ID: <51388D64.9000005@gmail.com>
References: <cover.1351870620.git.afzal@ti.com> <509420D8.1030307@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com> <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk> <5133E268.5010604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5133E268.5010604-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04.03.2013 00:53, Daniel Mack wrote:
> Hi Peter,
> 
> On 03.03.2013 23:24, Peter Korsgaard wrote:
>>>>>>> "Daniel" == Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>
>> Hi,
>>
>>  Daniel> On my board, the USB is purely used as host interface, with a
>>  Daniel> type B plug soldered. In the DT, I'm using the following
>>  Daniel> sniplet in accordance to the documentation of the bindings:
>>
>>  Daniel> 	usb_otg_hs: usb@47400000 {
>>  Daniel> 		compatible = "ti,musb-am33xx";
>>  Daniel> 		reg = <0x47400000 0x1000	/* usbss */
>>  Daniel> 		       0x47401000 0x800		/* musb instance 0 */
>>  Daniel> 		       0x47401800 0x800>;	/* musb instance 1 */
>>  Daniel> 		interrupt-parent = <&intc>;
>>  Daniel> 		interrupts = <17		/* usbss */
>>  Daniel> 			      18		/* musb instance 0 */
>>  19> ;		/* musb instance 1 */
>>  Daniel> 		multipoint = <1>;
>>  Daniel> 		num-eps = <16>;
>>  Daniel> 		ram-bits = <12>;
>>  Daniel> 		port0-mode = <3>;
>>  Daniel> 		port1-mode = <3>;
>>  Daniel> 		power = <250>;
>>  Daniel> 		ti,hwmods = "usb_otg_hs";
>>  Daniel> 	};
>>
>>  Daniel> The relevant config options are
>>
>>  Daniel> CONFIG_USB_MUSB_HDRC=y
>>  Daniel> # CONFIG_USB_MUSB_TUSB6010 is not set
>>  Daniel> # CONFIG_USB_MUSB_OMAP2PLUS is not set
>>  Daniel> # CONFIG_USB_MUSB_AM35X is not set
>>  Daniel> CONFIG_USB_MUSB_DSPS=y
>>  Daniel> CONFIG_MUSB_PIO_ONLY=y
>>  Daniel> CONFIG_USB_GADGET=y
>>  Daniel> CONFIG_USB_GADGET_DEBUG=y
>>  Daniel> CONFIG_USB_GADGET_DEBUG_FILES=y
>>  Daniel> CONFIG_USB_GADGET_DEBUG_FS=y
>>  Daniel> CONFIG_USB_GADGET_VBUS_DRAW=2
>>  Daniel> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
>>  Daniel> CONFIG_USB_GADGET_MUSB_HDRC=y
>>
>> Ehh, I'm confused here. You talk about host mode, a single 'B' (gadget)
>> connector
> 
> I'm sorry for the confusion caused. This is a stupid mistake - I'm in
> fact talking about an 'A' type plug of course (host mode).
> 
>> and your device tree mentions 2 OTG ports.
> 
> That's what I said in a follow up - the same happens for mode '1'.
> 
>> What is the configuration exactly?
> 
> Again to summarize: host-only mode, type 'A' plug.
> 
> The gadget driver is is enabled in the config because the only
> occurrence of usb_add_hcd() in the musb driver is in the gagdget part,
> so supposedly, there has to be a gadget driver loaded in order to make
> the host interface going.

Just be clear: I'd happily help and dig for the reason of this, I'd just
need to know how things are _supposed_ to work ...


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
