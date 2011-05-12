From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 4/8] OMAP: DSS2: RFBI: clock enable/disable changes
Date: Thu, 12 May 2011 14:40:09 +0300
Message-ID: <1305200413-23697-5-git-send-email-tomi.valkeinen@ti.com>
References: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34386 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755256Ab1ELLkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:40:31 -0400
In-Reply-To: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

RFBI enables and disables clocks inside almost every function to get a
finegrained control to the clocks. However, the current understanding is
that this is not necessary power-management-wise.

Change the clocking scheme so that RFBI clocks are enabled when the
omapdss_rfbi_display_enable is called, and disabled when
omapdss_rfbi_display_disable is called.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/rfbi.c |   28 ++++------------------------
 1 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 46817e7..1c19d17 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -163,7 +163,6 @@ EXPORT_SYMBOL(rfbi_bus_unlock);
 
 void omap_rfbi_write_command(const void *buf, u32 len)
 {
-	rfbi_enable_clocks(1);
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
 	{
@@ -187,13 +186,11 @@ void omap_rfbi_write_command(const void *buf, u32 len)
 	default:
 		BUG();
 	}
-	rfbi_enable_clocks(0);
 }
 EXPORT_SYMBOL(omap_rfbi_write_command);
 
 void omap_rfbi_read_data(void *buf, u32 len)
 {
-	rfbi_enable_clocks(1);
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
 	{
@@ -221,13 +218,11 @@ void omap_rfbi_read_data(void *buf, u32 len)
 	default:
 		BUG();
 	}
-	rfbi_enable_clocks(0);
 }
 EXPORT_SYMBOL(omap_rfbi_read_data);
 
 void omap_rfbi_write_data(const void *buf, u32 len)
 {
-	rfbi_enable_clocks(1);
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
 	{
@@ -252,7 +247,6 @@ void omap_rfbi_write_data(const void *buf, u32 len)
 		BUG();
 
 	}
-	rfbi_enable_clocks(0);
 }
 EXPORT_SYMBOL(omap_rfbi_write_data);
 
@@ -264,8 +258,6 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 	int horiz_offset = scr_width - w;
 	int i;
 
-	rfbi_enable_clocks(1);
-
 	if (rfbi.datatype == OMAP_DSS_RFBI_DATATYPE_16 &&
 	   rfbi.parallelmode == OMAP_DSS_RFBI_PARALLELMODE_8) {
 		const u16 __iomem *pd = buf;
@@ -310,8 +302,6 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 	} else {
 		BUG();
 	}
-
-	rfbi_enable_clocks(0);
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
@@ -332,8 +322,6 @@ void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 	rfbi.framedone_callback = callback;
 	rfbi.framedone_callback_data = data;
 
-	rfbi_enable_clocks(1);
-
 	rfbi_write_reg(RFBI_PIXEL_CNT, width * height);
 
 	l = rfbi_read_reg(RFBI_CONTROL);
@@ -352,8 +340,6 @@ static void framedone_callback(void *data, u32 mask)
 
 	REG_FLD_MOD(RFBI_CONTROL, 0, 0, 0);
 
-	rfbi_enable_clocks(0);
-
 	callback = rfbi.framedone_callback;
 	rfbi.framedone_callback = NULL;
 
@@ -462,7 +448,6 @@ void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t)
 
 	BUG_ON(!t->converted);
 
-	rfbi_enable_clocks(1);
 	rfbi_write_reg(RFBI_ONOFF_TIME(rfbi_module), t->tim[0]);
 	rfbi_write_reg(RFBI_CYCLE_TIME(rfbi_module), t->tim[1]);
 
@@ -471,7 +456,6 @@ void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t)
 		    (t->tim[2] ? 1 : 0), 4, 4);
 
 	rfbi_print_timings();
-	rfbi_enable_clocks(0);
 }
 
 static int ps_to_rfbi_ticks(int time, int div)
@@ -659,7 +643,6 @@ int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 	DSSDBG("setup_te: mode %d hs %d vs %d hs_inv %d vs_inv %d\n",
 		mode, hs, vs, hs_pol_inv, vs_pol_inv);
 
-	rfbi_enable_clocks(1);
 	rfbi_write_reg(RFBI_HSYNC_WIDTH, hs);
 	rfbi_write_reg(RFBI_VSYNC_WIDTH, vs);
 
@@ -672,7 +655,6 @@ int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 		l &= ~(1 << 20);
 	else
 		l |= 1 << 20;
-	rfbi_enable_clocks(0);
 
 	return 0;
 }
@@ -687,7 +669,6 @@ int omap_rfbi_enable_te(bool enable, unsigned line)
 	if (line > (1 << 11) - 1)
 		return -EINVAL;
 
-	rfbi_enable_clocks(1);
 	l = rfbi_read_reg(RFBI_CONFIG(0));
 	l &= ~(0x3 << 2);
 	if (enable) {
@@ -697,7 +678,6 @@ int omap_rfbi_enable_te(bool enable, unsigned line)
 		rfbi.te_enabled = 0;
 	rfbi_write_reg(RFBI_CONFIG(0), l);
 	rfbi_write_reg(RFBI_LINE_NUMBER, line);
-	rfbi_enable_clocks(0);
 
 	return 0;
 }
@@ -836,8 +816,6 @@ int rfbi_configure(int rfbi_module, int bpp, int lines)
 		break;
 	}
 
-	rfbi_enable_clocks(1);
-
 	REG_FLD_MOD(RFBI_CONTROL, 0, 3, 2); /* clear CS */
 
 	l = 0;
@@ -871,8 +849,6 @@ int rfbi_configure(int rfbi_module, int bpp, int lines)
 	DSSDBG("RFBI config: bpp %d, lines %d, cycles: 0x%x 0x%x 0x%x\n",
 	       bpp, lines, cycle1, cycle2, cycle3);
 
-	rfbi_enable_clocks(0);
-
 	return 0;
 }
 EXPORT_SYMBOL(rfbi_configure);
@@ -975,6 +951,8 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
 
+	rfbi_enable_clocks(1);
+
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
@@ -1017,6 +995,8 @@ void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 	omap_dispc_unregister_isr(framedone_callback, NULL,
 			DISPC_IRQ_FRAMEDONE);
 	omap_dss_stop_device(dssdev);
+
+	rfbi_enable_clocks(0);
 }
 EXPORT_SYMBOL(omapdss_rfbi_display_disable);
 
-- 
1.7.4.1

