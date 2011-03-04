From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: hwmod: use status bit info for reset line
Date: Fri, 4 Mar 2011 14:36:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103041326200.10981@utopia.booyaka.com>
References: <1299026809-32168-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36827 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760195Ab1CDVgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 16:36:53 -0500
In-Reply-To: <1299026809-32168-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hello Omar, 

On Tue, 1 Mar 2011, Omar Ramirez Luna wrote:

> On OMAP2 and OMAP3 the reset ctrl shift doesn't match the
> status bit, as it does on OMAP4, when handling the reset lines.
> 
> This patch adds a new member in the reset info structure, so now it
> can be added as part of hwmod data, and checked accordingly for
> OMAP2 or 3; otherwise, there could be cases when the shift masks
> doesn't match both of the registers, and a successful reset might
> throw an error message or vice versa.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

It's after our -rc6 cutoff, but I'll take it anyway for 2.6.39.  Made a 
few minor changes -- updated patch below -- if you have a chance, please 
give it a quick test.  The 'integration-2.6.39' branch at 
git://git.pwsan.com/linux-integration now contains it.  Or if you have any 
comments about the changes, those are welcome too.


thanks,

- Paul


From: omar ramirez <omar.ramirez@ti.com>
Date: Wed, 2 Mar 2011 00:46:49 +0000
Subject: [PATCH] OMAP2+: hwmod: use status bit info for reset line

On OMAP2 and OMAP3 the reset ctrl shift doesn't match the
status bit, as it does on OMAP4, when handling the reset lines.

This patch adds a new member in the reset info structure, so now it
can be added as part of hwmod data, and checked accordingly for
OMAP2 or 3; otherwise, there could be cases when the shift masks
doesn't match both of the registers, and a successful reset might
throw an error message or vice versa.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
[paul@pwsan.com: added a warning if st_shift used on OMAP4; renamed 'r'
 variable; improved some documentation]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   75 +++++++++++++++-----------
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |   18 ++++---
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    5 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 4 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 028efda..5676e8b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -967,25 +967,29 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 }
 
 /**
- * _lookup_hardreset - return the register bit shift for this hwmod/reset line
+ * _lookup_hardreset - fill register bit info for this hwmod/reset line
  * @oh: struct omap_hwmod *
  * @name: name of the reset line in the context of this hwmod
+ * @ohri: struct omap_hwmod_rst_info * that this function will fill in
  *
  * Return the bit position of the reset line that match the
  * input name. Return -ENOENT if not found.
  */
-static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name)
+static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name,
+			    struct omap_hwmod_rst_info *ohri)
 {
 	int i;
 
 	for (i = 0; i < oh->rst_lines_cnt; i++) {
 		const char *rst_line = oh->rst_lines[i].name;
 		if (!strcmp(rst_line, name)) {
-			u8 shift = oh->rst_lines[i].rst_shift;
-			pr_debug("omap_hwmod: %s: _lookup_hardreset: %s: %d\n",
-				 oh->name, rst_line, shift);
+			ohri->rst_shift = oh->rst_lines[i].rst_shift;
+			ohri->st_shift = oh->rst_lines[i].st_shift;
+			pr_debug("omap_hwmod: %s: %s: %s: rst %d st %d\n",
+				 oh->name, __func__, rst_line, ohri->rst_shift,
+				 ohri->st_shift);
 
-			return shift;
+			return 0;
 		}
 	}
 
@@ -1004,21 +1008,22 @@ static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name)
  */
 static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 {
-	u8 shift;
+	struct omap_hwmod_rst_info ohri;
+	u8 ret;
 
 	if (!oh)
 		return -EINVAL;
 
-	shift = _lookup_hardreset(oh, name);
-	if (IS_ERR_VALUE(shift))
-		return shift;
+	ret = _lookup_hardreset(oh, name, &ohri);
+	if (IS_ERR_VALUE(ret))
+		return ret;
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
-						  shift);
+						  ohri.rst_shift);
 	else if (cpu_is_omap44xx())
 		return omap4_prm_assert_hardreset(oh->prcm.omap4.rstctrl_reg,
-						  shift);
+						  ohri.rst_shift);
 	else
 		return -EINVAL;
 }
