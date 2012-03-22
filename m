From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 08/13] Add dummy smsc911x regulators to ldp.
Date: Thu, 22 Mar 2012 08:06:33 +0100
Message-ID: <EA720A1C-E0F3-4026-92DC-63ACD5CA9250@dominion.thruhere.net>
References: <20120321194133.GP9859@atomide.com> <1332393594-23993-1-git-send-email-Russ.Dill@ti.com> <1332393594-23993-9-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53418 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab2CVHGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 03:06:33 -0400
Received: by wejx9 with SMTP id x9so1548849wej.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 00:06:32 -0700 (PDT)
In-Reply-To: <1332393594-23993-9-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org


Op 22 mrt. 2012, om 06:19 heeft Russ Dill het volgende geschreven:

> Signed-off-by: Russ Dill <russ.dill@ti.com>
> ---
> arch/arm/mach-omap2/board-ldp.c      |    7 +++++++
> arch/arm/mach-omap2/board-omap3evm.c |    9 +++++++++

Is that evm hunk intentional?

regards,

Koen

> 2 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index d50a562a..1b60495 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -22,6 +22,7 @@
> #include <linux/err.h>
> #include <linux/clk.h>
> #include <linux/spi/spi.h>
> +#include <linux/regulator/fixed.h>
> #include <linux/regulator/machine.h>
> #include <linux/i2c/twl.h>
> #include <linux/io.h>
> @@ -410,8 +411,14 @@ static struct mtd_partition ldp_nand_partitions[] = {
> 
> };
> 
> +static struct regulator_consumer_supply dummy_supplies[] = {
> +	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
> +	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
> +};
> +
> static void __init omap_ldp_init(void)
> {
> +	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
> 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> 	ldp_init_smsc911x();
> 	omap_i2c_init();
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 548e1ef..a659e19 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -114,6 +114,15 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
> 
> static inline void __init omap3evm_init_smsc911x(void)
> {
> +	struct clk *l3ck;
> +	unsigned int rate;
> +
> +	l3ck = clk_get(NULL, "l3_ck");
> +	if (IS_ERR(l3ck))
> +		rate = 100000000;
> +	else
> +		rate = clk_get_rate(l3ck);
> +
> 	/* Configure ethernet controller reset gpio */
> 	if (cpu_is_omap3430()) {
> 		if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
> -- 
> 1.7.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

