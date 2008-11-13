From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc3-omap git] osk5912: LED trigger update for CF
Date: Thu, 13 Nov 2008 15:55:54 -0800
Message-ID: <20081113235549.GA3106@atomide.com>
References: <200811071524.12243.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52976 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYKMXz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 18:55:56 -0500
Content-Disposition: inline
In-Reply-To: <200811071524.12243.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081107 16:05]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Help OSK work better with root-on-CF, by having one of the LEDs
> use the "ide-disk" trigger (to kick in during CF I/O).

Pushing today and adding to omap1-upstream queue.

Tony

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  arch/arm/mach-omap1/board-osk.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -188,7 +188,8 @@ static struct gpio_led tps_leds[] = {
>  	/* NOTE:  D9 and D2 have hardware blink support.
>  	 * Also, D9 requires non-battery power.
>  	 */
> -	{ .gpio = OSK_TPS_GPIO_LED_D9, .name = "d9", },
> +	{ .gpio = OSK_TPS_GPIO_LED_D9, .name = "d9",
> +			.default_trigger = "ide-disk", },
>  	{ .gpio = OSK_TPS_GPIO_LED_D2, .name = "d2", },
>  	{ .gpio = OSK_TPS_GPIO_LED_D3, .name = "d3", .active_low = 1,
>  			.default_trigger = "heartbeat", },
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
