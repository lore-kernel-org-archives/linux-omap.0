From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Fix ti_sysc_find_one_clockdomain to check for to_clk_hw_omap
Date: Mon, 16 Dec 2019 16:09:05 -0800
Message-ID: <20191217000906.43658-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We must bail out early if the clock is not hw_omap. Otherwise we will
try to access invalid address with hwclk->clkdm_name:

Unable to handle kernel paging request at virtual address ffffffff
Internal error: Oops: 27 [#1] ARM
...
(strcmp) from [<c011b348>] (clkdm_lookup+0x40/0x60)
[<c011b348>] (clkdm_lookup) from [<c011cb84>] (ti_sysc_clkdm_init+0x5c/0x64)
[<c011cb84>] (ti_sysc_clkdm_init) from [<c03680a8>] (sysc_probe+0x948/0x117c)
[<c03680a8>] (sysc_probe) from [<c03d0af4>] (platform_drv_probe+0x48/0x98)
...

Fixes: 2b2f7def058a ("bus: ti-sysc: Add support for missing clockdomain handling")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -306,10 +306,14 @@ static void __init dra7x_evm_mmc_quirk(void)
 
 static struct clockdomain *ti_sysc_find_one_clockdomain(struct clk *clk)
 {
+	struct clk_hw *hw = __clk_get_hw(clk);
 	struct clockdomain *clkdm = NULL;
 	struct clk_hw_omap *hwclk;
 
-	hwclk = to_clk_hw_omap(__clk_get_hw(clk));
+	hwclk = to_clk_hw_omap(hw);
+	if (!omap2_clk_is_hw_omap(hw))
+		return NULL;
+
 	if (hwclk && hwclk->clkdm_name)
 		clkdm = clkdm_lookup(hwclk->clkdm_name);
 
-- 
2.24.1
