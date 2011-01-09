From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap3: clocks: Fix build error 'CK_3430ES2' undeclared here
Date: Mon, 10 Jan 2011 03:46:13 +0530
Message-ID: <1294611373-1992-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45854 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1AIWQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jan 2011 17:16:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

At latest mainline commit 0c21e3aaf6a,  omap2plus build is broken. This
patch is trivial fix for the missed usb clock node for CK_3430ES2PLUS
flag update.

 CHK     include/generated/compile.h
  CC      arch/arm/mach-omap2/clock3xxx_data.o
arch/arm/mach-omap2/clock3xxx_data.c:3289: error: 'CK_3430ES2' undeclared
here (not in a function)
make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d3ab1c9..c54cc33 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3286,7 +3286,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX),
 	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
-- 
1.6.0.4

