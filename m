From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] OMAP3: beagle: add support for beagleboard xM revision C
Date: Fri, 20 May 2011 13:00:02 +0200
Message-ID: <728AF847-D03B-47D9-90CF-010E94CBB2EB@dominion.thruhere.net>
References: <1305888615-28472-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50367 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934304Ab1ETLAG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 07:00:06 -0400
Received: by wwa36 with SMTP id 36so3880800wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 04:00:05 -0700 (PDT)
In-Reply-To: <1305888615-28472-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP-KML List <linux-omap@vger.kernel.org>
Cc: Jason Kridner <jkridner@beagleboard.org>

Drat, I had a git add -i fail, ignore this one.

Op 20 mei 2011, om 12:50 heeft Koen Kooi het volgende geschreven:

> The USB enable GPIO has been inverted and the USER button moved.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |   26 +++++++++++++++++++++-----
> 1 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 2de4b02..05c5bab 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -62,7 +62,9 @@
>  *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
>  *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
>  *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
> - *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
> + *	XMA	= GPIO173, GPIO172, GPIO171: 0 0 0
> + *	XMB	= GPIO173, GPIO172, GPIO171: 0 0 1
> + *  XMC = GPIO173, GPIO172, GPIO171: 0 1 0
>  */
> enum {
> 	OMAP3BEAGLE_BOARD_UNKN = 0,
> @@ -70,6 +72,7 @@ enum {
> 	OMAP3BEAGLE_BOARD_C1_3,
> 	OMAP3BEAGLE_BOARD_C4,
> 	OMAP3BEAGLE_BOARD_XM,
> +	OMAP3BEAGLE_BOARD_XMC,
> };
> 
> static u8 omap3_beagle_version;
> @@ -124,9 +127,17 @@ static void __init omap3_beagle_init_rev(void)
> 		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
> 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> 		break;
> +	case 1:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM B\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> +		break;
> +	case 2:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM C\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
> +		break;
> 	default:
> -		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
> -		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
> +		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd, assuming xM C or newer\n", beagle_rev);
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
> 	}
> 
> 	return;
> @@ -298,7 +309,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
> 	/* REVISIT: need ehci-omap hooks for external VBUS
> 	 * power switch and overcurrent detect
> 	 */
> -	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
> +	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM && omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XMC) {
> 		r = gpio_request(gpio + 1, "EHCI_nOC");
> 		if (!r) {
> 			r = gpio_direction_input(gpio + 1);
> @@ -625,7 +636,7 @@ static void __init beagle_opp_init(void)
> 	}
> 
> 	/* Custom OPP enabled for XM */
> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM || omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XMC) {
> 		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> 		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
> 		struct device *dev;
> @@ -665,6 +676,11 @@ static void __init omap3_beagle_init(void)
> 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> 	omap3_beagle_init_rev();
> 	omap3_beagle_i2c_init();
> +
> +	if (cpu_is_omap3630()) {
> +		gpio_buttons[0].gpio = 4;
> +	}
> +
> 	platform_add_devices(omap3_beagle_devices,
> 			ARRAY_SIZE(omap3_beagle_devices));
> 	omap_display_init(&beagle_dss_data);
> -- 
> 1.6.6.1
> 

