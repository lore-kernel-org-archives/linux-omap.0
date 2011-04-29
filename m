From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 10/12] OMAP2+: hwmod: Add api to enable io_ring wakeup.
Date: Fri, 29 Apr 2011 18:09:54 +0530
Message-ID: <1304080796-625-11-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755976Ab1D2Mmi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 08:42:38 -0400
In-Reply-To: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Add api to enable io_pad wakeup based on mux dynamic pad and
wake_up enable flag initialized during hwmod_mux.

Use the wakeup flag and pad_remux flag and enable wakeup capability
for the pad having these flags enabled.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c              |   34 +++++++++++++++++++++++++
 arch/arm/mach-omap2/serial.c                  |    6 ++++
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/omap_device.c              |   26 +++++++++++++++++++
 5 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e034294..4a12336 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2369,3 +2369,37 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+/**
+ * omap_hwmod_enable_ioring_wakeup - Set wakeup bit for iopad ring.
+ * @oh: struct omap_hwmod *
+ * @enable: based on 0 or 1 set or unset wakeup bit.
+ *
+ * traverse through dynamic pads. If pad is enabled then
+ * set wakeup bit for the mux pin. Return error if pads are
+ * not enabled or not available.
+ */
+int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)
+{
+	struct omap_device_pad *pad;
+	int ret = -EINVAL, j;
+	int val = 0;
+
+	/* Enable pin mux to make pad wake-up capable */
+	if (enable)
+		val = OMAP_WAKEUP_EN;
+	else
+		val = ~OMAP_WAKEUP_EN;
+
+	if (oh->mux->enabled) {
+		for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
+			pad = oh->mux->pads_dynamic[j];
+			if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
+				pad->idle = pad->enable | val;
+				ret = 0;
+			}
+		}
+	}
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 84f3ad1..5b2bdf8 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -212,6 +212,12 @@ static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
 			v &= ~up->wk_mask;
 		__raw_writel(v, up->wk_en);
 	}
+
+	/* Enable or clear io-pad wakeup */
+	if (enable)
+		omap_device_enable_ioring_wakeup(pdev, true);
+	else
+		omap_device_enable_ioring_wakeup(pdev, false);
 }
 
 static void omap_uart_idle_init(struct omap_uart_port_info *uart,
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..ce8e3e8 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -117,6 +117,7 @@ int omap_device_enable_hwmods(struct omap_device *od);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
+int omap_device_enable_ioring_wakeup(struct platform_device *pdev, bool enable);
 
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..b7f8d1b 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -601,6 +601,7 @@ int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
+int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable);
 
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f7c6dca..7df74ba 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -742,6 +742,32 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
 	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
 }
 
+/**
+ * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.
+ * @pdev: platform_device for which wakeup needs to be set.
+ * @enable: based on 0 or 1 set or unset wakeup bit.
+ *
+ * Caller should ensure this is called if device_may_wakeup(dev) is true
+ * traverse through each hwmod and check each available pads
+ * if pad is enabled then set wakeup bit for the mux pin.
+ * Return error if pads are not enabled or not available.
+ * If pad is not enabled for the given device then return NULL.
+ */
+int omap_device_enable_ioring_wakeup(struct platform_device *pdev, bool enable)
+{
+	int ret = -EINVAL, i;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+
+	od = _find_by_pdev(pdev);
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		oh = od->hwmods[i];
+		ret = omap_hwmod_enable_ioring_wakeup(oh, enable);
+	}
+
+	return ret;
+}
+
 /*
  * Public functions intended for use in omap_device_pm_latency
  * .activate_func and .deactivate_func function pointers
-- 
1.7.1

