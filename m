From: Tero Kristo <t-kristo@ti.com>
Subject: =?UTF-8?q?=5BPATCHv3=2015/27=5D=20ARM=3A=20OMAP3=3A=20clock=3A=20remove=20clock3xxx=2Ec=20file?=
Date: Mon, 25 May 2015 18:00:20 +0300
Message-ID: <1432566032-10860-16-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59937 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbbEYPBd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:33 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This now only has a couple of variables within it, which are used outsi=
de
the file itself. Move these variables to where they are actually used,
and remove the file completely as it is now empty.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile           |    2 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |    2 ++
 arch/arm/mach-omap2/clock3xxx.c        |   33 ------------------------=
--------
 3 files changed, 3 insertions(+), 34 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock3xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index f9d4ccf..07052656 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -186,7 +186,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_dpll.o
 obj-$(CONFIG_SOC_OMAP2430)		+=3D clock2430.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D $(clock-common) clock3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clock34xx.o clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clock3517.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D $(clock-common)
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-oma=
p2/clkt34xx_dpll3m2.c
index 825e3da..6cd2961 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -29,6 +29,8 @@
=20
 #define CYCLES_PER_MHZ			1000000
=20
+struct clk *sdrc_ick_p, *arm_fck_p;
+
 /*
  * CORE DPLL (DPLL3) M2 divider rate programming functions
  *
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/cloc=
k3xxx.c
deleted file mode 100644
index 0b0e3a87..0000000
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * OMAP3-specific clock framework functions
- *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
- *
- * Paul Walmsley
- * Jouni H=C3=B6gander
- *
- * Parts of this code are based on code written by
- * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include "soc.h"
-#include "clock.h"
-#include "clock3xxx.h"
-#include "prm2xxx_3xxx.h"
-#include "prm-regbits-34xx.h"
-#include "cm2xxx_3xxx.h"
-#include "cm-regbits-34xx.h"
-
-/* needed by omap3_core_dpll_m2_set_rate() */
-struct clk *sdrc_ick_p, *arm_fck_p;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
