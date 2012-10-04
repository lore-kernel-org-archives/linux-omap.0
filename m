From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 7/7] ARM: omap: voltage: add ABB to voltage scaling
Date: Wed, 3 Oct 2012 18:26:14 -0700
Message-ID: <1349313974-5473-8-git-send-email-mturquette@ti.com>
References: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36984 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab2JDB0p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 21:26:45 -0400
In-Reply-To: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>

Adaptive Body-Bias ldo state should be transitioned (if necessary)
during any voltage scaling operation.

This patch initializes ABB LDO's as a part of the greater voltage domain
initialization sequence and adds the ABB transition callbacks to the
primary voltage domain scaling function, voltdm_scale().

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/voltage.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index f45716c..9cac9fe 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -41,6 +41,7 @@
 
 #include "vc.h"
 #include "vp.h"
+#include "abb.h"
 
 static LIST_HEAD(voltdm_list);
 
@@ -101,10 +102,30 @@ int voltdm_scale(struct voltagedomain *voltdm,
 		return -EINVAL;
 	}
 
+	ret = omap_abb_pre_scale(voltdm, volt);
+	if (ret) {
+		pr_err("%s: abb prescale failed for vdd%s: %d\n",
+				__func__, voltdm->name, ret);
+		goto out;
+	}
+
 	ret = voltdm->scale(voltdm, volt);
-	if (!ret)
-		voltdm->nominal_volt = volt;
+	if (ret) {
+		pr_err("%s: vdd_%s failed to scale: %d\n",
+				__func__, voltdm->name, ret);
+		goto out;
+	}
+
+	voltdm->nominal_volt = volt;
 
+	ret = omap_abb_post_scale(voltdm, volt);
+	if (ret) {
+		pr_err("%s: abb postscale failed for vdd%s: %d\n",
+				__func__, voltdm->name, ret);
+		goto out;
+	}
+
+out:
 	return ret;
 }
 
@@ -300,6 +321,9 @@ int __init omap_voltage_late_init(void)
 			omap_vp_init(voltdm);
 		}
 
+		if (voltdm->abb)
+			omap_abb_init(voltdm);
+
 		/*
 		 * XXX If voltdm->nominal_volt is zero after calling
 		 * voltdm->get_voltage then we are likely running this
-- 
1.7.9.5

