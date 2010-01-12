From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/10] OMAP2/3/4 clockdomain: add clkdm_clear_all_{wkdep,
	sleepdep}s()
Date: Mon, 11 Jan 2010 18:05:39 -0700
Message-ID: <20100112010538.6275.20332.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45290 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab0ALBQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 20:16:22 -0500
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Add clkdm_clear_all_wkdeps() and clkdm_clear_all_sleepdeps().  These functions
provide a fast way for code to clear all hardware clockdomain dependencies,
since accesses to these registers can be quite slow.  These functions
are currently targeted for use by PM branch code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   68 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clockdomain.h |    2 +
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index d039df7..f44d9ea 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -565,6 +565,38 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 }
 
 /**
+ * clkdm_clear_all_wkdeps - remove all wakeup dependencies from target clkdm
+ * @clkdm: struct clockdomain * to remove all wakeup dependencies from
+ *
+ * Remove all inter-clockdomain wakeup dependencies that could cause
+ * @clkdm to wake.  Intended to be used during boot to initialize the
+ * PRCM to a known state, after all clockdomains are put into swsup idle
+ * and woken up.  Returns -EINVAL if @clkdm pointer is invalid, or
+ * 0 upon success.
+ */
+int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	if (!clkdm)
+		return -EINVAL;
+
+	for (cd = clkdm->wkdep_srcs; cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->wkdep_usecount, 0);
+	}
+
+	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+
+/**
  * clkdm_add_sleepdep - add a sleep dependency from clkdm2 to clkdm1
  * @clkdm1: prevent this struct clockdomain * from sleeping (dependent)
  * @clkdm2: when this struct clockdomain * is active (source)
@@ -690,6 +722,42 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 }
 
 /**
+ * clkdm_clear_all_sleepdeps - remove all sleep dependencies from target clkdm
+ * @clkdm: struct clockdomain * to remove all sleep dependencies from
+ *
+ * Remove all inter-clockdomain sleep dependencies that could prevent
+ * @clkdm from idling.	Intended to be used during boot to initialize the
+ * PRCM to a known state, after all clockdomains are put into swsup idle
+ * and woken up.  Returns -EINVAL if @clkdm pointer is invalid, or
+ * 0 upon success.
+ */
+int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm)
+		return -EINVAL;
+
+	for (cd = clkdm->sleepdep_srcs; cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->sleepdep_usecount, 0);
+	}
+
+	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+			       OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
+
+/**
  * omap2_clkdm_clktrctrl_read - read the clkdm's current state transition mode
  * @clk: struct clk * of a clockdomain
  *
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index 192cc95..45b5deb 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -132,9 +132,11 @@ struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
 int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
 int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);


