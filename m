From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] omap: Fix 3630 mux errors
Date: Tue, 02 Feb 2010 18:26:11 -0800
Message-ID: <20100203022611.26347.88140.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61530 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0BCCZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:43 -0500
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Allen Pais <allen.pais@ti.com>

3630 has more mux signals than 34xx. The additional pins
exist in omap36xx_cbp_subset, but are not initialized
as the superset is missing these offsets. This causes
the following errors during the boot:

mux: Unknown entry offset 0x236
mux: Unknown entry offset 0x22e
mux: Unknown entry offset 0x1ec
mux: Unknown entry offset 0x1ee
mux: Unknown entry offset 0x1f4
mux: Unknown entry offset 0x1f6
mux: Unknown entry offset 0x1f8
mux: Unknown entry offset 0x1fa
mux: Unknown entry offset 0x1fc
mux: Unknown entry offset 0x22a
mux: Unknown entry offset 0x226
mux: Unknown entry offset 0x230
mux: Unknown entry offset 0x22c
mux: Unknown entry offset 0x228

Fix this by adding the missing offsets to omap3 superset.
Note that additionally the uninitialized pins need to be
skipped on 34xx.

Based on an earlier patch by Allen Pais <allen.pais@ti.com>.

Reported-by: Allen Pais <allen.pais@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c     |    7 ++++++
 arch/arm/mach-omap2/mux34xx.c |   47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 3f59bd1..19001dd 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -968,6 +968,13 @@ static void __init omap_mux_init_list(struct omap_mux *superset)
 		}
 #endif
 
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)
+		if (!superset->muxnames || !superset->muxnames[0]) {
+			superset++;
+			continue;
+		}
+#endif
+
 		entry = omap_mux_list_add(superset);
 		if (!entry) {
 			printk(KERN_ERR "mux: Could not add entry\n");
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 68e0a59..07aa7b3 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -649,6 +649,53 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
 	_OMAP3_MUXENTRY(UART3_TX_IRTX, 166,
 		"uart3_tx_irtx", NULL, NULL, NULL,
 		"gpio_166", NULL, NULL, "safe_mode"),
+
+	/* Only on 3630, see omap36xx_cbp_subset for the signals */
+	_OMAP3_MUXENTRY(GPMC_A11, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MBUSFLAG, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MREAD, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MWRITE, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_SBUSFLAG, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_SREAD, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_SWRITE, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(GPMC_A11, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD28, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD29, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD32, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD33, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD34, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD35, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD36, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 

