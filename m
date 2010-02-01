From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 1/8] OMAP3: Clockdomain: Added API for checking if
 HWSUP is enabled
Date: Mon, 1 Feb 2010 15:10:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002011502070.20004@utopia.booyaka.com>
References: <> <1264182951-9205-1-git-send-email-tero.kristo@nokia.com> <1264182951-9205-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47085 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab0BAWKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 17:10:41 -0500
In-Reply-To: <1264182951-9205-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Tero,

On Fri, 22 Jan 2010, Tero Kristo wrote:

> From: Tero Kristo <tero.kristo@nokia.com>
> 
> omap2_clkdm_get_hwsup(clkdm) can be used to check if automatic HW
> transitions for the domain are enabled or not. This is needed for the
> powerdomain code that adds support for INACTIVE state, as it needs to
> disable HWSUP on the fly for ON state, and re-enable it after returning
> to some other state.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

An updated patch with some revisions is below.  Please let me know if 
there's something that still should be changed.  The revisions are:

1. Split the if-statement expressions up into separate lines per 
CodingStyle

2. Rename omap2_clkdm_get_hwsup() to omap2_clkdm_read_hwsup() to follow 
the general practice in this file and powerdomain.c that functions with 
'_get_' in the name read configuration data, and functions with '_read_' 
read from the hardware (or a cache of the hardware register)

3. Add OMAP4 support

4. Added the extra asterisk in the comment body to indicate 
kerneldoc-format comment

5. Updated patch to apply after the current round of 2.6.34 changes


regards,

- Paul

>From fc2f8ad184e012a5574e1110c359354d247a1709 Mon Sep 17 00:00:00 2001
From: Tero Kristo <tero.kristo@nokia.com>
Date: Mon, 1 Feb 2010 13:41:26 -0700
Subject: [PATCH] OMAP3: Clockdomain: Added API for checking if HWSUP is enabled

omap2_clkdm_read_hwsup(clkdm) can be used to check if automatic HW
transitions for the domain are enabled or not. This is needed for the
powerdomain code that adds support for INACTIVE state, as it needs to
disable HWSUP on the fly for ON state, and re-enable it after returning
to some other state.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
[paul@pwsan.com: added kerneldoc comment magic start; changed function
 name to omap2_clkdm_read_hwsup(); broke up expressions in function
 body; added OMAP4 support]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   30 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clockdomain.h |    1 +
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index a38a615..8dce3c9 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -868,6 +868,36 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 }
 
 /**
+ * omap2_clkdm_read_hwsup - read the hwsup idle transition bit
+ * @clkdm: struct clockdomain *
+ *
+ * Checks whether hardware is allowed to switch the clockdomain @clkdm
+ * automatically into active or idle states. Returns -EINVAL if @clkdm
+ * is NULL; otherwise, 1 if hardware auto-idle is enabled, 0 if not.
+ */
+int omap2_clkdm_read_hwsup(struct clockdomain *clkdm)
+{
+	u32 u, v;
+
+	if (!clkdm)
+		return -EINVAL;
+
+	u = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
+	u &= clkdm->clktrctrl_mask;
+
+	if (cpu_is_omap24xx())
+		v = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
+		v = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+	else
+		BUG();
+
+	v <<= __ffs(clkdm->clktrctrl_mask);
+
+	return (u == v) ? 1 : 0;
+}
+
+/**
  * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
  * @clkdm: struct clockdomain *
  *
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index ba0a6c0..9d25f4e 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -129,6 +129,7 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 
+int omap2_clkdm_read_hwsup(struct clockdomain *clkdm);
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
 
-- 
1.6.6.rc2.5.g49666

