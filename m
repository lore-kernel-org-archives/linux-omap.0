From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] ARM: OMAP2+: Add chip_select to ads7846 init
Date: Thu, 8 Dec 2011 16:37:44 -0800
Message-ID: <20111209003744.GH31337@atomide.com>
References: <1320358999-11016-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22772 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836Ab1LIAhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 19:37:48 -0500
Content-Disposition: inline
In-Reply-To: <1320358999-11016-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Thomas Weber <weber@corscience.de> [111103 13:46]:
> This patch adds the chip_select as parameter to
> omap_ads7846_init.
> All existing omap2-boards use chip select 0 on
> different spi busses. I work on bringing a board
> mainline where the ads7846 is connected to
> chip select 1. This patch prepares the omap_ads7846_init
> function for this board.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
>  arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
>  arch/arm/mach-omap2/board-ldp.c            |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
>  arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
>  arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
>  arch/arm/mach-omap2/board-overo.c          |    2 +-
>  arch/arm/mach-omap2/common-board-devices.c |   13 ++++++++-----
>  arch/arm/mach-omap2/common-board-devices.h |    3 ++-
>  11 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 77142c1..dec6407 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -710,7 +710,7 @@ static void __init omap_3430sdp_init(void)
>  		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV2;
>  	else
>  		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV1;
> -	omap_ads7846_init(1, gpio_pendown, 310, NULL);
> +	omap_ads7846_init(1, 0, gpio_pendown, 310, NULL);
>  	board_serial_init();
>  	omap_sdrc_init(hyb18m512160af6_sdrc_params, NULL);
>  	usb_musb_init(NULL);

This seems OK to me until we have device tree bindings for
this.

Regards,

Tony
