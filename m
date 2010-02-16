From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/19] OMAP2/3 PM: Adding powerdomain APIs for reading the
	next logic and mem state
Date: Mon, 15 Feb 2010 18:24:45 -0700
Message-ID: <20100216012444.1101.68067.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57407 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488Ab0BPB06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:58 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch adds APIs pwrdm_read_logic_retst and
pwrdm_read_mem_retst for reading the next programmed
logic and memory state a powerdomain is to hit in event
of the next power domain state being retention.
These are needed for OSWR support.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


