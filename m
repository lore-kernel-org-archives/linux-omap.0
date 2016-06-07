From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: DRA7: hwmod: remove DSS addresses from hwmod
Date: Tue, 7 Jun 2016 11:32:02 +0300
Message-ID: <1465288322-12118-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

The addresses for DSS are provided in the DT data, so they can be
removed from the hwmod.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d0e7e5259ec3..5f40290ad5dd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2905,58 +2905,27 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__tptc1 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dra7xx_dss_addrs[] = {
-	{
-		.name		= "family",
-		.pa_start	= 0x58000000,
-		.pa_end		= 0x5800007f,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
 /* l3_main_1 -> dss */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__dss = {
 	.master		= &dra7xx_l3_main_1_hwmod,
 	.slave		= &dra7xx_dss_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_dss_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_dss_dispc_addrs[] = {
-	{
-		.name		= "dispc",
-		.pa_start	= 0x58001000,
-		.pa_end		= 0x58001fff,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
 /* l3_main_1 -> dispc */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__dispc = {
 	.master		= &dra7xx_l3_main_1_hwmod,
 	.slave		= &dra7xx_dss_dispc_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_dss_dispc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_dss_hdmi_addrs[] = {
-	{
-		.name		= "hdmi_wp",
-		.pa_start	= 0x58040000,
-		.pa_end		= 0x580400ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_1 -> dispc */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.master		= &dra7xx_l3_main_1_hwmod,
 	.slave		= &dra7xx_dss_hdmi_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_dss_hdmi_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
2.5.0
