From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: Fix usage of invalid iclk / oclk when clock node is not present
Date: Mon, 2 Dec 2013 15:16:41 -0600
Message-ID: <1386019001-10144-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab3LBVRI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Dec 2013 16:17:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

commit dc75925d(OMAP: hwmod: Fix the missing braces) introduced
missing braces, however, we just set return result if clk_get fail
and we populate the error pointer in clk pointer and pass it along to
clk_prepare. This is wrong. The intent seems to be retry remaining
clocks if they are available and warn the ones we cant find clks for.

With the current logic, we see the following crash:
omap_hwmod: l3_main: cannot clk_get interface_clk emac_ick
Unable to handle kernel NULL pointer dereference at virtual address 00000032
pgd = c0004000
[00000032] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc1-00044-gcc9fd5a-dirty #19
task: ce0c3440 ti: ce0c4000 task.ti: ce0c4000
PC is at __clk_prepare+0x10/0x74
LR is at clk_prepare+0x14/0x24
  <snip>
[<c044d59c>] (__clk_prepare+0x10/0x74) from [<c044d9b0>] (clk_prepare+0x14/0x24)
[<c044d9b0>] (clk_prepare+0x14/0x24) from [<c077d8c4>] (_init+0x24c/0x3bc)
[<c077d8c4>] (_init+0x24c/0x3bc) from [<c0027328>] (omap_hwmod_for_each+0x34/0x5c)
[<c0027328>] (omap_hwmod_for_each+0x34/0x5c) from [<c077dfa0>] (__omap_hwmod_setup_all+0x24/0x40)
[<c077dfa0>] (__omap_hwmod_setup_all+0x24/0x40) from [<c0008928>] (do_one_initcall+0x38/0x168)
[<c0008928>] (do_one_initcall+0x38/0x168) from [<c0771be8>] (kernel_init_freeable+0xfc/0x1cc)
[<c0771be8>] (kernel_init_freeable+0xfc/0x1cc) from [<c0521064>] (kernel_init+0x8/0x110)
[<c0521064>] (kernel_init+0x8/0x110) from [<c000e568>] (ret_from_fork+0x14/0x2c)
Code: e92d4038 e2504000 01a05004 0a000005 (e5943034)

So, just warn and continue instead of proceeding and crashing, with
missing clock nodes/bad data, we will eventually fail, however we
should now have enough information to identify the culprit.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d0cf926..411e24f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -787,6 +787,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 			pr_warning("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
 				   oh->name, os->clk);
 			ret = -EINVAL;
+			continue;
 		}
 		os->_clk = c;
 		/*
@@ -823,6 +824,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 			pr_warning("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
 				   oh->name, oc->clk);
 			ret = -EINVAL;
+			continue;
 		}
 		oc->_clk = c;
 		/*
-- 
1.7.9.5

