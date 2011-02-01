From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
Date: Tue, 01 Feb 2011 14:01:22 -0800
Message-ID: <87sjw7pg7h.fsf@ti.com>
References: <1294414873-22447-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41586 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752949Ab1BAWB0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 17:01:26 -0500
Received: by mail-qy0-f171.google.com with SMTP id 32so4906925qyk.2
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 14:01:26 -0800 (PST)
In-Reply-To: <1294414873-22447-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 7 Jan 2011 09:41:13 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> OMP3630 silicon can enable higher frequencies only depending on the board
> characteristics meeting the recommended standards, and has to be selectively
> toggled.
>
> Beagle XM uses 3730 variant and the board design allows enabling 800MHz and
> 1GHz OPPs. However, We need Smart reflex class 1.5 and ABB to enable 1GHz
> safely.  For the moment, we tweak the default table to allow for 800Mhz OPP
> usage.
>
> Reported-by: Koen Kooi <koen@beagleboard.org>
> Tested-by: Koen Kooi <koen@beagleboard.org>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin

> ---
> v2: fixed issue when !mh || !dh, updated commit message to point on rationale
>     for board specific tweaking
> v1: http://marc.info/?t=129426060900008&r=1&w=2
>  arch/arm/mach-omap2/board-omap3beagle.c |   50 +++++++++++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 6c12760..7dc0397 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -23,6 +23,7 @@
>  #include <linux/gpio.h>
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
> +#include <linux/opp.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -44,10 +45,12 @@
>  #include <plat/gpmc.h>
>  #include <plat/nand.h>
>  #include <plat/usb.h>
> +#include <plat/omap_device.h>
>  
>  #include "mux.h"
>  #include "hsmmc.h"
>  #include "timer-gp.h"
> +#include "pm.h"
>  
>  #define NAND_BLOCK_SIZE		SZ_128K
>  
> @@ -556,6 +559,52 @@ static struct omap_musb_board_data musb_board_data = {
>  	.power			= 100,
>  };
>  
> +static void __init beagle_opp_init(void)
> +{
> +	int r = 0;
> +
> +	/* Initialize the omap3 opp table */
> +	if (omap3_opp_init()) {
> +		pr_err("%s: opp default init failed\n", __func__);
> +		return;
> +	}
> +
> +	/* Custom OPP enabled for XM */
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> +		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
> +		struct device *dev;
> +
> +		if (!mh || !dh) {
> +			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
> +				__func__, mh, dh);
> +			return;
> +		}
> +		/* Enable MPU 1GHz and lower opps */
> +		dev = &mh->od->pdev.dev;
> +		r = opp_enable(dev, 800000000);
> +		/* TODO: MPU 1GHz needs SR and ABB */
> +
> +		/* Enable IVA 800MHz and lower opps */
> +		dev = &dh->od->pdev.dev;
> +		r |= opp_enable(dev, 660000000);
> +		/* TODO: DSP 800MHz needs SR and ABB */
> +		if (r) {
> +			pr_err("%s: failed to enable higher opp %d\n",
> +				__func__, r);
> +			/*
> +			 * Cleanup - disable the higher freqs - we dont care
> +			 * about the results
> +			 */
> +			dev = &mh->od->pdev.dev;
> +			opp_disable(dev, 800000000);
> +			dev = &dh->od->pdev.dev;
> +			opp_disable(dev, 660000000);
> +		}
> +	}
> +	return;
> +}
> +
>  static void __init omap3_beagle_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> @@ -579,6 +628,7 @@ static void __init omap3_beagle_init(void)
>  	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>  
>  	beagle_display_init();
> +	beagle_opp_init();
>  }
>  
>  MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
