From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
Date: Wed, 24 Feb 2010 09:39:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C42E167D@dbde02.ent.ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C417FA42@dbde02.ent.ti.com>
 <20100222213932.GW18786@atomide.com> <20100222230712.GB18786@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E1174@dbde02.ent.ti.com>
 <20100223231225.GL28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38200 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407Ab0BXEJf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 23:09:35 -0500
In-Reply-To: <20100223231225.GL28173@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, February 24, 2010 4:42 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Woodruff, Richard; Ghorai,
> Sukumar
> Subject: Re: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100222 23:16]:
> > Tony,
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Tuesday, February 23, 2010 4:37 AM
> > > To: Shilimkar, Santosh
> > > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Woodruff, Richard; Ghorai,
> > > Sukumar
> > > Subject: Re: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
> > >
> > > * Tony Lindgren <tony@atomide.com> [100222 13:35]:
> > > > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100218 21:22]:
> > > > > Bye the way just to add bit more clarity, this patch addresses TX
> > > > > hardware restriction in the new UART IP used on omap3630 and omap4430.
> > > > > First part of the fix for RX is already in mainline,
> > > > > Commit: "ce13d4716a276f4331d78ba28a5093a63822ab95"
> > > > >
> > > > > More details on this thread are here.
> > > > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19447.html
> > > >
> > > > Thanks, I've updated the comments for this patch with the link above
> > > > and added the whole series into omap for-next.
> > >
> > > Except patches 8 and 9 as they break compile for mach-omap1
> > > and need to be updated.
> > >
> > Patch 8 is alright and doesn't break omap1. Patch 7 and patch 9 needs update to fix
> > the mach-omap1 build issue by moving irqs-44xx.h header file to plat-omap directory.
> > Attached are updated 7 and 9.
> > Build tested for omap1 (omap_generic_1710_defconfig and omap_h2_1610_defconfig) and boot
> > tested with omap3_defconfig on omap4430sdp board.
> 
> Next time, one patch per email please. And updates as replies
> to the original patches, or else the whole series. And patches
> as inline attachments.
> 
> Otherwise it's hard to keep track of the patches and comment
> them.
> 
Ok. Will take care next time.
> I've updated your patch 9/9 with the following as in omap for-next
> I was getting:
> 
> arch/arm/mach-omap2/usb-musb.c:97: Building for omap_3430sdp_defconfigred (first use in this
> function)                                                              Building for
> omap_3630sdp_defconfigch-omap2/usb-musb.c:97: error: (Each undeclared identifier is reported only
> once
> arch/arm/mach-omap2/usb-musb.c:97: error: for each function it appears in.)
> arch/arm/mach-omap2/usb-musb.c:98: error: 'INT_44XX_HS_USB_DMA' undeclared (first use in this
> function)
> 
Looks like musb is also merged now. My yesterday's pull of omap-for-linus didn't have musb.

> Regards,
> 
> Tony
> 
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -94,8 +94,8 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
>  		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
>  	} else if (cpu_is_omap44xx()) {
>  		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
> -		musb_resources[1].start = INT_44XX_HS_USB_MC;
> -		musb_resources[2].start = INT_44XX_HS_USB_DMA;
> +		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
> +		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
>  	}
>  	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
> 
Thanks for fixing this.

Regards,
Santosh
