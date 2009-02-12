From: David Brownell <david-b@pacbell.net>
Subject: Re: omap_apollon_2420_defconfig
Date: Wed, 11 Feb 2009 22:31:12 -0800
Message-ID: <200902112231.12887.david-b@pacbell.net>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk> <20090209205319.GH14200@atomide.com> <9c9fda240902091754q7f723bf2ha46206e52641297b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:22268 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751110AbZBLGbP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Feb 2009 01:31:15 -0500
In-Reply-To: <9c9fda240902091754q7f723bf2ha46206e52641297b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>, Greg KH <greg@kroah.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Monday 09 February 2009, Kyungmin Park wrote:
> Hi,
> 
> In the previous patch, it's only fixed host side. But apollon case, it
> only used udc, so udc configuration should select USB_OTG_UTILS also.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

... Greg, this should be a 2.6.29-rc patch (buildfix).

> ---
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 3219d13..b26d6e6 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -191,6 +191,7 @@ config USB_GADGET_OMAP
>  	boolean "OMAP USB Device Controller"
>  	depends on ARCH_OMAP
>  	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
> +	select USB_OTG_UTILS if ARCH_OMAP
>  	help
>  	   Many Texas Instruments OMAP processors have flexible full
>  	   speed USB device controllers, with support for up to 30
> 
> 
> On Tue, Feb 10, 2009 at 5:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090209 11:27]:
> >> It would be nice to get the last OMAP defconfig in mainline working.
> >> It's broken since 2.6.29-rc2-git3 due to this persistent problem:
> >>
> >> drivers/built-in.o: In function `omap_udc_probe':
> >> omap.c:(.init.text+0x30cc): undefined reference to `otg_get_transceiver'
> >> omap.c:(.init.text+0x38a4): undefined reference to `otg_put_transceiver'
> >
> > Hmm, looks like 2bf5fa13fc8e34d7b86307b99f64a24cb7a83852 did not fix it.
> > Dave, do you already have a patch for this?
> >
> > Regards,
> >
> > Tony
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


