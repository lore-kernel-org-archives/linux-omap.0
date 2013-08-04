From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 8/9] ARM: DRA7: hwmod: Reuse the soc_ops used for OMAP4/5
Date: Sun, 4 Aug 2013 21:57:36 +0530
Message-ID: <1375633657-6835-9-git-send-email-rnayak@ti.com>
References: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40796 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753734Ab3HDQ27 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Aug 2013 12:28:59 -0400
In-Reply-To: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, santosh.shilimkar@ti.com, nm@ti.com, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

The soc_ops for dra7xx devices can be completed reused
from the ones used for omap4 and omap5 devices.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7341eff..f6eb29b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4113,7 +4113,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
-	} else if (cpu_is_omap44xx() || soc_is_omap54xx()) {
+	} else if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-- 
1.7.9.5

