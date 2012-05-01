From: jean.pihet@newoldbits.com
Subject: [PATCH 3/5] ARM: OMAP2+: PM: use the power domains registers cache for the logic and mem states
Date: Tue,  1 May 2012 15:07:41 +0200
Message-ID: <1335877663-32649-4-git-send-email-j-pihet@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35093 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab2EANIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 09:08:14 -0400
Received: by wibhj6 with SMTP id hj6so3712987wib.1
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 06:08:13 -0700 (PDT)
In-Reply-To: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Use the caching API for the previous, current and next
power domains logical and memory states.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |  108 ++++++++++++++++++++++++++++---------
 1 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 2058e27..9800b2b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1011,11 +1011,15 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	if (!(pwrdm->pwrsts_logic_ret & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next logic powerstate for %s to %0x\n",
+	pr_debug("powerdomain: setting next logic RET state for %s to %0x\n",
 		 pwrdm->name, pwrst);
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_logic_retst)
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_logic_retst) {
 		ret = arch_pwrdm->pwrdm_set_logic_retst(pwrdm, pwrst);
+		if (!ret)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_NEXT_LOGIC_RETST,
+					  pwrst);
+	}
 
 	return ret;
 }
@@ -1023,13 +1027,13 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 /**
  * pwrdm_set_mem_onst - set memory power state while powerdomain ON
  * @pwrdm: struct powerdomain * to set
- * @bank: memory bank number to set (0-3)
+ * @bank: memory bank number to set (0-PWRDM_MAX_MEM_BANKS)
  * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the ON
- * state.  @bank will be a number from 0 to 3, and represents different
- * types of memory, depending on the powerdomain.  Returns -EINVAL if
+ * state.  @bank represents different types of memory, depending on
+ * the powerdomain.  Returns -EINVAL if
  * the powerdomain pointer is null or the target power state is not
  * not supported for this memory bank, -EEXIST if the target memory
  * bank does not exist or is not controllable, or returns 0 upon
@@ -1051,8 +1055,12 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	pr_debug("powerdomain: setting next memory powerstate for domain %s "
 		 "bank %0x while pwrdm-ON to %0x\n", pwrdm->name, bank, pwrst);
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst)
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst) {
 		ret = arch_pwrdm->pwrdm_set_mem_onst(pwrdm, bank, pwrst);
+		if (!ret)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_MEM_ONST + bank,
+					  pwrst);
+	}
 
 	return ret;
 }
@@ -1060,13 +1068,13 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 /**
  * pwrdm_set_mem_retst - set memory power state while powerdomain in RET
  * @pwrdm: struct powerdomain * to set
- * @bank: memory bank number to set (0-3)
+ * @bank: memory bank number to set (0-PWRDM_MAX_MEM_BANKS)
  * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the
- * RETENTION state.  Bank will be a number from 0 to 3, and represents
- * different types of memory, depending on the powerdomain.  @pwrst
+ * RETENTION state.  Bank represents different types of memory,
+ * depending on the powerdomain.  @pwrst
  * will be either RETENTION or OFF, if supported.  Returns -EINVAL if
  * the powerdomain pointer is null or the target power state is not
  * not supported for this memory bank, -EEXIST if the target memory
@@ -1089,8 +1097,13 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	pr_debug("powerdomain: setting next memory powerstate for domain %s "
 		 "bank %0x while pwrdm-RET to %0x\n", pwrdm->name, bank, pwrst);
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst)
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst) {
 		ret = arch_pwrdm->pwrdm_set_mem_retst(pwrdm, bank, pwrst);
+		if (!ret)
+			pwrdm_cache_write(pwrdm,
+					  PWRDM_CACHE_NEXT_MEM_RETST + bank,
+					  pwrst);
+	}
 
 	return ret;
 }
@@ -1106,13 +1119,19 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  */
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = -EINVAL;
+	int retst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_pwrst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_LOGIC_RETST, &retst))
+		return retst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_pwrst) {
 		ret = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_LOGIC_RETST, ret);
+	}
 
 	return ret;
 }
