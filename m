From: Tero Kristo <t-kristo@ti.com>
Subject: [RESEND PATCHv2 09/28] ARM: AM33xx: fix module_wait_ready without clkctrl register
Date: Mon, 13 Jun 2016 22:04:43 +0300
Message-ID: <1465844702-12200-10-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the module has no clkctrl register defined, module_wait_ready should
not try to access this. This can potentially cause an illegal register
access, and result in bad idle reporting also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 7b181f9..c073fb5 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -220,6 +220,9 @@ static int am33xx_cm_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
+	if (!clkctrl_offs)
+		return 0;
+
 	omap_test_timeout(_is_module_ready(inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
1.9.1

