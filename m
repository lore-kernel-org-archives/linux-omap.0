From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP2+: Fix MMC address space mismatch for am33xx
 and am43xx
Date: Tue, 29 Aug 2017 10:03:32 -0700
Message-ID: <20170829170335.11536-3-tony@atomide.com>
References: <20170829170335.11536-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829170335.11536-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

The address space currently set up for the interconnect data
is different compared to the dts data. We have hwmod data with
offset 0x100 to account for the revision, sysc and syss
register offsets. Let's fix the issue by correcting the MMC
register offsets in hwmod data and removing the unnecessary
duplicate IO range data that we get from device tree anyways.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 30 ----------------------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  6 ++---
 2 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -286,56 +286,26 @@ struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1 = {
 };
 
 /* l4 ls -> mmc0 */
-static struct omap_hwmod_addr_space am33xx_mmc0_addr_space[] = {
-	{
-		.pa_start	= 0x48060100,
-		.pa_end		= 0x48060100 + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__mmc0 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_mmc0_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mmc0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
 /* l4 ls -> mmc1 */
-static struct omap_hwmod_addr_space am33xx_mmc1_addr_space[] = {
-	{
-		.pa_start	= 0x481d8100,
-		.pa_end		= 0x481d8100 + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__mmc1 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_mmc1_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mmc1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
 /* l3 s -> mmc2 */
-static struct omap_hwmod_addr_space am33xx_mmc2_addr_space[] = {
-	{
-		.pa_start	= 0x47810100,
-		.pa_end		= 0x47810100 + SZ_64K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l3_s__mmc2 = {
 	.master		= &am33xx_l3_s_hwmod,
 	.slave		= &am33xx_mmc2_hwmod,
 	.clk		= "l3s_gclk",
-	.addr		= am33xx_mmc2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -778,9 +778,9 @@ struct omap_hwmod am33xx_mcasp1_hwmod = {
 
 /* 'mmc' class */
 static struct omap_hwmod_class_sysconfig am33xx_mmc_sysc = {
-	.rev_offs	= 0x1fc,
-	.sysc_offs	= 0x10,
-	.syss_offs	= 0x14,
+	.rev_offs	= 0x2fc,
+	.sysc_offs	= 0x110,
+	.syss_offs	= 0x114,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
 			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			  SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
-- 
2.14.1
