From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: clockdomain: add flag that will block autodeps
 from being added for a clockdomain
Date: Thu, 10 Mar 2011 02:41:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100230110.15132@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103081654200.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36007 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab1CJJlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 04:41:21 -0500
In-Reply-To: <alpine.DEB.2.00.1103081654200.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi,

On Tue, 8 Mar 2011, Paul Walmsley wrote:

> Add a new clockdomain flag, CLKDM_NO_AUTODEPS, which, when marked on a
> clockdomain, will prevent "autodeps" from being associated with the
> clockdomain.  ("Autodeps" are sleep dependencies and wakeup
> dependencies from/to processor modules that are automatically added to
> a clockdomain when it is in hardware-supervised idle mode.  They are
> deprecated -- a relic from the old CDP trees -- but are still in use
> for OMAP3.)  Autodeps are presumably only needed due to hardware bugs
> where a device goes idle unexpectedly.
> 
> This patch should allow easy testing of which clockdomains actually
> still need autodeps.  Add the flag to the struct clockdomain you wish to 
> test, compile, boot, see if system still works :-)
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Kevin observed that this patch misses the sleepdeps that are automatically 
added for hwmods.  Thanks Kevin.  Here's an updated version that deals 
with that.

These functions, _add_initiator_dep() and _del_initiator_dep(), apparently 
only need to run on OMAP2/3, but adding code for that is a more disruptive 
change, so I'll wait on that part until 2.6.40.


- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 8 Mar 2011 16:25:42 -0700
Subject: [PATCH] OMAP2+: clockdomain: add flag that will block autodeps from being added for a clockdomain

Add a new clockdomain flag, CLKDM_NO_AUTODEPS, which, when marked on a
clockdomain, will prevent "autodeps" from being associated with the
clockdomain.  ("Autodeps" are sleep dependencies and wakeup
dependencies from/to processor modules that are automatically added to
a clockdomain when it is in hardware-supervised idle mode.  They are
deprecated -- a relic from the old CDP trees -- but are still in use
for OMAP3.)

Also, prevent the hwmod code from adding or removing initiator 
dependencies for clockdomains with this flag set.

This patch should allow others to test which clockdomains actually
still need autodeps.

Thanks to Kevin Hilman <khilman@ti.com> for noting that the original 
version should also modify the hwmod code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    4 ++--
 arch/arm/mach-omap2/clockdomain.h |   12 ++++++++++--
 arch/arm/mach-omap2/omap_hwmod.c  |   16 ++++++++++++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 58e42f7..2b4ab0b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -181,7 +181,7 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
-	if (!autodeps)
+	if (!autodeps || clkdm->flags & CLKDM_NO_AUTODEPS)
 		return;
 
 	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
@@ -215,7 +215,7 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
-	if (!autodeps)
+	if (!autodeps || clkdm->flags & CLKDM_NO_AUTODEPS)
 		return;
 
 	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 9b459c2..5add071 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -4,7 +4,7 @@
  * OMAP2/3 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008-2010 Nokia Corporation
+ * Copyright (C) 2008-2011 Nokia Corporation
  *
  * Paul Walmsley
  *
@@ -22,11 +22,19 @@
 #include <plat/clock.h>
 #include <plat/cpu.h>
 
-/* Clockdomain capability flags */
+/*
+ * Clockdomain flags
+ *
+ * XXX Document CLKDM_CAN_* flags
+ *
+ * CLKDM_NO_AUTODEPS: Prevent "autodeps" from being added/removed from this
+ *     clockdomain.  (Currently, this applies to OMAP3 clockdomains only.)
+ */
 #define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
 #define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
 #define CLKDM_CAN_ENABLE_AUTO			(1 << 2)
 #define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
+#define CLKDM_NO_AUTODEPS			(1 << 4)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a68a2cf..2dd1ea9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -460,14 +460,18 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
  * will be accessed by a particular initiator (e.g., if a module will
  * be accessed by the IVA, there should be a sleepdep between the IVA
  * initiator and the module).  Only applies to modules in smart-idle
- * mode.  Returns -EINVAL upon error or passes along
- * clkdm_add_sleepdep() value upon success.
+ * mode.  If the clockdomain is marked as not needing autodeps, return
+ * 0 without doing anything.  Otherwise, returns -EINVAL upon error or
+ * passes along clkdm_add_sleepdep() value upon success.
  */
 static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
 	if (!oh->_clk)
 		return -EINVAL;
 
+	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+		return 0;
+
 	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
 }
 
@@ -480,14 +484,18 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  * be accessed by a particular initiator (e.g., if a module will not
  * be accessed by the IVA, there should be no sleepdep between the IVA
  * initiator and the module).  Only applies to modules in smart-idle
- * mode.  Returns -EINVAL upon error or passes along
- * clkdm_del_sleepdep() value upon success.
+ * mode.  If the clockdomain is marked as not needing autodeps, return
+ * 0 without doing anything.  Returns -EINVAL upon error or passes
+ * along clkdm_del_sleepdep() value upon success.
  */
 static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
 	if (!oh->_clk)
 		return -EINVAL;
 
+	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+		return 0;
+
 	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
 }
 
-- 
1.7.2.3

