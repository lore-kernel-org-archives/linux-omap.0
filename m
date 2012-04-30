From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family detection
Date: Mon, 30 Apr 2012 16:47:14 -0700
Message-ID: <87pqaokcjh.fsf@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:45831 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757128Ab2D3XrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 19:47:17 -0400
Received: by dakh32 with SMTP id h32so4540771dak.23
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 16:47:16 -0700 (PDT)
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com> (Kevin
	Hilman's message of "Thu, 26 Apr 2012 16:29:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> This is a rebased version of this series which is ready for broader
> testing.  I'd especially appreciate testing from those of you with
> AM35x platforms.
>
> Currently, our SoC detection is based on SoC family detection
> (using die ID) and the presence of specific IP blocks (or feature.)
>
> This series begins the separation of the SoC family detection and
> specific IP detection by completely removing IP detection from the SoC
> family detection (cpu_is_*.)

FYI... in order to avoid cross-tree dependencies going upstream, I split
this series up into two seprate series, and just posted them.  One for
just clocks for Paul[1]:

   [PATCH 0/3] ARM: OMAP3: clock: cleanup AM35xx clock flags

and another for converting most of the users of cpu_is_omap35*[2]:

   [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection

Once these are merged, I have one more patch[3] (which depends on both of
the above branches) that will remove all the now unused cpu_is_omap35x*
defintions and the last remaining user in the clock code.

Kevin


[1] http://marc.info/?l=linux-omap&m=133582867311326&w=2
[2] http://marc.info/?l=linux-omap&m=133582910911447&w=2

[3]
>From 88f5523f65d9f6c6a075c363922d2cd250d2cb42 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 4 Jan 2012 15:33:17 -0800
Subject: [PATCH] ARM: OMAP: SoC detection: remove unused cpu_is macros

Remove multiple unused cpu_is_omap35xx macros.

In particular, the cpu_is_omap35* macros for 3503, 3515, 3525 are removed
because they are using omap_has_* feature checks and we want to
remove specific feature detection from SoC family detection.

There are no longer any cpu_is_* checks that depend on specific IP
detection.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Mark A. Greer <mgreer@animalcreek.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c  |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |   33 ---------------------------------
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 9f48f84..31d38c7 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3513,7 +3513,7 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = 0;
 
-	if (cpu_is_omap3517()) {
+	if (cpu_is_am35xx()) {
 		cpu_mask = RATE_IN_34XX;
 		cpu_clkflg = CK_AM35XX;
 	} else if (cpu_is_omap3630()) {
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7b0d8ef..2877fc2 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -252,8 +252,6 @@ IS_AM_SUBCLASS(335x, 0x335)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
- * cpu_is_omap3505():	True for OMAP3505
- * cpu_is_omap3517():	True for OMAP3517
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -277,8 +275,6 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
-IS_OMAP_TYPE(3505, 0x3517)
-IS_OMAP_TYPE(3517, 0x3517)
 
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -293,12 +289,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap2422()		0
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
-#define cpu_is_omap3503()		0
-#define cpu_is_omap3515()		0
-#define cpu_is_omap3525()		0
-#define cpu_is_omap3530()		0
-#define cpu_is_omap3505()		0
-#define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
 #define cpu_is_omap3630()		0
 
@@ -350,12 +340,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 #if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
-# undef cpu_is_omap3503
-# undef cpu_is_omap3515
-# undef cpu_is_omap3525
-# undef cpu_is_omap3530
-# undef cpu_is_omap3505
-# undef cpu_is_omap3517
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
@@ -363,19 +347,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_am33xx
 # undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
-# define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(!omap3_has_sgx()))
-# define cpu_is_omap3515()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(omap3_has_sgx()))
-# define cpu_is_omap3525()		(cpu_is_omap3430() &&		\
-						(!omap3_has_sgx()) &&	\
-						(omap3_has_iva()))
-# define cpu_is_omap3530()		(cpu_is_omap3430())
-# define cpu_is_omap3517()		is_omap3517()
-# define cpu_is_omap3505()		(cpu_is_omap3517() &&		\
-						!omap3_has_sgx())
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti81xx()		is_ti81xx()
@@ -424,10 +395,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (0x1 << 8))
 #define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (0x2 << 8))
 
-#define OMAP3517_CLASS		0x35170034
-#define OMAP3517_REV_ES1_0	OMAP3517_CLASS
-#define OMAP3517_REV_ES1_1	(OMAP3517_CLASS | (0x1 << 8))
-
 #define TI816X_CLASS		0x81600034
 #define TI8168_REV_ES1_0	TI816X_CLASS
 #define TI8168_REV_ES1_1	(TI816X_CLASS | (0x1 << 8))
-- 
1.7.9.2

