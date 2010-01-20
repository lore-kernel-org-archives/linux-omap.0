From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 3/8] OMAP2/3 PM: Adding powerdomain APIs for reading the next logic and mem state
Date: Wed, 20 Jan 2010 21:00:37 +0530
Message-ID: <1264001442-20078-4-git-send-email-thara@ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <1264001442-20078-2-git-send-email-thara@ti.com>
 <1264001442-20078-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59004 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351Ab0ATPas (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 10:30:48 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0KFUjda012766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 09:30:47 -0600
In-Reply-To: <1264001442-20078-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

This patch adds APIs pwrdm_read_next_logic_pwrst and
pwrdm_read_next_mem_pwrst for reading the next programmed
logic and memory state a powerdomain is to hit in event
of the next power domain state being retention.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c             |   71 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 +
 2 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 26b3f3e..06bf290 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -964,6 +964,29 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_next_logic_pwrst - get next powerdomain logic power state
+ * @pwrdm: struct powerdomain * to get next logic power state
+ *
+ * Return the powerdomain pwrdm's logic power state.  Returns -EINVAL
+ * if the powerdomain pointer is null or returns the next logic
+ * power state upon success.
+ */
+int pwrdm_read_next_logic_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
+					OMAP3430_LOGICSTATEST);
+}
+
+/**
  * pwrdm_read_mem_pwrst - get current memory bank power state
  * @pwrdm: struct powerdomain * to get current memory bank power state
  * @bank: memory bank number (0-3)
@@ -1065,6 +1088,54 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 }
 
 /**
+ * pwrdm_read_next_mem_pwrst - get next memory bank power state
+ * @pwrdm: struct powerdomain * to get mext memory bank power state
+ * @bank: memory bank number (0-3)
+ *
+ * Return the powerdomain pwrdm's next memory power state for bank
+ * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
+ * the target memory bank does not exist or is not controllable, or
+ * returns the next memory power state upon success.
+ */
+int pwrdm_read_next_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	switch (bank) {
+	case 0:
+		m = OMAP3430_SHAREDL1CACHEFLATRETSTATE;
+		break;
+	case 1:
+		m = OMAP3430_L1FLATMEMRETSTATE;
+		break;
+	case 2:
+		m = OMAP3430_SHAREDL2CACHEFLATRETSTATE;
+		break;
+	case 3:
+		m = OMAP3430_SHAREDL2CACHEFLATRETSTATE;
+		break;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					PM_PWSTCTRL, m);
+}
+
+/**
  * pwrdm_clear_all_prev_pwrst - clear previous powerstate register for a pwrdm
  * @pwrdm: struct powerdomain * to clear
  *
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 0b96005..7576559 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -170,8 +170,10 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
 
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_next_logic_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_next_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 
 int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
-- 
1.5.6.3

