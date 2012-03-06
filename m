From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
Date: Tue,  6 Mar 2012 10:55:33 +0200
Message-ID: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

CLKS signal for McBSP ports can be selected from internal (PRCM) or external
(ABE_CLKS pin) source.
To be able to use existing code we need to create clock aliases consistent
among OMAP2/3/4.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi,

this patch should fix the clock reparenting on OMAP4 for McBSP ports.

Regards,
Peter

 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 08e86d7..7e76ac3 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3120,6 +3120,10 @@ static struct clk auxclkreq5_ck = {
 static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_443X),
 	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"pad_fck",		&pad_clks_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"pad_fck",		&pad_clks_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"pad_fck",		&pad_clks_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"pad_fck",		&pad_clks_ck,	CK_443X),
 	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck,	CK_443X),
 	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck,	CK_443X),
 	CLK(NULL,	"slimbus_clk",			&slimbus_clk,	CK_443X),
@@ -3254,12 +3258,16 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"mcasp_fck",			&mcasp_fck,	CK_443X),
 	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"prcm_fck",		&mcbsp1_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"mcbsp1_fck",			&mcbsp1_fck,	CK_443X),
 	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"prcm_fck",		&mcbsp2_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"mcbsp2_fck",			&mcbsp2_fck,	CK_443X),
 	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"prcm_fck",		&mcbsp3_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"mcbsp3_fck",			&mcbsp3_fck,	CK_443X),
 	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"prcm_fck",		&mcbsp4_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"mcbsp4_fck",			&mcbsp4_fck,	CK_443X),
 	CLK(NULL,	"mcpdm_fck",			&mcpdm_fck,	CK_443X),
 	CLK(NULL,	"mcspi1_fck",			&mcspi1_fck,	CK_443X),
-- 
1.7.8.5