@@ -1127,13 +1146,20 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = -EINVAL;
+	int retst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_logic_pwrst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_PREV_LOGIC_PWRST, &retst))
+		return retst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_logic_pwrst) {
 		ret = arch_pwrdm->pwrdm_read_prev_logic_pwrst(pwrdm);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_PREV_LOGIC_PWRST,
+					  ret);
+	}
 
 	return ret;
 }
@@ -1142,19 +1168,26 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
  * pwrdm_read_logic_retst - get next powerdomain logic power state
  * @pwrdm: struct powerdomain * to get next logic power state
  *
- * Return the powerdomain pwrdm's logic power state.  Returns -EINVAL
+ * Return the powerdomain pwrdm's next logic power state.  Returns -EINVAL
  * if the powerdomain pointer is null or returns the next logic
  * power state upon success.
  */
 int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
-	int ret = -EINVAL;
+	int retst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_retst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_NEXT_LOGIC_RETST, &retst))
+		return retst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_retst) {
 		ret = arch_pwrdm->pwrdm_read_logic_retst(pwrdm);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_NEXT_LOGIC_RETST,
+					  ret);
+	}
 
 	return ret;
 }
@@ -1162,7 +1195,7 @@ int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 /**
  * pwrdm_read_mem_pwrst - get current memory bank power state
  * @pwrdm: struct powerdomain * to get current memory bank power state
- * @bank: memory bank number (0-3)
+ * @bank: memory bank number (0-PWRDM_MAX_MEM_BANKS)
  *
  * Return the powerdomain @pwrdm's current memory power state for bank
  * @bank.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
@@ -1171,7 +1204,7 @@ int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
-	int ret = -EINVAL;
+	int pwrst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return ret;
@@ -1182,8 +1215,15 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
 		bank = 1;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_pwrst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_MEM_PWRST + bank, &pwrst))
+		return pwrst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_pwrst) {
 		ret = arch_pwrdm->pwrdm_read_mem_pwrst(pwrdm, bank);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_MEM_PWRST + bank,
+					  ret);
+	}
 
 	return ret;
 }
@@ -1191,7 +1231,7 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 /**
  * pwrdm_read_prev_mem_pwrst - get previous memory bank power state
  * @pwrdm: struct powerdomain * to get previous memory bank power state
- * @bank: memory bank number (0-3)
+ * @bank: memory bank number (0-PWRDM_MAX_MEM_BANKS)
  *
  * Return the powerdomain @pwrdm's previous memory power state for
  * bank @bank.  Returns -EINVAL if the powerdomain pointer is null,
@@ -1201,7 +1241,7 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
  */
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
-	int ret = -EINVAL;
+	int pwrst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return ret;
@@ -1212,8 +1252,16 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
 		bank = 1;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_mem_pwrst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_PREV_MEM_PWRST + bank, &pwrst))
+		return pwrst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_mem_pwrst) {
 		ret = arch_pwrdm->pwrdm_read_prev_mem_pwrst(pwrdm, bank);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm,
+					  PWRDM_CACHE_PREV_MEM_PWRST + bank,
+					  ret);
+	}
 
 	return ret;
 }
@@ -1221,7 +1269,7 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 /**
  * pwrdm_read_mem_retst - get next memory bank power state
  * @pwrdm: struct powerdomain * to get mext memory bank power state
- * @bank: memory bank number (0-3)
+ * @bank: memory bank number (0-PWRDM_MAX_MEM_BANKS)
  *
  * Return the powerdomain pwrdm's next memory power state for bank
  * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
@@ -1230,7 +1278,7 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
  */
 int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 {
-	int ret = -EINVAL;
+	int pwrst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return ret;
@@ -1238,8 +1286,16 @@ int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->banks < (bank + 1))
 		return ret;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_retst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_NEXT_MEM_RETST + bank, &pwrst))
+		return pwrst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_retst) {
 		ret = arch_pwrdm->pwrdm_read_mem_retst(pwrdm, bank);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm,
+					  PWRDM_CACHE_NEXT_MEM_RETST + bank,
+					  ret);
+	}
 
 	return ret;
 }
-- 
1.7.7.6

