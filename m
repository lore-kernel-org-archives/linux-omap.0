From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP: EHCI: Wrong ehci init for 2430
Date: Mon, 28 Apr 2008 13:31:20 +0300
Message-ID: <20080428103120.GB4357@gandalf.research.nokia.com>
References: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com> <1209370114-17007-2-git-send-email-jarkko.nikula@nokia.com> <20080428094833.GA4357@gandalf.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC3560872F72C95A@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29268 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933701AbYD1Kc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 06:32:57 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560872F72C95A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Mon, Apr 28, 2008 at 03:51:11PM +0530, ext Pandita, Vikram wrote:
> OMAP2430 does not have USB EHCI controller.
> EHCI core was introduced with OMAP3430 ES2.0 onwards.
> The ehci_init() call has been wrongly introduced for OMAP2430, so removing it.

Good, I was unsure about it and that's why I asked people to give the
original patch a good review. Seems that this one came too late.

Anyway, good that you saw it :-)

> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c     2008-04-28 14:27:26.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c  2008-04-28 15:05:34.000000000 +0530
> @@ -36,7 +36,6 @@
>  #include <asm/arch/mux.h>
>  #include <asm/arch/board.h>
>  #include <asm/arch/usb-musb.h>
> -#include <asm/arch/usb-ehci.h>
>  #include <asm/arch/hsmmc.h>
>  #include <asm/arch/common.h>
>  #include <asm/arch/keypad.h>
> @@ -394,7 +393,6 @@ static void __init omap_2430sdp_init(voi
> 
>         sdp2430_flash_init();
>         usb_musb_init();
> -       usb_ehci_init();
> 
>         spi_register_board_info(sdp2430_spi_board_info,
>                                 ARRAY_SIZE(sdp2430_spi_board_info));

-- 
	- Balbi
