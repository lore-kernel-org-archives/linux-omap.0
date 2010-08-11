From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Beagle: support MMC gpio_wp differences on xM
Date: Wed, 11 Aug 2010 11:49:52 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E700860@dbde02.ent.ti.com>
References: <1281451216-23725-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42951 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab0HKGUA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 02:20:00 -0400
In-Reply-To: <1281451216-23725-1-git-send-email-robertcnelson@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Robert Nelson
> Sent: Tuesday, August 10, 2010 8:10 PM
> To: tony@atomide.com
> Cc: linux-omap@vger.kernel.org; Robert Nelson
> Subject: [PATCH] ARM: OMAP: Beagle: support MMC gpio_wp differences on xM
> 
> The omap3630 based BeagleBoard xM uses a MicroSD card slot with
> no write protection.
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-
> omap2/board-omap3beagle.c
> index 87969c7..15929be 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -185,7 +185,9 @@ static struct gpio_led gpio_leds[];
>  static int beagle_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
> -	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
> +	if (cpu_is_omap3630()) {
> +		mmc[0].gpio_wp = -EINVAL;
> +	} else if (system_rev >= 0x20 && system_rev <= 0x34301000) {
[Ghorai] it's an old code. But I think we can replace the hardcode value to use omap_rev() as you are changing the same! Or default for all omap34xx?

>  		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
>  		mmc[0].gpio_wp = 23;
>  	} else {
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
