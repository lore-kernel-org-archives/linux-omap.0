From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/12] Add dummy smsc911x regulators to cm-t35.
Date: Tue, 27 Mar 2012 17:53:52 +0200
Message-ID: <4F71E290.2050403@compulab.co.il>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com> <1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080208060108000702020908"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:37387
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750956Ab2C0PyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 11:54:10 -0400
In-Reply-To: <1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

This is a multi-part message in MIME format.
--------------080208060108000702020908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Russ,

This patch works, but can we, please use the attached patch instead?

Thanks

On 03/23/12 11:21, Russ Dill wrote:
> Signed-off-by: Russ Dill <russ.dill@ti.com>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 41b0a2f..289ded3 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -26,6 +26,7 @@
>  
>  #include <linux/i2c/at24.h>
>  #include <linux/i2c/twl.h>
> +#include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/mmc/host.h>
>  
> @@ -630,10 +631,18 @@ static inline void cm_t3730_init_mux(void) {}
>  static struct omap_board_config_kernel cm_t35_config[] __initdata = {
>  };
>  
> +static struct regulator_consumer_supply dummy_supplies[] = {
> +	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
> +	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
> +	REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
> +	REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
> +};
> +
>  static void __init cm_t3x_common_init(void)
>  {
>  	omap_board_config = cm_t35_config;
>  	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
> +	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
>  	omap_serial_init();
>  	omap_sdrc_init(mt46h32m32lf6_sdrc_params,

-- 
Regards,
Igor.

--------------080208060108000702020908
Content-Type: text/x-patch;
 name="0001-ARM-OMAP3-cm-t35-add-smsc911x-regulators.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ARM-OMAP3-cm-t35-add-smsc911x-regulators.patch"

>From 0e1bbe7634edbbb75493a7a6257db94621c1efab Mon Sep 17 00:00:00 2001
From: Igor Grinberg <grinberg@compulab.co.il>
Date: Fri, 23 Mar 2012 02:21:37 -0700
Subject: [PATCH] ARM: OMAP3: cm-t35: add smsc911x regulators

Add dummy regulators for smsc911x Ethernet controllers on both
cm-t35/cmt3730 and sb-t35 boards.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index d73316e..8770be1 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -26,6 +26,7 @@
 
 #include <linux/i2c/at24.h>
 #include <linux/i2c/twl.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/mmc/host.h>
 
@@ -81,8 +82,23 @@ static struct omap_smsc911x_platform_data sb_t35_smsc911x_cfg = {
 	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
 };
 
+static struct regulator_consumer_supply cm_t35_smsc911x_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
+static struct regulator_consumer_supply sb_t35_smsc911x_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
+};
+
 static void __init cm_t35_init_ethernet(void)
 {
+	regulator_register_fixed(0, cm_t35_smsc911x_supplies,
+				 ARRAY_SIZE(cm_t35_smsc911x_supplies));
+	regulator_register_fixed(1, sb_t35_smsc911x_supplies,
+				 ARRAY_SIZE(sb_t35_smsc911x_supplies));
+
 	gpmc_smsc911x_init(&cm_t35_smsc911x_cfg);
 	gpmc_smsc911x_init(&sb_t35_smsc911x_cfg);
 }
-- 
1.7.3.4


--------------080208060108000702020908--
