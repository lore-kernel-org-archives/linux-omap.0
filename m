From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 08/18] omap3+: sr: introduce class init,deinit and priv data
Date: Wed,  2 Mar 2011 16:25:21 +0530
Message-ID: <1299063331-27968-9-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42261 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757145Ab1CBK4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:56:53 -0500
Received: by gxk28 with SMTP id 28so2790836gxk.32
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:56:51 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Certain class drivers such as class 1.5 drivers, will need specific
notification that they have to be started up or stopped independent
of smart reflex operation. They also may need private data to be
used for operations of their own, provide the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c             |   14 ++++++++++++++
 arch/arm/plat-omap/include/plat/smartreflex.h |    7 +++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 08e1ee4..35658a2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -220,6 +220,13 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 		return;
 	}
 
+	if (sr_class->class_init &&
+	    sr_class->class_init(sr->voltdm, sr_class->class_priv_data)) {
+		dev_err(&sr->pdev->dev,
+			"%s: SRClass initialization failed\n", __func__);
+		return;
+	}
+
 	if (!sr_class->enable(sr->voltdm))
 		sr->autocomp_active = true;
 }
@@ -235,6 +242,13 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 
 	if (sr->autocomp_active) {
 		sr_class->disable(sr->voltdm, 1);
+		if (sr_class->class_deinit &&
+		    sr_class->class_deinit(sr->voltdm,
+			    sr_class->class_priv_data)) {
+			dev_err(&sr->pdev->dev,
+				"%s: SR[%d]Class deinitialization failed\n",
+				__func__, sr->srid);
+		}
 		sr->autocomp_active = false;
 	}
 }
diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
index 6568c88..8b6ecd9 100644
--- a/arch/arm/plat-omap/include/plat/smartreflex.h
+++ b/arch/arm/plat-omap/include/plat/smartreflex.h
@@ -167,6 +167,8 @@ struct omap_sr_pmic_data {
  *
  * @enable:		API to enable a particular class smaartreflex.
  * @disable:		API to disable a particular class smartreflex.
+ * @class_init:		API to do class specific initialization (optional)
+ * @class_deinit:	API to do class specific initialization (optional)
  * @configure:		API to configure a particular class smartreflex.
  * @notify:		API to notify the class driver about an event in SR.
  *			Not needed for class3.
@@ -174,14 +176,19 @@ struct omap_sr_pmic_data {
  * @class_type:		specify which smartreflex class.
  *			Can be used by the SR driver to take any class
  *			based decisions.
+ * @class_priv_data:	Class specific private data (optional)
  */
 struct omap_sr_class_data {
 	int (*enable)(struct voltagedomain *voltdm);
 	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
+	int (*class_init)(struct voltagedomain *voltdm, void *class_priv_data);
+	int (*class_deinit)(struct voltagedomain *voltdm,
+			void *class_priv_data);
 	int (*configure)(struct voltagedomain *voltdm);
 	int (*notify)(struct voltagedomain *voltdm, u32 status);
 	u8 notify_flags;
 	u8 class_type;
+	void *class_priv_data;
 };
 
 /**
-- 
1.7.1

