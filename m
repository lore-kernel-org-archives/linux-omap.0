From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/5] omap mmc: Add better MMC low-level init
Date: Sat, 10 Jan 2009 23:49:42 +0100
Message-ID: <20090110224942.GA10556@michl.2n.cz>
References: <20081207213617.10456.43951.stgit@localhost> <20081207214747.10456.34844.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ex.2n.cz ([213.29.92.11]:52522 "EHLO ex.2n.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbZAJW4b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2009 17:56:31 -0500
Content-Disposition: inline
In-Reply-To: <20081207214747.10456.34844.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Sun, Dec 07, 2008 at 01:47:47PM -0800, Tony Lindgren wrote:
> diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
> index 504ae88..409fa56 100644
> --- a/arch/arm/mach-omap1/board-h2-mmc.c
> +++ b/arch/arm/mach-omap1/board-h2-mmc.c
[snip]
> +static void mmc_shutdown(struct device *dev)
> +{
> +	gpio_free(H2_TPS_GPIO_MMC_PWR_EN);
> +}
> +
> +/*
> + * H2 could use the following functions tested:
> + * - mmc_get_cover_state that uses OMAP_MPUIO(1)
> + * - mmc_get_wp that uses OMAP_MPUIO(3)
> + */
> +static struct omap_mmc_platform_data mmc1_data = {
> +	.nr_slots                       = 1,
> +	.init				= mmc_late_init,
> +	.shutdown			= mmc_shutdown,
It seems that shutdown is no-op, so what about patch below?

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 409fa56..613adfc 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -24,19 +24,13 @@
 static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-	if (power_on)
-		gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 1);
-	else
-		gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 0);
-
+	gpio_set_value(H2_TPS_GPIO_MMC_PWR_EN, power_on);
 	return 0;
 }
 
 static int mmc_late_init(struct device *dev)
 {
-	int ret;
-
-	ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
+	int ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
 	if (ret < 0)
 		return ret;
 
@@ -45,7 +39,7 @@ static int mmc_late_init(struct device *dev)
 	return ret;
 }
 
-static void mmc_shutdown(struct device *dev)
+static void mmc_cleanup(struct device *dev)
 {
 	gpio_free(H2_TPS_GPIO_MMC_PWR_EN);
 }
@@ -58,7 +52,7 @@ static void mmc_shutdown(struct device *dev)
 static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
 	.init				= mmc_late_init,
-	.shutdown			= mmc_shutdown,
+	.cleanup			= mmc_cleanup,
 	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
 		.set_power              = mmc_set_power,

