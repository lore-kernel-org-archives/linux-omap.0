From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2+: dpll: am335x - avoid freqsel
Date: Tue, 22 Jan 2013 22:14:17 +0530
Message-ID: <b0be0227b6b07a8c16b13a06fe500694c751827c.1358871018.git.afzal@ti.com>
References: <cover.1358871018.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1358871018.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

am335x does not have freqsel, avoid it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 0a02aab5..3aed4b0 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -500,8 +500,9 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
-		/* No freqsel on OMAP4 and OMAP3630 */
-		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
+		/* No freqsel on AM335x, OMAP4 and OMAP3630 */
+		if (!soc_is_am33xx() && !cpu_is_omap44xx() &&
+		    !cpu_is_omap3630()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			WARN_ON(!freqsel);
-- 
1.7.12
