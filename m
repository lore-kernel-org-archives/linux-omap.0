From: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC] [PATCH 6/7] usb: ehci: Introduce CONFIG_USB_EHCI_HCD_OMAP3
Date: Wed, 20 Oct 2010 12:30:59 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014FB3A233@dlee02.ent.ti.com>
References: <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
 <20100820054507.GE15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B65@dbde02.ent.ti.com>
 <20100820061322.GG15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222BA9@dbde02.ent.ti.com>
 <20100820091336.GC31377@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100820091336.GC31377-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> [mailto:linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Felipe Balbi
> Sent: Friday, August 20, 2010 4:14 AM
> To: Gadiyar, Anand
> Cc: Balbi Felipe (Nokia-MS/Helsinki); Munegowda, Keshava; 
> linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [RFC] [PATCH 6/7] usb: ehci: Introduce 
> CONFIG_USB_EHCI_HCD_OMAP3
> 
> On Fri, Aug 20, 2010 at 08:32:04AM +0200, ext Gadiyar, Anand wrote:
> >We have the ability to support OMAP2 and OMAP3 in the same kernel
> >image (for example when you build with omap3_defconfig).
> >
> >So USB_ARCH_HAS_EHCI will get selected due to OMAP3 being present.
> >
> >However, no platform devices will be registered in the OMAP2 
> board files,
> >so this should be okay (will try this on OMAP2 to check).
> 
> correct :-) so it shouldn't be a problem the driver won't try 
> to probe.
> 
Curious - Oct 20th now - 2 months? - any chance of seeing a non RFC patch to 
l-o for the same?
https://patchwork.kernel.org/project/linux-omap/list/?page=1 does not show
me a refreshed patchset that will apply anymore.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
