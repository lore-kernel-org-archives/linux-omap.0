From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 1/4] rtc: OMAP: Add support for rtc-only mode
Date: Wed, 3 Apr 2019 10:27:39 +0530
Message-ID: <20190403045742.2243-2-j-keerthy@ti.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190403045742.2243-1-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, alexandre.belloni@bootlin.com, a.zummo@towertech.it, t-kristo@ti.com
Cc: linux-rtc@vger.kernel.org, d-gerlach@ti.com, j-keerthy@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Prepare rtc driver for rtc-only with DDR in self-refresh mode.
omap_rtc_power_off now should cater to two features:

1) RTC plus DDR in self-refresh is power a saving mode where in the
entire system including the different voltage rails from PMIC are
shutdown except the ones feeding on to RTC and DDR. DDR is kept in
self-refresh hence the contents are preserved. RTC ALARM2 is connected
to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
ALARM1 triggers waking up the system[1]. The control goes to bootloader.
The bootloader then checks RTC scratchpad registers to confirm it was an
rtc_only wakeup and follows a different path, configure bare minimal
clocks for ddr and then jumps to the resume address in another RTC
scratchpad registers and transfers the control to Kernel. Kernel then
restores the saved context. omap_rtc_power_off_program does the ALARM2
programming part.

     [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884

2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
above omap_rtc_power_off_program function and in addition to that
programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
the pushbutton and shuts off the PMIC.

Hence the split in omap_rtc_power_off.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v3:

  * Exported out omap_rtc_power_off_program to rtc-omap header file

 drivers/rtc/rtc-omap.c       | 49 ++++++++++++++++++++++++++++++------
 include/linux/rtc/rtc-omap.h |  7 ++++++
 2 files changed, 48 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/rtc/rtc-omap.h

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 32994b0dd139..a2941c875a06 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -403,15 +403,12 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static struct omap_rtc *omap_rtc_power_off_rtc;
 
-/*
- * omap_rtc_poweroff: RTC-controlled power off
- *
- * The RTC can be used to control an external PMIC via the pmic_power_en pin,
- * which can be configured to transition to OFF on ALARM2 events.
- *
- * Called with local interrupts disabled.
+/**
+ * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
+ * generates pmic_pwr_enable control, which can be used to control an external
+ * PMIC.
  */
-static void omap_rtc_power_off(void)
+int omap_rtc_power_off_program(struct device *dev)
 {
 	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
 	struct rtc_time tm;
@@ -425,6 +422,9 @@ static void omap_rtc_power_off(void)
 	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
 
 again:
+	/* Clear any existing ALARM2 event */
+	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);
+
 	/* set alarm one second from now */
 	omap_rtc_read_time_raw(rtc, &tm);
 	seconds = tm.tm_sec;
@@ -461,6 +461,39 @@ static void omap_rtc_power_off(void)
 
 	rtc->type->lock(rtc);
 
+	return 0;
+}
+EXPORT_SYMBOL(omap_rtc_power_off_program);
+
+/*
+ * omap_rtc_poweroff: RTC-controlled power off
+ *
+ * The RTC can be used to control an external PMIC via the pmic_power_en pin,
+ * which can be configured to transition to OFF on ALARM2 events.
+ *
+ * Notes:
+ * The one-second alarm offset is the shortest offset possible as the alarm
+ * registers must be set before the next timer update and the offset
+ * calculation is too heavy for everything to be done within a single access
+ * period (~15 us).
+ *
+ * Called with local interrupts disabled.
+ */
+static void omap_rtc_power_off(void)
+{
+	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
+	u32 val;
+
+	omap_rtc_power_off_program(rtc->dev.parent);
+
+	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
+	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
+	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
+	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
+			OMAP_RTC_PMIC_EXT_WKUP_EN(0);
+	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
+	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
+
 	/*
 	 * Wait for alarm to trigger (within one second) and external PMIC to
 	 * power off the system. Add a 500 ms margin for external latencies
diff --git a/include/linux/rtc/rtc-omap.h b/include/linux/rtc/rtc-omap.h
new file mode 100644
index 000000000000..9f03a329e63f
--- /dev/null
+++ b/include/linux/rtc/rtc-omap.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_RTCOMAP_H_
+#define _LINUX_RTCOMAP_H_
+
+int omap_rtc_power_off_program(struct device *dev);
+#endif /* _LINUX_RTCOMAP_H_ */
-- 
2.17.1
