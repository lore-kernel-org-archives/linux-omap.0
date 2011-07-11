From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 11/12] OMAP: dmtimer: add context save/restore routines
Date: Mon, 11 Jul 2011 16:51:35 +0530
Message-ID: <1310383296-18956-12-git-send-email-tarun.kanti@ti.com>
References: <1310383296-18956-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab1GKMtI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 08:49:08 -0400
In-Reply-To: <1310383296-18956-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Define context register structure and make it member of struct omap_dm_timer.
Also define two routines to save and restore dmtimer context to be used
subsequently.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   48 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |   24 ++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c0e5bab..2405637 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -87,6 +87,54 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 				timer->func_offset);
 }
 
+static void omap_timer_save_context(struct omap_dm_timer *timer)
+{
+	timer->context.tiocp_cfg =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
+	timer->context.tistat =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG);
+	timer->context.tisr =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
+	timer->context.tier =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_INT_EN_REG);
+	timer->context.twer =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
+	timer->context.tclr =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.tcrr =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_COUNTER_REG);
+	timer->context.tldr =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
+	timer->context.tmar =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
+	timer->context.tsicr =
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
+}
+
+static void omap_timer_restore_context(struct omap_dm_timer *timer)
+{
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG,
+				timer->context.tiocp_cfg);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_SYS_STAT_REG,
+				timer->context.tistat);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
+				timer->context.tisr);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG,
+				timer->context.tier);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
+				timer->context.twer);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG,
+				timer->context.tclr);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
+				timer->context.tcrr);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG,
+				timer->context.tldr);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG,
+				timer->context.tmar);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+				timer->context.tsicr);
+}
+
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 {
 	int c;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 6e34094..9a2d7e3 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -234,6 +234,29 @@ int omap_dm_timers_active(void);
 
 #define MAX_WRITE_PEND_WAIT            10000 /* 10ms timeout delay */
 
+struct timer_regs {
+	u32 tidr;
+	u32 tiocp_cfg;
+	u32 tistat;
+	u32 tisr;
+	u32 tier;
+	u32 twer;
+	u32 tclr;
+	u32 tcrr;
+	u32 tldr;
+	u32 ttrg;
+	u32 twps;
+	u32 tmar;
+	u32 tcar1;
+	u32 tsicr;
+	u32 tcar2;
+	u32 tpir;
+	u32 tnir;
+	u32 tcvr;
+	u32 tocr;
+	u32 towr;
+};
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
@@ -245,6 +268,7 @@ struct omap_dm_timer {
 	unsigned posted:1;
 	u8 func_offset;
 	u8 intr_offset;
+	struct timer_regs context;
 	struct platform_device *pdev;
 	struct list_head node;
 };
-- 
1.6.0.4

