From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] omap4: board-4430sdp: Initialise the serial pads
Date: Wed, 23 Feb 2011 10:49:40 -0800
Message-ID: <20110223184940.GW15225@atomide.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-3-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36090 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab1BWStp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 13:49:45 -0500
Content-Disposition: inline
In-Reply-To: <1296191298-17545-3-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com

* sricharan <r.sricharan@ti.com> [110127 21:04]:
> Use the mux framework to initialise the serial pads.
> 
> Signed-off-by: sricharan <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |   73 ++++++++++++++++++++++++++++++++++-
>  1 files changed, 72 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 1cb208b..d77f099 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -537,8 +537,79 @@ static void __init omap_sfh7741prox_init(void)
>  static struct omap_board_mux board_mux[] __initdata = {
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
> +
> +static struct omap_device_pad serial2_pads[] __initdata = {
> +	{ .name   = "uart2_cts.uart2_cts",
> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	  .flags  = OMAP_DEVICE_PAD_REMUX_IDLE,
> +	  .idle   = OMAP_MUX_MODE7,
> +	},

Is there need to dynamically remux uart2_cts? If so, please
describe the reason in the patch description and comments.

Note that if there's need for dynamic remuxing, this should
be updated for just OMAP_DEVICE_PAD_REMUX to work with the
patch I posted to replace patch 1/5.

Regards,

Tony
