From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 07/12] omap: mcbsp: Get rid of remaining is_omap tests
Date: Fri,  1 Jul 2011 11:52:31 +0300
Message-ID: <1309510356-27147-8-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab1GAIxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:07 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:06 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

We can get rid of remaining is_omap tests in the driver by using
mcbsp_config_type that is set in omap hwmod data for 2430, 34xx and 44xx.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/mcbsp.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 92d6d4f..47720b1 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -193,7 +193,7 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 	MCBSP_WRITE(mcbsp, MCR2, config->mcr2);
 	MCBSP_WRITE(mcbsp, MCR1, config->mcr1);
 	MCBSP_WRITE(mcbsp, PCR0, config->pcr0);
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE2) {
 		MCBSP_WRITE(mcbsp, XCCR, config->xccr);
 		MCBSP_WRITE(mcbsp, RCCR, config->rccr);
 	}
@@ -531,14 +531,13 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
 
-	if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
-		return;
-
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
+	if (mcbsp->mcbsp_config_type < MCBSP_CONFIG_TYPE3)
+		return;
 
 	if (threshold && threshold <= mcbsp->max_tx_thres)
 		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
@@ -554,14 +553,13 @@ void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
 
-	if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
-		return;
-
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
+	if (mcbsp->mcbsp_config_type < MCBSP_CONFIG_TYPE3)
+		return;
 
 	if (threshold && threshold <= mcbsp->max_rx_thres)
 		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
@@ -698,7 +696,7 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 	 * Enable wakup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
 	 */
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3) {
 		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 	}
 }
@@ -712,7 +710,7 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 	/*
 	 * Disable wakup behavior, smart idle and all wakeups
 	 */
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3) {
 		/*
 		 * HW bug workaround - If no_idle mode is taken, we need to
 		 * go to smart_idle before going to always_idle, or the
@@ -872,7 +870,7 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	if (cpu_is_omap34xx())
+	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3)
 		omap_st_start(mcbsp);
 
 	/* Only enable SRG, if McBSP is master */
@@ -910,7 +908,7 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7));
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE2) {
 		/* Release the transmitter and receiver */
 		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w &= ~(tx ? XDISABLE : 0);
@@ -940,7 +938,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 
 	/* Reset transmitter */
 	tx &= 1;
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE2) {
 		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w |= (tx ? XDISABLE : 0);
 		MCBSP_WRITE(mcbsp, XCCR, w);
@@ -950,7 +948,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 
 	/* Reset receiver */
 	rx &= 1;
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE2) {
 		w = MCBSP_READ_CACHE(mcbsp, RCCR);
 		w |= (rx ? RDISABLE : 0);
 		MCBSP_WRITE(mcbsp, RCCR, w);
@@ -967,7 +965,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 		MCBSP_WRITE(mcbsp, SPCR2, w & ~(1 << 6));
 	}
 
-	if (cpu_is_omap34xx())
+	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3)
 		omap_st_stop(mcbsp);
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
@@ -1230,7 +1228,7 @@ static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 {
 	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
-	if (cpu_is_omap34xx()) {
+	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3) {
 		/*
 		 * Initially configure the maximum thresholds to a safe value.
 		 * The McBSP FIFO usage with these values should not go under
@@ -1262,7 +1260,7 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 
 static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
 {
-	if (cpu_is_omap34xx()) {
+	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3) {
 		omap_additional_remove(mcbsp->dev);
 
 		if (mcbsp->id == 2 || mcbsp->id == 3)
-- 
1.7.0.4

