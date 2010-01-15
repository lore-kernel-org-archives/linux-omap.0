From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/18] OMAP3 clock: move OMAP3-specific DPLL functions to
	dpll3xxx.c
Date: Fri, 15 Jan 2010 02:06:52 -0700
Message-ID: <20100115090650.30690.52329.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48714 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab0AOJIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:13 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>

Mark the OMAP3-specific DPLL functions as being OMAP3-specific by moving
them from mach-omap2/dpll.c to mach-omap2/dpll3xxx.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile   |    2 +-
 arch/arm/mach-omap2/dpll3xxx.c |    0 
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-omap2/{dpll.c => dpll3xxx.c} (100%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 64de2fd..7d46fde 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,7 +6,7 @@
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
 
 omap-2-3-common				= irq.o sdrc.o omap_hwmod.o
-omap-3-4-common				= dpll.o
+omap-3-4-common				= dpll3xxx.o
 prcm-common				= prcm.o powerdomain.o
 clock-common				= clock.o clock_common_data.o clockdomain.o
 
diff --git a/arch/arm/mach-omap2/dpll.c b/arch/arm/mach-omap2/dpll3xxx.c
similarity index 100%
rename from arch/arm/mach-omap2/dpll.c
rename to arch/arm/mach-omap2/dpll3xxx.c


