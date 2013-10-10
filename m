From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] ARM: OMAP2+: Use pdata quirks for wl12xx for omap3 evm
 and zoom3
Date: Thu, 10 Oct 2013 15:20:42 -0700
Message-ID: <20131010222042.9063.79025.stgit@localhost>
References: <20131010221833.9063.49904.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48042 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab3JJWUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 18:20:44 -0400
In-Reply-To: <20131010221833.9063.49904.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

As the wl12xx bindings are still pending, this way we can
get things working for omap3 evm and zoom platforms.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 18afbde..10c7145 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -82,6 +82,16 @@ static void __init omap3_igep0020_legacy_init(void)
 {
 	omap3_igep2_display_init_of();
 }
+
+static void __init omap3_evm_legacy_init(void)
+{
+	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 149);
+}
+
+static void __init omap3_zoom_legacy_init(void)
+{
+	legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -132,6 +142,8 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
 	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
+	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
+	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
 #endif
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },

