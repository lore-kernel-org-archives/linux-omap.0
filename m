From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 04/15] ARM: OMAP5: PM: Set MPUSS-EMIF clock-domain static dependency
Date: Fri, 1 Mar 2013 17:40:53 +0530
Message-ID: <1362139864-9233-5-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab3CAMKG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 07:10:06 -0500
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

With EMIF clock-domain put under hardware supervised control, memory
corruption and untraceable crashes are observed on OMAP5. Further
investigation revealed that there is a weakness in the PRCM on this
specific dynamic depedency.

The recommendation is to set MPUSS static dependency towards EMIF
clock-domain to avoid issues.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm_omap4plus.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm_omap4plus.c b/arch/arm/mach-omap2/pm_omap4plus.c
index 95d2712..4c37c47 100644
--- a/arch/arm/mach-omap2/pm_omap4plus.c
+++ b/arch/arm/mach-omap2/pm_omap4plus.c
@@ -168,6 +168,32 @@ static inline int omap4_init_static_deps(void)
 }
 
 /**
+ * omap5_init_static_deps - Init static clkdm dependencies on OMAP5
+ *
+ * The dynamic dependency between MPUSS -> EMIF is broken and has
+ * not worked as expected. The hardware recommendation is to
+ * enable static dependencies for these to avoid system
+ * lock ups or random crashes.
+ */
+static inline int omap5_init_static_deps(void)
+{
+	struct clockdomain *mpuss_clkdm, *emif_clkdm;
+	int ret;
+
+	mpuss_clkdm = clkdm_lookup("mpu_clkdm");
+	emif_clkdm = clkdm_lookup("emif_clkdm");
+	if (!mpuss_clkdm || !emif_clkdm)
+		return -EINVAL;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	if (ret)
+		pr_err("Failed to add MPUSS -> EMIF wakeup dependency\n");
+
+	return ret;
+}
+
+
+/**
  * omap4_pm_init - Init routine for OMAP4+ devices
  *
  * Initializes all powerdomain and clockdomain target states
@@ -190,10 +216,14 @@ int __init omap4_pm_init(void)
 		goto err2;
 	}
 
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap44xx())
 		ret = omap4_init_static_deps();
-		if (ret)
-			goto err2;
+	else if (soc_is_omap54xx())
+		ret = omap5_init_static_deps();
+
+	if (ret) {
+		pr_err("Failed to initialise static dependencies.\n");
+		goto err2;
 	}
 
 	ret = omap4_mpuss_init();
-- 
1.7.9.5

