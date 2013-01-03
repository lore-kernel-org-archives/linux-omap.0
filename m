From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: OMAP4: clock data: ABE DPLL need to be locked on all revisions
Date: Thu, 3 Jan 2013 14:46:50 +0100
Message-ID: <1357220811-29904-2-git-send-email-peter.ujfalusi@ti.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39587 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab3ACNq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 08:46:58 -0500
In-Reply-To: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>

We need to lock ABE DPPL on al OMAP4 revisions, not only for OMAP446x

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 5789a5e..79c32ce 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -2023,17 +2023,15 @@ int __init omap4xxx_clk_init(void)
 				     ARRAY_SIZE(enable_init_clks));
 
 	/*
-	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
+	 * On OMAP4 the ABE DPLL fails to turn on if in idle low-power
 	 * state when turning the ABE clock domain. Workaround this by
 	 * locking the ABE DPLL on boot.
 	 */
-	if (cpu_is_omap446x()) {
-		rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
-		if (!rc)
-			rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
-		if (rc)
-			pr_err("%s: failed to configure ABE DPLL!\n", __func__);
-	}
+	rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
+	if (!rc)
+		rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
 	return 0;
 }
-- 
1.8.0.2

