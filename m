From: Adrian Hunter <adrian.hunter@Nokia.com>
Subject: [PATCH] omap: hsmmc: Do not mux the slot if non default muxing is
 already done
Date: Thu, 05 Aug 2010 10:22:05 +0300
Message-ID: <4C5A669D.9070202@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17485 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296Ab0HEHWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 03:22:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>, "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@Nokia.com>

>From 33ff72fc0b690c6b89407668d0f4ab9543eec47c Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Mon, 26 Apr 2010 16:30:07 +0300
Subject: [PATCH] omap: hsmmc: Do not mux the slot if non default muxing is already done

Add 'nomux' flag for hsmmc and skip mux'ing is it is set.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/devices.c |    3 +++
 arch/arm/mach-omap2/hsmmc.c   |    1 +
 arch/arm/mach-omap2/hsmmc.h   |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..c6329eb 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -608,6 +608,9 @@ static inline void omap_hsmmc_reset(void) {}
 static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
+	if (mmc_controller->slots[0].nomux)
+		return;
+
 	if ((mmc_controller->slots[0].switch_pin > 0) && \
 		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
 		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1ef54b0..e1ec467 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -267,6 +267,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->slots[0].switch_pin = c->gpio_cd;
 		mmc->slots[0].gpio_wp = c->gpio_wp;
 
+		mmc->slots[0].nomux = c->nomux;
 		mmc->slots[0].remux = c->remux;
 
 		if (c->cover_only)
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 36f0ba8..56d65cc 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -16,6 +16,7 @@ struct omap2_hsmmc_info {
 	bool	power_saving;	/* Try to sleep or power off when possible */
 	bool	no_off;		/* power_saving and power is not to go off */
 	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
+	bool    nomux;		/* No default muxing for this slot */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
-- 
1.6.3.3
