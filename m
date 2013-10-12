From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 09/11] ARM: OMAP2+: hwmod: AM43x operations
Date: Sat, 12 Oct 2013 15:46:20 +0530
Message-ID: <cb2cde2cbeb73370b036add3babbbd63aaebd353.1381569236.git.afzal@ti.com>
References: <cover.1381569236.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51196 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717Ab3JLKQr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Oct 2013 06:16:47 -0400
In-Reply-To: <cover.1381569236.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Ambresh K <ambresh@ti.com>

Reuse OMAP4 operations on AM43x.

Context related ops are not used on AM43x, as this would not add value
when using DT and AM43x is DT only boot. This additionally helps not to
add context register offset for each hwmod.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1c217e8..e3f0eca 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4144,6 +4144,14 @@ void __init omap_hwmod_init(void)
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
+	} else if (soc_is_am43xx()) {
+		soc_ops.enable_module = _omap4_enable_module;
+		soc_ops.disable_module = _omap4_disable_module;
+		soc_ops.wait_target_ready = _omap4_wait_target_ready;
+		soc_ops.assert_hardreset = _omap4_assert_hardreset;
+		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
+		soc_ops.init_clkdm = _init_clkdm;
 	} else if (soc_is_am33xx()) {
 		soc_ops.enable_module = _am33xx_enable_module;
 		soc_ops.disable_module = _am33xx_disable_module;
-- 
1.8.3.4

