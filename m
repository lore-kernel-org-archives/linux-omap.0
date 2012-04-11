From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 11/12] ARM: OMAP1: DMTIMER: fix broken timer clock source
 selection
Date: Tue, 10 Apr 2012 18:36:02 -0600
Message-ID: <20120411003559.27059.1315.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43939 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759918Ab2DKAiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:22 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

DMTIMER source selection on OMAP1 is broken.  omap1_dm_timer_set_src()
tries to use __raw_{read,write}l() to read from and write to physical
addresses, but those functions take virtual addresses.

sparse caught this:

arch/arm/mach-omap1/timer.c:50:13: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap1/timer.c:50:13:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap1/timer.c:50:13:    got unsigned int
arch/arm/mach-omap1/timer.c:52:9: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap1/timer.c:52:9:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap1/timer.c:52:9:    got unsigned int

Fix by using omap_{read,writel}(), just like the other users of the
MOD_CONF_CTRL_1 register in the OMAP1 codebase.  Of course, in the long term,
removing omap_{read,write}l() is the appropriate thing to do; but
this will take some work to do this cleanly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 5536e04..64c65bc 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -47,9 +47,9 @@ static int omap1_dm_timer_set_src(struct platform_device *pdev,
 	int n = (pdev->id - 1) << 1;
 	u32 l;
 
-	l = __raw_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
+	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
 	l |= source << n;
-	__raw_writel(l, MOD_CONF_CTRL_1);
+	omap_writel(l, MOD_CONF_CTRL_1);
 
 	return 0;
 }


