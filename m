From: Rob Clark <rob.clark@linaro.org>
Subject: [RFC 1/3] OMAPDSS: expose dispc for use from omapdrm
Date: Fri, 27 Jul 2012 20:07:52 -0500
Message-ID: <1343437674-24246-2-git-send-email-rob.clark@linaro.org>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46849 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab2G1BI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 21:08:29 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so5089501obb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 18:08:29 -0700 (PDT)
In-Reply-To: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Not very clean, just for proof of concept.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/video/omap2/dss/apply.c |    4 ++-
 drivers/video/omap2/dss/dispc.c |   76 ++++++++++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss.h   |    2 ++
 drivers/video/omap2/dss/hdmi.c  |   18 +++++-----
 4 files changed, 73 insertions(+), 27 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index ab22cc2..c9a9b80 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -699,6 +699,8 @@ static void dss_write_regs(void)
 
 static void dss_set_go_bits(void)
 {
+	dump_stack();
+#if 0
 	const int num_mgrs = omap_dss_get_num_overlay_managers();
 	int i;
 
@@ -722,7 +724,7 @@ static void dss_set_go_bits(void)
 
 		dispc_mgr_go(mgr->id);
 	}
-
+#endif
 }
 
 static void mgr_clear_shadow_dirty(struct omap_overlay_manager *mgr)
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e6ea47e..bdb0bde 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -352,7 +352,7 @@ static void dispc_restore_context(void)
 	if (dss_has_feature(FEAT_MGR_LCD2))
 		RR(CONTROL2);
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
-	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
+	dispc_clear_irqs(DISPC_IRQ_SYNC_LOST_DIGIT);
 
 	/*
 	 * enable last so IRQs won't trigger before
@@ -376,6 +376,7 @@ int dispc_runtime_get(void)
 	WARN_ON(r < 0);
 	return r < 0 ? r : 0;
 }
+EXPORT_SYMBOL_GPL(dispc_runtime_get);
 
 void dispc_runtime_put(void)
 {
@@ -386,6 +387,7 @@ void dispc_runtime_put(void)
 	r = pm_runtime_put_sync(&dispc.pdev->dev);
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
+EXPORT_SYMBOL_GPL(dispc_runtime_put);
 
 static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
 {
@@ -410,6 +412,7 @@ u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(dispc_mgr_get_vsync_irq);
 
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 {
@@ -440,6 +443,7 @@ bool dispc_mgr_go_busy(enum omap_channel channel)
 	else
 		return REG_GET(DISPC_CONTROL, bit, bit) == 1;
 }
+EXPORT_SYMBOL_GPL(dispc_mgr_go_busy);
 
 void dispc_mgr_go(enum omap_channel channel)
 {
@@ -483,6 +487,7 @@ void dispc_mgr_go(enum omap_channel channel)
 	else
 		REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
 }
+EXPORT_SYMBOL_GPL(dispc_mgr_go);
 
 static void dispc_ovl_write_firh_reg(enum omap_plane plane, int reg, u32 value)
 {
@@ -844,6 +849,7 @@ void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 	}
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
+EXPORT_SYMBOL_GPL(dispc_ovl_set_channel_out);
 
 static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 {
@@ -2236,6 +2242,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dispc_ovl_setup);
 
 int dispc_ovl_enable(enum omap_plane plane, bool enable)
 {
@@ -2256,6 +2263,7 @@ static void dispc_disable_isr(void *data, u32 mask)
 	struct completion *compl = data;
 	complete(compl);
 }
+EXPORT_SYMBOL_GPL(dispc_ovl_enable);
 
 static void _enable_lcd_out(enum omap_channel channel, bool enable)
 {
@@ -2318,6 +2326,10 @@ static void _enable_digit_out(bool enable)
 	dispc_read_reg(DISPC_CONTROL);
 }
 
+/* TODO revisit how this and dispc_mgr_enable_lcd_out() should
+ * work w/ omapdrm handling the irqs..  ideally we'd just have
+ * a dispc helper fxn to call from the omapdrm irq handling.
+ */
 static void dispc_mgr_enable_digit_out(bool enable)
 {
 	struct completion frame_done_completion;
@@ -2381,7 +2393,7 @@ static void dispc_mgr_enable_digit_out(bool enable)
 		unsigned long flags;
 		spin_lock_irqsave(&dispc.irq_lock, flags);
 		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST_DIGIT;
-		dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
+		dispc_clear_irqs(DISPC_IRQ_SYNC_LOST_DIGIT);
 		_omap_dispc_set_irqs();
 		spin_unlock_irqrestore(&dispc.irq_lock, flags);
 	}
@@ -2410,6 +2422,7 @@ void dispc_mgr_enable(enum omap_channel channel, bool enable)
 	else
 		BUG();
 }
+EXPORT_SYMBOL_GPL(dispc_mgr_enable);
 
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
@@ -2529,6 +2542,7 @@ void dispc_mgr_setup(enum omap_channel channel,
 		dispc_mgr_set_cpr_coef(channel, &info->cpr_coefs);
 	}
 }
+EXPORT_SYMBOL_GPL(dispc_mgr_setup);
 
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
@@ -2705,6 +2719,7 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 
 	dispc_mgr_set_size(channel, t.x_res, t.y_res);
 }
+EXPORT_SYMBOL_GPL(dispc_mgr_set_timings);
 
 static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 		u16 pck_div)
@@ -3224,11 +3239,33 @@ int dispc_mgr_get_clock_div(enum omap_channel channel,
 	return 0;
 }
 
