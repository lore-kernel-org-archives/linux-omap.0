From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 1/3] ARM: hwmod: RTC: Add lock and unlock functions
Date: Fri, 5 Feb 2016 11:12:30 +0530
Message-ID: <1454650952-20154-2-git-send-email-lokeshvutla@ti.com>
References: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

RTC IP have kicker feature which prevents spurious writes to its registers.
In order to write into any of the RTC registers, KICK values has to be
written to KICK registers.
Introduce omap_hwmod_rtc_unlock/lock functions, which  writes into these
KICK registers inorder to lock and unlock RTC registers.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h       |  2 ++
 arch/arm/mach-omap2/omap_hwmod_reset.c | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 76bce11..649576e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -751,6 +751,8 @@ const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
  */
 
 extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
+void omap_hwmod_rtc_unlock(struct omap_hwmod *oh);
+void omap_hwmod_rtc_lock(struct omap_hwmod *oh);
 
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/omap_hwmod_reset.c
index 65e186c..0e21daa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_reset.c
+++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
@@ -29,6 +29,16 @@
 #include <sound/aess.h>
 
 #include "omap_hwmod.h"
+#include "common.h"
+
+#define OMAP_RTC_STATUS_REG	0x44
+#define OMAP_RTC_KICK0_REG	0x6c
+#define OMAP_RTC_KICK1_REG	0x70
+
+#define OMAP_RTC_KICK0_VALUE	0x83E70B13
+#define OMAP_RTC_KICK1_VALUE	0x95A4F1E0
+#define OMAP_RTC_STATUS_BUSY	BIT(0)
+#define OMAP_RTC_MAX_READY_TIME	50
 
 /**
  * omap_hwmod_aess_preprogram - enable AESS internal autogating
@@ -51,3 +61,58 @@ int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+/**
+ * omap_rtc_wait_not_busy - Wait for the RTC BUSY flag
+ * @oh: struct omap_hwmod *
+ *
+ * For updating certain RTC registers, the MPU must wait
+ * for the BUSY status in OMAP_RTC_STATUS_REG to become zero.
+ * Once the BUSY status is zero, there is a 15-?s access
+ * period in which the MPU can program.
+ */
+static void omap_rtc_wait_not_busy(struct omap_hwmod *oh)
+{
+	int i;
+
+	/* BUSY may stay active for 1/32768 second (~30 usec) */
+	omap_test_timeout(omap_hwmod_read(oh, OMAP_RTC_STATUS_REG)
+			  & OMAP_RTC_STATUS_REG, OMAP_RTC_MAX_READY_TIME, i);
+	/* now we have ~15 usec to read/write various registers */
+}
+
+/**
+ * omap_hwmod_rtc_unlock - Unlock the Kicker mechanism.
+ * @oh: struct omap_hwmod *
+ *
+ * RTC IP have kicker feature. This prevents spurious writes to its registers.
+ * In order to write into any of the RTC registers, KICK values has te be
+ * written in respective KICK registers. This is needed for hwmod to write into
+ * sysconfig register.
+ */
+void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
+{
+	local_irq_disable();
+	omap_rtc_wait_not_busy(oh);
+	omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
+	omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
+	local_irq_enable();
+}
+
+/**
+ * omap_hwmod_rtc_lock - Lock the Kicker mechanism.
+ * @oh: struct omap_hwmod *
+ *
+ * RTC IP have kicker feature. This prevents spurious writes to its registers.
+ * Once the RTC registers are written, KICK mechanism needs to be locked,
+ * in order to prevent any spurious writes. This function locks back the RTC
+ * registers once hwmod completes its write into sysconfig register.
+ */
+void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
+{
+	local_irq_disable();
+	omap_rtc_wait_not_busy(oh);
+	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
+	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
+	local_irq_enable();
+}
-- 
2.1.4
