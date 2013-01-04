From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all revisions
Date: Fri, 4 Jan 2013 11:09:22 +0100
Message-ID: <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47609 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3ADKJa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 05:09:30 -0500
In-Reply-To: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>

To avoid issues with audio caused by non locked ABE DPLL we should
make sure it is locked in all OMAP4 revisions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

asda d
---
 arch/arm/mach-omap2/cclock44xx_data.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 5789a5e..a2cc046 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -2026,14 +2026,13 @@ int __init omap4xxx_clk_init(void)
 	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
 	 * state when turning the ABE clock domain. Workaround this by
 	 * locking the ABE DPLL on boot.
+	 * Lock the ABE DPLL in any case to avoid issues with audio.
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

