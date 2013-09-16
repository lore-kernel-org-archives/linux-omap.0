From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC v3 10/12] ARM: OMAP2+: hwmod: AM43x operations
Date: Mon, 16 Sep 2013 19:18:46 +0530
Message-ID: <b74dff047fe6a90a474954ad7445f4540eb08beb.1379337301.git.afzal@ti.com>
References: <cover.1379337301.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51764 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745Ab3IPNt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 09:49:28 -0400
In-Reply-To: <cover.1379337301.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ambresh K <ambresh@ti.com>

Reuse OMAP4 operations on AM43x.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d9ee0ff..aa593da 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4125,6 +4125,14 @@ void __init omap_hwmod_init(void)
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

