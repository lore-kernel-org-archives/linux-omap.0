From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap2+: board-n8x0: Change the flags for the
 serial pads.
Date: Wed, 23 Feb 2011 10:49:57 -0800
Message-ID: <20110223184956.GY15225@atomide.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-6-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51428 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271Ab1BWSt7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 13:49:59 -0500
Content-Disposition: inline
In-Reply-To: <1296191298-17545-6-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com

* sricharan <r.sricharan@ti.com> [110127 21:05]:
> The flag for remuxing uart3_rx_irxx pad is changed.
> 
> Signed-off-by: sricharan <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/board-n8x0.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
> index 9b52e2d..bd51356 100644
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -751,7 +751,7 @@ static struct omap_board_mux board_mux[] __initdata = {
>  static struct omap_device_pad serial2_pads[] __initdata = {
>  	{
>  		.name	= "uart3_rx_irrx.uart3_rx_irrx",
> -		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> +		.flags	= OMAP_DEVICE_PAD_REMUX_IDLE | OMAP_DEVICE_PAD_WAKEUP,
>  		.enable	= OMAP_MUX_MODE0,
>  		.idle	= OMAP_MUX_MODE3	/* Mux as GPIO for idle */
>  	},

This should not be needed when rebased on my patch to replace patch 1/5.

Regards,

Tony