@@ -1035,29 +1040,34 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
  */
 static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 {
-	u8 shift;
-	int r;
+	struct omap_hwmod_rst_info ohri;
+	int ret;
 
 	if (!oh)
 		return -EINVAL;
 
-	shift = _lookup_hardreset(oh, name);
-	if (IS_ERR_VALUE(shift))
-		return shift;
+	ret = _lookup_hardreset(oh, name, &ohri);
+	if (IS_ERR_VALUE(ret))
+		return ret;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		r = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
-						 shift);
-	else if (cpu_is_omap44xx())
-		r = omap4_prm_deassert_hardreset(oh->prcm.omap4.rstctrl_reg,
-						 shift);
-	else
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
+						   ohri.rst_shift,
+						   ohri.st_shift);
+	} else if (cpu_is_omap44xx()) {
+		if (ohri.st_shift)
+			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
+			       oh->name, name);
+		ret = omap4_prm_deassert_hardreset(oh->prcm.omap4.rstctrl_reg,
+						   ohri.rst_shift);
+	} else {
 		return -EINVAL;
+	}
 
-	if (r == -EBUSY)
+	if (ret == -EBUSY)
 		pr_warning("omap_hwmod: %s: failed to hardreset\n", oh->name);
 
-	return r;
+	return ret;
 }
 
 /**
@@ -1070,21 +1080,22 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
  */
 static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 {
-	u8 shift;
+	struct omap_hwmod_rst_info ohri;
+	u8 ret;
 
 	if (!oh)
 		return -EINVAL;
 
-	shift = _lookup_hardreset(oh, name);
-	if (IS_ERR_VALUE(shift))
-		return shift;
+	ret = _lookup_hardreset(oh, name, &ohri);
+	if (IS_ERR_VALUE(ret))
+		return ret;
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
-						       shift);
+						       ohri.st_shift);
 	} else if (cpu_is_omap44xx()) {
 		return omap4_prm_is_hardreset_asserted(oh->prcm.omap4.rstctrl_reg,
-						       shift);
+						       ohri.rst_shift);
 	} else {
 		return -EINVAL;
 	}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index ec03625..051213f 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -118,7 +118,8 @@ int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
 /**
  * omap2_prm_deassert_hardreset - deassert a submodule hardreset line and wait
  * @prm_mod: PRM submodule base (e.g. CORE_MOD)
- * @shift: register bit shift corresponding to the reset line to deassert
+ * @rst_shift: register bit shift corresponding to the reset line to deassert
+ * @st_shift: register bit shift for the status of the deasserted submodule
  *
  * Some IPs like dsp or iva contain processors that require an HW
  * reset line to be asserted / deasserted in order to fully enable the
@@ -129,27 +130,28 @@ int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
+int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift)
 {
-	u32 mask;
+	u32 rst, st;
 	int c;
 
 	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
 		return -EINVAL;
 
-	mask = 1 << shift;
+	rst = 1 << rst_shift;
+	st = 1 << st_shift;
 
 	/* Check the current status to avoid de-asserting the line twice */
-	if (omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL, mask) == 0)
+	if (omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL, rst) == 0)
 		return -EEXIST;
 
 	/* Clear the reset status by writing 1 to the status bit */
-	omap2_prm_rmw_mod_reg_bits(0xffffffff, mask, prm_mod, OMAP2_RM_RSTST);
+	omap2_prm_rmw_mod_reg_bits(0xffffffff, st, prm_mod, OMAP2_RM_RSTST);
 	/* de-assert the reset control line */
-	omap2_prm_rmw_mod_reg_bits(mask, 0, prm_mod, OMAP2_RM_RSTCTRL);
+	omap2_prm_rmw_mod_reg_bits(rst, 0, prm_mod, OMAP2_RM_RSTCTRL);
 	/* wait the status to be set */
 	omap_test_timeout(omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTST,
-						  mask),
+						  st),
 			  MAX_MODULE_HARDRESET_WAIT, c);
 
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 49654c8..a1fc62a 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -282,7 +282,8 @@ static inline int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
 		"not suppose to be used on omap4\n");
 	return 0;
 }
-static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
+static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
+						u8 st_shift)
 {
 	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
 		"not suppose to be used on omap4\n");
@@ -300,7 +301,7 @@ extern u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
-extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
+extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
 
 #endif	/* CONFIG_ARCH_OMAP4 */
 #endif
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 709fb67..cac3a76 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -128,6 +128,7 @@ struct omap_hwmod_dma_info {
  * struct omap_hwmod_rst_info - IPs reset lines use by hwmod
  * @name: name of the reset line (module local name)
  * @rst_shift: Offset of the reset bit
+ * @st_shift: Offset of the reset status bit (OMAP2/3 only)
  *
  * @name should be something short, e.g., "cpu0" or "rst". It is defined
  * locally to the hwmod.
@@ -135,6 +136,7 @@ struct omap_hwmod_dma_info {
 struct omap_hwmod_rst_info {
 	const char	*name;
 	u8		rst_shift;
+	u8		st_shift;
 };
 
 /**
-- 
1.7.2.3

