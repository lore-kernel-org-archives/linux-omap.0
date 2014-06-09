From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: Change hardreset soc_ops for AM43XX
Date: Mon, 9 Jun 2014 15:59:13 -0500
Message-ID: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35321 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbaFIU7w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jun 2014 16:59:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>

am43xx reset register layout is more similar to am33xx than omap4 so
use the am33xx functions for hwmod hardreset soc_ops rather than the
currently used omap4 functions. Without this, assert_hardreset and
deassert_hardreset will not work on am43xx.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 66c60fe..1c0885b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4251,9 +4251,9 @@ void __init omap_hwmod_init(void)
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-		soc_ops.assert_hardreset = _omap4_assert_hardreset;
-		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
+		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
+		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else if (soc_is_am33xx()) {
 		soc_ops.enable_module = _am33xx_enable_module;
-- 
1.9.0

