From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv4 1/8] OMAP3: Clockdomain: Added API for checking if HWSUP is enabled
Date: Fri, 22 Jan 2010 19:55:44 +0200
Message-ID: <1264182951-9205-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1264182951-9205-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21234 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab0AVQFN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 11:05:13 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o0MG4xtv000328
	for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 18:05:10 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o0MG51XJ002591
	for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 18:05:03 +0200
In-Reply-To: <1264182951-9205-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

omap2_clkdm_get_hwsup(clkdm) can be used to check if automatic HW
transitions for the domain are enabled or not. This is needed for the
powerdomain code that adds support for INACTIVE state, as it needs to
disable HWSUP on the fly for ON state, and re-enable it after returning
to some other state.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   27 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clockdomain.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index dd285f0..728d1b0 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -472,6 +472,33 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 	return 0;
 }
 
+/*
+ * omap2_clkdm_get_hwsup - get the hwsup idle transition bit
+ * @clkdm: struct clockdomain *
+ *
+ * Checks whether hardware is allowed to switch the clockdomain
+ * automatically into active or idle states. Returns 1 if yes,
+ * 0 otherwise.
+ */
+int omap2_clkdm_get_hwsup(struct clockdomain *clkdm)
+{
+	u32 v;
+
+	if (cpu_is_omap24xx())
+		v = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
+	else if (cpu_is_omap34xx())
+		v = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+	else
+		BUG();
+
+	if ((cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL) &
+			clkdm->clktrctrl_mask) ==
+			(v << __ffs(clkdm->clktrctrl_mask)))
+		return 1;
+
+	return 0;
+}
+
 /**
  * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
  * @clkdm: struct clockdomain *
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index eb73482..9127459 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -99,6 +99,7 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
 			void *user);
 struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
 
+int omap2_clkdm_get_hwsup(struct clockdomain *clkdm);
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
 
-- 
1.5.4.3

