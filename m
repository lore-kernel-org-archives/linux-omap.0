From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] ARM: OMAP2+: CM: make some pointers and function arguments as const
Date: Mon,  6 Nov 2017 14:15:39 +0100
Message-ID: <1509974140-10860-2-git-send-email-bhumirks@gmail.com>
References: <1509974140-10860-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509974140-10860-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, tony@atomide.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make the pointer cm_ll_data of type cm_ll_data as const as it does not
modify the fields of the structure it points too.
After this change, make the argument of cm_register function as const as
it is used to initialise cm_ll_data or used inside an if condition.
Make the pointer argument of cm_unregister function as const as it is only
used inside an if condition.
Add const to the function prototypes too.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-omap2/cm.h        | 4 ++--
 arch/arm/mach-omap2/cm_common.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index e833984..7b66e17 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -72,8 +72,8 @@ int omap_cm_wait_module_idle(u8 part, s16 prcm_mod, u16 idlest_reg,
 			     u8 idlest_shift);
 int omap_cm_module_enable(u8 mode, u8 part, u16 inst, u16 clkctrl_offs);
 int omap_cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs);
-extern int cm_register(struct cm_ll_data *cld);
-extern int cm_unregister(struct cm_ll_data *cld);
+extern int cm_register(const struct cm_ll_data *cld);
+extern int cm_unregister(const struct cm_ll_data *cld);
 int omap_cm_init(void);
 int omap2_cm_base_init(void);
 
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 83c6fa7..adf8858 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -29,7 +29,7 @@
  * common CM functions
  */
 static struct cm_ll_data null_cm_ll_data;
-static struct cm_ll_data *cm_ll_data = &null_cm_ll_data;
+static const struct cm_ll_data *cm_ll_data = &null_cm_ll_data;
 
 /* cm_base: base virtual address of the CM IP block */
 struct omap_domain_base cm_base;
@@ -189,7 +189,7 @@ int omap_cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs)
  * is NULL, or -EEXIST if cm_register() has already been called
  * without an intervening cm_unregister().
  */
-int cm_register(struct cm_ll_data *cld)
+int cm_register(const struct cm_ll_data *cld)
 {
 	if (!cld)
 		return -EINVAL;
@@ -213,7 +213,7 @@ int cm_register(struct cm_ll_data *cld)
  * -EINVAL if @cld is NULL or if @cld does not match the struct
  * cm_ll_data * previously registered by cm_register().
  */
-int cm_unregister(struct cm_ll_data *cld)
+int cm_unregister(const struct cm_ll_data *cld)
 {
 	if (!cld || cm_ll_data != cld)
 		return -EINVAL;
-- 
1.9.1
