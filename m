From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+: clockdomain: add flag that will block autodeps from
 being added for a clockdomain
Date: Tue, 8 Mar 2011 16:56:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081654200.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55984 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab1CHX4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:56:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Add a new clockdomain flag, CLKDM_NO_AUTODEPS, which, when marked on a
clockdomain, will prevent "autodeps" from being associated with the
clockdomain.  ("Autodeps" are sleep dependencies and wakeup
dependencies from/to processor modules that are automatically added to
a clockdomain when it is in hardware-supervised idle mode.  They are
deprecated -- a relic from the old CDP trees -- but are still in use
for OMAP3.)  Autodeps are presumably only needed due to hardware bugs
where a device goes idle unexpectedly.

This patch should allow easy testing of which clockdomains actually
still need autodeps.  Add the flag to the struct clockdomain you wish to 
test, compile, boot, see if system still works :-)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |    4 ++--
 arch/arm/mach-omap2/clockdomain.h |   12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

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
-- 
1.7.2.3

