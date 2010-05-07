From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2.5/4] ARM: add LCDC and MIPI DSI-Tx clock definitions to
 sh7372
Date: Fri, 7 May 2010 12:05:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005071200310.4777@axis700.grange>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754598Ab0EGKFW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 06:05:22 -0400
In-Reply-To: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Define clock objects for switching on and off clocks for LCDC0, LCDC1 and MIPI
DSI-Tx.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Sorry, one more patch to add to the patch-series. In fact nothing breaks 
if you apply this patch before or after the whole series, so, no 
regressions, but to get LCD to actually work you also need this one;) And 
best put it between patches 2 and 3 of the series - that's where 2.5 comes 
from.

 arch/arm/mach-shmobile/clock-sh7372.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index abbc380..66ee47a 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -264,8 +264,12 @@ struct clk div6_clks[] = {
 
 #define R_CLK (&r_clk)
 #define HP_CLK (&div4_clks[DIV4_HP])
+#define B_CLK (&div4_clks[DIV4_B])
 
 static struct clk mstp_clks[] = {
+	MSTP("lcdc0", B_CLK, SMSTPCR1, 0, 0),
+	MSTP("lcdc1", B_CLK, SMSTPCR1, 17, 0),
+	MSTP("dsitx", B_CLK, SMSTPCR1, 18, 0),
 	MSTP("sdhi0", HP_CLK, SMSTPCR3, 14, 0),
 	MSTP("sdhi1", HP_CLK, SMSTPCR3, 13, 0),
 	MSTP("keysc0", R_CLK, SMSTPCR4, 3, 0),
-- 
1.6.2.4

