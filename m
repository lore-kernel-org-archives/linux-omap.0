From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] ARM: DRA7: hwmod: Remove QSPI address space entry from hwmod
Date: Mon, 16 May 2016 10:55:03 +0530
Message-ID: <1463376303-22267-1-git-send-email-vigneshr@ti.com>
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
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

QSPI address space information is passed from device tree. Therefore
remove legacy way of passing address space via hwmod data.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d0e7e5259ec3..fac0a2044da4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -3410,21 +3410,11 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_qspi_addrs[] = {
-	{
-		.pa_start	= 0x4b300000,
-		.pa_end		= 0x4b30007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_1 -> qspi */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__qspi = {
 	.master		= &dra7xx_l3_main_1_hwmod,
 	.slave		= &dra7xx_qspi_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_qspi_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
2.8.2
