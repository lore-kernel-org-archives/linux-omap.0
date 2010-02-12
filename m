From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/19] omap_hsmmc: Allow for power saving without going off
Date: Thu, 11 Feb 2010 16:51:22 -0800
Message-ID: <20100212005122.24958.45328.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51305 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730Ab0BLAul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:41 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

An eMMC may be always powered on, so that the lowest
power saving state possible is sleeping. Add a field
to the platform data to indicate that.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    3 +++
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    6 ++++++
 4 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 4a05c37..e4ab123 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -202,6 +202,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		if (c->power_saving)
 			mmc->slots[0].power_saving = 1;
 
+		if (c->no_off)
+			mmc->slots[0].no_off = 1;
+
 		/* NOTE:  MMC slots should have a Vcc regulator set up.
 		 * This may be from a TWL4030-family chip, another
 		 * controllable regulator, or a fixed supply.
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index f641f59..2453a7a 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -14,6 +14,7 @@ struct omap2_hsmmc_info {
 	bool	cover_only;	/* No card detect - just cover switch */
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	bool	power_saving;	/* Try to sleep or power off when possible */
+	bool	no_off;		/* power_saving and power is not to go off */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 8b23d32..b463949 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -96,6 +96,9 @@ struct omap_mmc_platform_data {
 		/* Try to sleep or power off when possible */
 		unsigned power_saving:1;
 
+		/* If using power_saving and the MMC power is not to go off */
+		unsigned no_off:1;
+
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2c5e15d..e15d0f4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1656,6 +1656,9 @@ static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
 	dev_dbg(mmc_dev(host->mmc), "DISABLED -> %s\n",
 		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
 
+	if (mmc_slot(host).no_off)
+		return 0;
+
 	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
 	    mmc_slot(host).card_detect ||
 	    (mmc_slot(host).get_cover_state &&
@@ -1671,6 +1674,9 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 	if (!mmc_try_claim_host(host->mmc))
 		return 0;
 
+	if (mmc_slot(host).no_off)
+		return 0;
+
 	if (!((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
 	      mmc_slot(host).card_detect ||
 	      (mmc_slot(host).get_cover_state &&

