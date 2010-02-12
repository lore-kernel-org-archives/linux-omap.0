From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/19] omap_hsmmc: Allow for a shared VccQ
Date: Thu, 11 Feb 2010 16:51:29 -0800
Message-ID: <20100212005129.24958.38870.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53656 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743Ab0BLAur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:47 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

EMMC can have two voltage supplies, Vcc and VccQ
which are implemented in the code as consumer
supplies vmmc and vmmc_aux.

If the regulator that supplies vmmc_aux is shared
with other consumers, then sending it to sleep
will disrupt those consumers.  However, the
TWL4030-family regulators may have OFF remapped
to SLEEP, in which case 'regulator_disable()'
will put the regulator to sleep only when all
consumers are disabled - which is the desired
behaviour.

This patch adds a platform data field to allow
that option.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    3 +++
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |   16 +++++++++++++++-
 4 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index e4ab123..9ad2295 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -205,6 +205,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		if (c->no_off)
 			mmc->slots[0].no_off = 1;
 
+		if (c->vcc_aux_disable_is_sleep)
+			mmc->slots[0].vcc_aux_disable_is_sleep = 1;
+
 		/* NOTE:  MMC slots should have a Vcc regulator set up.
 		 * This may be from a TWL4030-family chip, another
 		 * controllable regulator, or a fixed supply.
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 2453a7a..36f0ba8 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -15,6 +15,7 @@ struct omap2_hsmmc_info {
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	bool	power_saving;	/* Try to sleep or power off when possible */
 	bool	no_off;		/* power_saving and power is not to go off */
+	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index b463949..a1bac07 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -99,6 +99,9 @@ struct omap_mmc_platform_data {
 		/* If using power_saving and the MMC power is not to go off */
 		unsigned no_off:1;
 
+		/* Regulator off remapped to sleep */
+		unsigned vcc_aux_disable_is_sleep:1;
+
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d2fad58..af37477 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -347,7 +347,14 @@ static int omap_hsmmc_23_set_sleep(struct device *dev, int slot, int sleep,
 		err = regulator_set_mode(host->vcc, mode);
 	if (err)
 		return err;
-	return regulator_set_mode(host->vcc_aux, mode);
+
+	if (!mmc_slot(host).vcc_aux_disable_is_sleep)
+		return regulator_set_mode(host->vcc_aux, mode);
+
+	if (sleep)
+		return regulator_disable(host->vcc_aux);
+	else
+		return regulator_enable(host->vcc_aux);
 }
 
 static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
@@ -1982,6 +1989,13 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	else
 		mmc->ops	= &omap_hsmmc_ops;
 
+	/*
+	 * If regulator_disable can only put vcc_aux to sleep then there is
+	 * no off state.
+	 */
+	if (mmc_slot(host).vcc_aux_disable_is_sleep)
+		mmc_slot(host).no_off = 1;
+
 	mmc->f_min	= 400000;
 	mmc->f_max	= 52000000;
 

