From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 04/18] ARM: OMAP5: PM: Set MPUSS-EMIF clock-domain static dependency
Date: Mon, 25 Mar 2013 15:34:56 +0530
Message-ID: <1364205910-32392-5-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35747 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3CYKDx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:03:53 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

With EMIF clock-domain put under hardware supervised control, memory
corruption and untraceable crashes are observed on OMAP5. Further
investigation revealed that there is a weakness in the PRCM on this
specific dynamic dependency.

Async bridge issue which resulted in memory corruption and lock on
OMAP4 continue to exist on OMAP5 too unfortunately and hence the
MPU -> EMIF static dependency continue to be there.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm_omap4plus.c |   42 +++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm_omap4plus.c b/arch/arm/mach-omap2/pm_omap4plus.c
index e920c34..2dadb4e 100644
--- a/arch/arm/mach-omap2/pm_omap4plus.c
+++ b/arch/arm/mach-omap2/pm_omap4plus.c
@@ -195,6 +195,37 @@ static inline int omap4_init_static_deps(void)
 }
 
 /**
+ * omap5_init_static_deps - Add OMAP5 static dependencies
+ *
+ * Add needed static clockdomain dependencies on OMAP5 devices.
+ * Return: 0 on success or 'err' on failures
+ */
+static inline int omap5_init_static_deps(void)
+{
+	struct clockdomain *mpuss_clkdm, *emif_clkdm;
+	int ret = 0;
+
+	/*
+	 * The dynamic dependency between MPUSS -> EMIF is broken and has
+	 * not worked as expected on OMAP5 too. Async bridge issue which
+	 * resulted in memory corruption and lock on OMAP4 continue to
+	 * exist on OMAP5 too and hence the MPU -> EMIF dependency to avoid
+	 * random crashes and lockups.
+	 */
+	mpuss_clkdm = clkdm_lookup("mpu_clkdm");
+	emif_clkdm = clkdm_lookup("emif_clkdm");
+	if (!mpuss_clkdm || !emif_clkdm)
+		return -EINVAL;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	if (ret)
+		pr_err("%s: Failed to add static dependency with %d\n",
+			__func__, ret);
+
+	return ret;
+}
+
+/**
  * omap4_pm_init - Init routine for OMAP4+ devices
  *
  * Initializes all powerdomain and clockdomain target states
@@ -218,10 +249,15 @@ int __init omap4_pm_init(void)
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
+		pr_err("%s: Failed to initialise static dependency with %d\n",
+			__func__, ret);
+		goto err2;
 	}
 
 	ret = omap4_mpuss_init();
-- 
1.7.9.5

