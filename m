From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 28/35] ARM: OMAP2+: board-generic: add support for generic hwmod modular init
Date: Wed, 15 Apr 2015 15:53:15 +0300
Message-ID: <1429102402-5276-29-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35770 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbbDOMxS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:18 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

When hwmod data is built into modules, a slightly different init is
required at the board level. Add this new init support function, and
change the boards that support hwmod data module in subsequent patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 34ff14b..c58cf5a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -42,6 +42,11 @@ static void __init omap_generic_init(void)
 	omapdss_init_of();
 }
 
+static void __init __maybe_unused omap_generic_modular_init(void)
+{
+	omap_pdata_quirks_early_init(omap_dt_match_table);
+}
+
 #ifdef CONFIG_SOC_OMAP2420
 static const char *const omap242x_boards_compat[] __initconst = {
 	"ti,omap2420",
-- 
1.7.9.5

