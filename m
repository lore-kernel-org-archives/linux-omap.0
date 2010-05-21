From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/5] ARM: add LCDC and MIPI DSI-Tx clock definitions to sh7372
Date: Fri, 21 May 2010 17:15:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005211700420.8450@axis700.grange>
References: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev, @vger.kernel.org" <linux-fbdev@vger.kernel.org>, "lin, ux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

Define clock objects for switching on and off clocks for LCDC0, LCDC1 and MIPI
DSI-Tx.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Now that the "fbdev: add a MIPI DSI header" patch has been acked, we can 
add the rest of the patches in this series, which can completely be pulled 
via the genesis tree. Paul, please apply. This patch is unchanged from its 
original version.

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

