From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [RFC][PATCH] board-omap3beagle: Remove duplicate DVI reset gpio handling
Date: Wed, 30 Jun 2010 08:46:38 +0200
Message-ID: <03C56442-6DB0-4C6D-B576-D25CA0AEEC7F@student.utwente.nl>
References: <1277843560-25630-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37244 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab0F3Gqm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 02:46:42 -0400
Received: by wyb38 with SMTP id 38so428653wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 23:46:41 -0700 (PDT)
In-Reply-To: <1277843560-25630-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Koen Kooi <koen.kooi@gmail.com>, "tomi.valkeinen@nokia.com Valkeinen" <tomi.valkeinen@nokia.com>


Op 29 jun 2010, om 22:32 heeft Sergio Aguirre het volgende geschreven:

> Following commit missed to remove this:
> 
>  commit 044d32ffbcb4a1d400088e3575508f46c0a9face
>  Author: Koen Kooi <koen.kooi@gmail.com>
>  Date:   Thu Apr 22 10:23:42 2010 +0200
> 
>      board-omap3-beagle: add DSS2 support
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Cc: Koen Kooi <koen.kooi@gmail.com>

Looks good to me:

Acked-by: Koen Kooi <koen.kooi@gmail.com>

As a side note, the beagleboard xM uses a different pin for that.

regards,

Koen


> ---
> arch/arm/mach-omap2/board-omap3beagle.c |    7 ++-----
> 1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 7b95cc1..867a4ad 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -169,6 +169,8 @@ static void __init beagle_display_init(void)
> {
> 	int r;
> 
> +	omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_PIN_INPUT);
> +
> 	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
> 	if (r < 0) {
> 		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
> @@ -491,11 +493,6 @@ static void __init omap3_beagle_init(void)
> 			ARRAY_SIZE(omap3_beagle_devices));
> 	omap_serial_init();
> 
> -	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> -	gpio_request(170, "DVI_nPD");
> -	/* REVISIT leave DVI powered down until it's needed ... */
> -	gpio_direction_output(170, true);
> -
> 	usb_musb_init(&musb_board_data);
> 	usb_ehci_init(&ehci_pdata);
> 	omap3beagle_flash_init();
> -- 
> 1.6.3.3
> 
> 

