From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 12:59:48 +0200
Message-ID: <4DA41490-EF90-40A5-B3EE-E6281B4F1313@dominion.thruhere.net>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com> <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55595 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2EUK7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 06:59:52 -0400
Received: by wgbdr13 with SMTP id dr13so4860877wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 03:59:51 -0700 (PDT)
In-Reply-To: <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


Op 21 mei 2012, om 11:41 heeft Tomi Valkeinen het volgende geschreven:

> Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> powerdown-gpio handling from the board files to the tfp410 driver. One
> gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
> the Beagle board file. This causes the tfp410 driver to fail to request
> the gpio on Beagle, causing the driver to fail and thus the DVI output
> doesn't work.
> 
> This patch removes the gpio_request_one() from the board file.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 8ede8d2..72ad1f6 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -510,9 +510,8 @@ static void __init omap3_beagle_init(void)
> 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> 				  mt46h32m32lf6_sdrc_params);
> 
> +	/* DVI power down GPIO */
> 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);

Wouldn't it be an output rather than an input?

regards,

Koen