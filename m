From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/7] OMAP24xx/25xx clock: init osc_ck, sys_ck internal
 lists early
Date: Wed, 22 Apr 2009 20:01:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904222000240.24299@utopia.booyaka.com>
References: <20090414182039.22344.49790.stgit@localhost.localdomain> <20090414182324.22344.71159.stgit@localhost.localdomain> <alpine.DEB.2.00.0904141229580.32081@utopia.booyaka.com> <20090421195421.GB29943@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48485 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZDWCBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 22:01:30 -0400
In-Reply-To: <20090421195421.GB29943@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hello Russell,

On Tue, 21 Apr 2009, Russell King - ARM Linux wrote:

> On Tue, Apr 14, 2009 at 12:31:47PM -0600, Paul Walmsley wrote:
> > On Tue, 14 Apr 2009, Paul Walmsley wrote:
> > > Commit 3f0a820c4c0b4670fb5f164baa5582e23c2ef118 breaks OMAP2xxx boot
> > > during initial propagate_rate() on osc_ck and sys_ck.  Fix by calling
> > > clk_init_one() for these clocks first.
> 
> A better fix would be to move the loop initializing all clocks to be
> immediately after the call to clk_init().

thanks for the comment.  Here's a revised patch:


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 22 Apr 2009 19:48:53 -0600
Subject: [PATCH] OMAP2xxx clock: pre-initialize struct clks early

Commit 3f0a820c4c0b4670fb5f164baa5582e23c2ef118 breaks OMAP2xxx boot
during initial propagate_rate() on osc_ck and sys_ck.  Fix by
pre-initializing all struct clks before running any other clock init
code.  The patch also renames clk_init_one() to clk_preinit() to
distinguish its function from clk_init() and the individual struct clk
init functions.  Incorporates review comments from Russell King
<linux@arm.linux.org.uk>.

Resolves

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.29-omap1 #37)
PC is at propagate_rate+0x10/0x60
LR is at omap2_clk_init+0x30/0x218
...

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |    2 +-
 arch/arm/mach-omap2/clock24xx.c         |    6 +++---
 arch/arm/mach-omap2/clock34xx.c         |    2 +-
 arch/arm/plat-omap/clock.c              |    9 ++++++++-
 arch/arm/plat-omap/include/mach/clock.h |    2 +-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index dafe4f7..571d33d 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -775,7 +775,7 @@ int __init omap1_clk_init(void)
 	arm_idlect1_mask = ~0;
 
 	for (c = omap_clks; c < omap_clks + ARRAY_SIZE(omap_clks); c++)
-		clk_init_one(c->lk.clk);
+		clk_preinit(c->lk.clk);
 
 	cpu_mask = 0;
 	if (cpu_is_omap16xx())
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 1e839c5..61dcc22 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -720,14 +720,14 @@ int __init omap2_clk_init(void)
 
 	clk_init(&omap2_clk_functions);
 
+	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
+		clk_preinit(c->lk.clk);
+
 	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
 	propagate_rate(&osc_ck);
 	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
-	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
-		clk_init_one(c->lk.clk);
-
 	cpu_mask = 0;
 	if (cpu_is_omap2420())
 		cpu_mask |= CK_242X;
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 0a14dca..430c6a0 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -956,7 +956,7 @@ int __init omap2_clk_init(void)
 	clk_init(&omap2_clk_functions);
 
 	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
-		clk_init_one(c->lk.clk);
+		clk_preinit(c->lk.clk);
 
 	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
 		if (c->cpu & cpu_clkflg) {
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 2e06145..508c96a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -239,7 +239,14 @@ void recalculate_root_clocks(void)
 	}
 }
 
-void clk_init_one(struct clk *clk)
+/**
+ * clk_preinit - initialize any fields in the struct clk before clk init
+ * @clk: struct clk * to initialize
+ *
+ * Initialize any struct clk fields needed before normal clk initialization
+ * can run.  No return value.
+ */
+void clk_preinit(struct clk *clk)
 {
 	INIT_LIST_HEAD(&clk->children);
 }
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 073a2c5..793fbc0 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -118,8 +118,8 @@ struct clk_functions {
 
 extern unsigned int mpurate;
 
+extern void clk_preinit(struct clk *clk);
 extern int clk_init(struct clk_functions *custom_clocks);
-extern void clk_init_one(struct clk *clk);
 extern int clk_register(struct clk *clk);
 extern void clk_reparent(struct clk *child, struct clk *parent);
 extern void clk_unregister(struct clk *clk);
-- 
1.6.2.1.307.g91408

