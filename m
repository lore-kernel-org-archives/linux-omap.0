From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 09/26] ARM: OMAP2+: hwmod: Invoke init_clkdm before other init functions
Date: Wed, 7 Nov 2012 17:12:44 -0800
Message-ID: <1352337181-29427-10-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52114 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab2KHBNe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:34 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Vaibhav Hiremath <hvaibhav@ti.com>, Mike Turquette <mturquette@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Without this kernel would crash, since clkdm inside omap_hwmod
is accessed in some of the init funtion like, _init_main_clk.

So call init_clkdm before _init_main_clk().

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ce93ec0..22a41f6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1522,11 +1522,12 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 
 	pr_debug("omap_hwmod: %s: looking up clocks\n", oh->name);
 
+	if (soc_ops.init_clkdm)
+		ret |= soc_ops.init_clkdm(oh);
+
 	ret |= _init_main_clk(oh);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
-	if (soc_ops.init_clkdm)
-		ret |= soc_ops.init_clkdm(oh);
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
-- 
1.7.9.5

