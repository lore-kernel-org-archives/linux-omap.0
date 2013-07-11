From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 09/13] ARM: OMAP2+: hwmod: AM43x operations
Date: Thu, 11 Jul 2013 12:06:28 +0530
Message-ID: <98d7f535693c2bdcb576f27cb75dee9743e230f7.1373519192.git.afzal@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54676 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab3GKGgv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 02:36:51 -0400
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, Ambresh K <ambresh@ti.com>

From: Ambresh K <ambresh@ti.com>

Reuse OMAP4 operations on AM43x.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

Note: This may have to modified as mentioned in the cover letter.

 arch/arm/mach-omap2/omap_hwmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7f4db12..0df6353 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4113,7 +4113,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
-	} else if (cpu_is_omap44xx() || soc_is_omap54xx()) {
+	} else if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_am43xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-- 
1.8.3.1

