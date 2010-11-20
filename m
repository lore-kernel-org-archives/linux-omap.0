From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv4 10/14] OMAP: dmtimer: access routines to interrupt registers
Date: Sat, 20 Nov 2010 08:09:34 +0530
Message-ID: <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40055 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755071Ab0KSPgi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 10:36:38 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAJFaZOj024129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:36:37 -0600
In-Reply-To: <1290220778-22244-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>

Add low level read/write routines to access dmtimer interrupt
registers. These routines would be used later when we support
OMAP 4 new IP revision. When that happens the present read/write
routines would be used to access dmtimer functional registers
only.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   51 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 958acb8..0479ab0 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -307,6 +307,57 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 	writel(value, timer->io_base + (reg & 0xff));
 }
 
+/**
+ * omap_dm_timer_read_intr_reg - read timer interrupt registers in posted
+ * and non-posted mode
+ * @timer:      timer pointer over which read operation to perform
+ * @reg:        lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
+ */
+static inline
+u32 omap_dm_timer_read_intr_reg(struct omap_dm_timer *timer, u32 reg)
+{
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	reg += pdata->intr_offst;
+	if (timer->posted)
+		while (readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG + pdata->func_offst)
+				& 0xff)) & (reg >> WPSHIFT))
+			cpu_relax();
+	return readl(timer->io_base + (reg & 0xff));
+}
+
+/**
+ * omap_dm_timer_write_intr_reg - write timer interrupt registers in posted
+ * and non-posted mode
+ * @timer:      timer pointer over which write operation is to perform
+ * @reg:        lowest byte holds the register offset
+ * @value:      data to write into the register
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode the write
+ * pending bit must be checked. Otherwise a write on a register which has a
+ * pending write will be lost.
+ */
+static inline
+void omap_dm_timer_write_intr_reg(struct omap_dm_timer *timer, u32 reg,
+						u32 value)
+{
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	reg += pdata->intr_offst;
+	if (timer->posted)
+		while (readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG + pdata->func_offst)
+				& 0xff)) & (reg >> WPSHIFT))
+			cpu_relax();
+	writel(value, timer->io_base + (reg & 0xff));
+}
+
+
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 {
 	int c;
-- 
1.6.0.4

