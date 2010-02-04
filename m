From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 1/3] OMAP2/3 PM: Adding powerdomain APIs for reading the next logic and mem state
Date: Thu,  4 Feb 2010 22:17:49 +0530
Message-ID: <1265302071-7624-2-git-send-email-thara@ti.com>
References: <1265302071-7624-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758494Ab0BDQsC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 11:48:02 -0500
In-Reply-To: <1265302071-7624-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch adds APIs pwrdm_read_logic_retst and
pwrdm_read_mem_retst for reading the next programmed
logic and memory state a powerdomain is to hit in event
of the next power domain state being retention.

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c             |   73 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 +
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index dc03289..e9eeaa4 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -679,6 +679,29 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_logic_retst - get next powerdomain logic power state
+ * @pwrdm: struct powerdomain * to get next logic power state
+ *
+ * Return the powerdomain pwrdm's logic power state.  Returns -EINVAL
+ * if the powerdomain pointer is null or returns the next logic
+ * power state upon success.
+ */
+int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
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
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstctrl_reg_offs,
+					OMAP3430_LOGICSTATEST);
+}
+
+/**
  * pwrdm_read_mem_pwrst - get current memory bank power state
  * @pwrdm: struct powerdomain * to get current memory bank power state
  * @bank: memory bank number (0-3)
@@ -785,6 +808,56 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 }
 
 /**
+ * pwrdm_read_mem_retst - get next memory bank power state
+ * @pwrdm: struct powerdomain * to get mext memory bank power state
+ * @bank: memory bank number (0-3)
+ *
+ * Return the powerdomain pwrdm's next memory power state for bank
+ * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
+ * the target memory bank does not exist or is not controllable, or
+ * returns the next memory power state upon success.
+ */
+int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
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
+		m = OMAP_MEM0_RETSTATE_MASK;
+		break;
+	case 1:
+		m = OMAP_MEM1_RETSTATE_MASK;
+		break;
+	case 2:
+		m = OMAP_MEM2_RETSTATE_MASK;
+		break;
+	case 3:
+		m = OMAP_MEM3_RETSTATE_MASK;
+		break;
+	case 4:
+		m = OMAP_MEM4_RETSTATE_MASK;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					pwrstctrl_reg_offs, m);
+}
+
+/**
  * pwrdm_clear_all_prev_pwrst - clear previous powerstate register for a pwrdm
  * @pwrdm: struct powerdomain * to clear
  *
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index e15c7e9..6657ff2 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -137,8 +137,10 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
 
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_logic_retst(struct powerdomain *pwrdm);
 int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
 
 int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
-- 
1.7.0.rc1.33.g07cf0f

