From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Thu, 11 Aug 2011 15:20:24 +0300
Message-ID: <1313065224.2407.857.camel@cumari>
References: <1307356643.23002.413.camel@cumari>
	 <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
	 <20110606110218.GS18731@legolas.emea.dhcp.ti.com>
	 <1307358348.23002.419.camel@cumari> <1312889168.2407.148.camel@cumari>
	 <CAK=WgbatbaSj=U7+SAva4Woh7uaOoCzQck5yjfLvVGLR-UCVHg@mail.gmail.com>
	 <4E43C41E.1080808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E43C41E.1080808-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-08-11 at 17:29 +0530, Rajendra Nayak wrote:
> On 8/11/2011 1:37 PM, Ohad Ben-Cohen wrote:
> > + Paul, Benoit, Rajendra
> >
> > On Tue, Aug 9, 2011 at 2:26 PM, Luciano Coelho<coelho-l0cyMroinI0@public.gmane.org>  wrote:
> >> I'm again getting a very similar oops with 3.1-rc1 on my pandaboard:
> >>
> >> [    2.054351] usbcore: registered new interface driver cdc_ncm
> >> [    2.061431] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> >> [    2.068664] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> >> [    2.076110] Internal error: : 1406 [#1] SMP
> >> [    2.080505] Modules linked in:
> >> [    2.083709] CPU: 0    Not tainted  (3.1.0-rc1-wl+ #283)
> >> [    2.089233] PC is at omap_usbhs_enable+0x148/0x590
> >> [    2.094299] LR is at trace_hardirqs_off+0x14/0x18
> > ...
> >> [    2.310150] [<c02a8640>] (omap_usbhs_enable+0x148/0x590) from [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568)
> >> [    2.320526] [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568) from [<c0298cfc>] (platform_drv_probe+0x24/0x28)
> >> [    2.330780] [<c0298cfc>] (platform_drv_probe+0x24/0x28) from [<c0297650>] (driver_probe_device+0x158/0x27c)
> >> [    2.341033] [<c0297650>] (driver_probe_device+0x158/0x27c) from [<c02977ec>] (__driver_attach+0x78/0x9c)
> >> [    2.351043] [<c02977ec>] (__driver_attach+0x78/0x9c) from [<c0296c00>] (bus_for_each_dev+0x5c/0x8c)
> >> [    2.360565] [<c0296c00>] (bus_for_each_dev+0x5c/0x8c) from [<c0297334>] (driver_attach+0x28/0x30)
> >> [    2.369903] [<c0297334>] (driver_attach+0x28/0x30) from [<c02963ec>] (bus_add_driver+0xd8/0x260)
> >> [    2.379180] [<c02963ec>] (bus_add_driver+0xd8/0x260) from [<c0297f00>] (driver_register+0xb8/0x144)
> >> [    2.388702] [<c0297f00>] (driver_register+0xb8/0x144) from [<c02991e0>] (platform_driver_register+0x54/0x68)
> >> [    2.399047] [<c02991e0>] (platform_driver_register+0x54/0x68) from [<c069904c>] (ehci_hcd_init+0xa8/0xfc)
> >> [    2.409149] [<c069904c>] (ehci_hcd_init+0xa8/0xfc) from [<c0008854>] (do_one_initcall+0xa8/0x17c)
> >> [    2.418487] [<c0008854>] (do_one_initcall+0xa8/0x17c) from [<c06792d4>] (kernel_init+0x88/0x134)
> >> [    2.427764] [<c06792d4>] (kernel_init+0x88/0x134) from [<c0014ba0>] (kernel_thread_exit+0x0/0x8)
> >
> > I get this too.
> >
> >> Any clues?
> 
> Its quite expected as omap_usbhs_enable() still relies on clock
> framework to enable the clocks.
> Any driver still using clock framework on OMAP4 to enable "main" clocks
> is expected to be broken. The only way to fix this is to adapt
> the driver to runtime PM.

Well, this is a regression in 3.1 and must be fixed.  It's probably too
late to make big changes in the usbhs driver, so probably the change in
OMAP that broke this should be reverted.

-- 
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