+u32 dispc_read_irqs(void)
+{
+	return dispc_read_reg(DISPC_IRQSTATUS);
+}
+EXPORT_SYMBOL_GPL(dispc_read_irqs);
+
+void dispc_clear_irqs(u32 mask)
+{
+	dispc_write_reg(DISPC_IRQSTATUS, mask);
+}
+EXPORT_SYMBOL_GPL(dispc_clear_irqs);
+
+void dispc_set_irqs(u32 mask)
+{
+	u32 old_mask = dispc_read_reg(DISPC_IRQENABLE);
+
+	/* clear the irqstatus for newly enabled irqs */
+	dispc_clear_irqs((mask ^ old_mask) & mask);
+
+	dispc_write_reg(DISPC_IRQENABLE, mask);
+}
+EXPORT_SYMBOL_GPL(dispc_set_irqs);
+
 /* dispc.irq_lock has to be locked by the caller */
 static void _omap_dispc_set_irqs(void)
 {
 	u32 mask;
-	u32 old_mask;
 	int i;
 	struct omap_dispc_isr_data *isr_data;
 
@@ -3243,11 +3280,7 @@ static void _omap_dispc_set_irqs(void)
 		mask |= isr_data->mask;
 	}
 
-	old_mask = dispc_read_reg(DISPC_IRQENABLE);
-	/* clear the irqstatus for newly enabled irqs */
-	dispc_write_reg(DISPC_IRQSTATUS, (mask ^ old_mask) & mask);
-
-	dispc_write_reg(DISPC_IRQENABLE, mask);
+	dispc_set_irqs(mask);
 }
 
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
@@ -3380,7 +3413,7 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 
 	spin_lock(&dispc.irq_lock);
 
-	irqstatus = dispc_read_reg(DISPC_IRQSTATUS);
+	irqstatus = dispc_read_irqs();
 	irqenable = dispc_read_reg(DISPC_IRQENABLE);
 
 	/* IRQ is not for us */
@@ -3402,9 +3435,9 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 #endif
 	/* Ack the interrupt. Do it here before clocks are possibly turned
 	 * off */
-	dispc_write_reg(DISPC_IRQSTATUS, irqstatus);
+	dispc_clear_irqs(irqstatus);
 	/* flush posted write */
-	dispc_read_reg(DISPC_IRQSTATUS);
+	dispc_read_irqs();
 
 	/* make a copy and unlock, so that isrs can unregister
 	 * themselves */
@@ -3597,6 +3630,17 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 	return 0;
 }
 
+u32 dispc_error_irqs(void)
+{
+	u32 mask = DISPC_IRQ_MASK_ERROR;
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		mask |= DISPC_IRQ_SYNC_LOST2;
+	if (dss_feat_get_num_ovls() > 3)
+		mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
+	return mask;
+}
+EXPORT_SYMBOL_GPL(dispc_error_irqs);
+
 static void _omap_dispc_initialize_irq(void)
 {
 	unsigned long flags;
@@ -3605,15 +3649,11 @@ static void _omap_dispc_initialize_irq(void)
 
 	memset(dispc.registered_isr, 0, sizeof(dispc.registered_isr));
 
-	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
-	if (dss_feat_get_num_ovls() > 3)
-		dispc.irq_error_mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
+	dispc.irq_error_mask = dispc_error_irqs();
 
 	/* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
 	 * so clear it */
-	dispc_write_reg(DISPC_IRQSTATUS, dispc_read_reg(DISPC_IRQSTATUS));
+	dispc_clear_irqs(dispc_read_irqs());
 
 	_omap_dispc_set_irqs();
 
@@ -3690,6 +3730,7 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+#if 0
 	dispc.irq = platform_get_irq(dispc.pdev, 0);
 	if (dispc.irq < 0) {
 		DSSERR("platform_get_irq failed\n");
@@ -3702,6 +3743,7 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 		DSSERR("request_irq failed\n");
 		return r;
 	}
+#endif
 
 	clk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index dd1092c..31affc9 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -370,6 +370,8 @@ int dispc_init_platform_driver(void) __init;
 void dispc_uninit_platform_driver(void) __exit;
 void dispc_dump_clocks(struct seq_file *s);
 void dispc_irq_handler(void);
+u32 dispc_read_irqs(void);
+void dispc_clear_irqs(u32 mask);
 
 int dispc_runtime_get(void);
 void dispc_runtime_put(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 26a2430..8ca7d71 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -296,7 +296,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	dss_mgr_disable(dssdev->manager);
+//	dss_mgr_disable(dssdev->manager);
 
 	p = &dssdev->panel.timings;
 
@@ -350,20 +350,20 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_enable_gamma_table(0);
 
 	/* tv size */
-	dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
+//	dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 
 	r = hdmi.ip_data.ops->video_enable(&hdmi.ip_data);
 	if (r)
 		goto err_vid_enable;
 
-	r = dss_mgr_enable(dssdev->manager);
-	if (r)
-		goto err_mgr_enable;
+//	r = dss_mgr_enable(dssdev->manager);
+//	if (r)
+//		goto err_mgr_enable;
 
 	return 0;
 
-err_mgr_enable:
-	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
+//err_mgr_enable:
+//	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 err_vid_enable:
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
@@ -374,7 +374,7 @@ err:
 
 static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
-	dss_mgr_disable(dssdev->manager);
+//	dss_mgr_disable(dssdev->manager);
 
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
@@ -413,7 +413,7 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 		if (r)
 			DSSERR("failed to power on device\n");
 	} else {
-		dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
+//		dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 	}
 }
 
-- 
1.7.9.5

