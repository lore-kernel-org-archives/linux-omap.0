From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: EHCI: Wrong ehci init for 2430
Date: Tue, 29 Apr 2008 17:28:52 -0700
Message-ID: <20080430002851.GE8981@atomide.com>
References: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com> <1209370114-17007-2-git-send-email-jarkko.nikula@nokia.com> <20080428094833.GA4357@gandalf.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC3560872F72C95A@dbde02.ent.ti.com> <20080428103120.GB4357@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64089 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbYD3A25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 20:28:57 -0400
Content-Disposition: inline
In-Reply-To: <20080428103120.GB4357@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "ext Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [080428 03:37]:
> On Mon, Apr 28, 2008 at 03:51:11PM +0530, ext Pandita, Vikram wrote:
> > OMAP2430 does not have USB EHCI controller.
> > EHCI core was introduced with OMAP3430 ES2.0 onwards.
> > The ehci_init() call has been wrongly introduced for OMAP2430, so removing it.
> 
> Good, I was unsure about it and that's why I asked people to give the
> original patch a good review. Seems that this one came too late.
> 
> Anyway, good that you saw it :-)

Pushing today.

Tony

> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-2430sdp.c |    2 --
> >  1 file changed, 2 deletions(-)
> > 
> > Index: linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c     2008-04-28 14:27:26.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c  2008-04-28 15:05:34.000000000 +0530
> > @@ -36,7 +36,6 @@
> >  #include <asm/arch/mux.h>
> >  #include <asm/arch/board.h>
> >  #include <asm/arch/usb-musb.h>
> > -#include <asm/arch/usb-ehci.h>
> >  #include <asm/arch/hsmmc.h>
> >  #include <asm/arch/common.h>
> >  #include <asm/arch/keypad.h>
> > @@ -394,7 +393,6 @@ static void __init omap_2430sdp_init(voi
> > 
> >         sdp2430_flash_init();
> >         usb_musb_init();
> > -       usb_ehci_init();
> > 
> >         spi_register_board_info(sdp2430_spi_board_info,
> >                                 ARRAY_SIZE(sdp2430_spi_board_info));
> 
> -- 
> 	- Balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
