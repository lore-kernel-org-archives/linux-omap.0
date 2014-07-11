From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 10/10] ARM: AM33xx: hwmod_data: Remove legacy mailbox addrs
Date: Fri, 11 Jul 2014 16:44:43 -0500
Message-ID: <1405115083-52977-11-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52577 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbaGKVqC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jul 2014 17:46:02 -0400
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

The legacy-style definition of the hwmod addr space is no longer
required as AM33xx/AM43xx are DT-boot only, and the minimal mailbox
DT nodes have been added, so clean up this data.

Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
index e2db378..8f5989d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -317,21 +317,11 @@ struct omap_hwmod_ocp_if am33xx_l4_per__i2c3 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am33xx_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x480C8000,
-		.pa_end		= 0x480C8000 + (SZ_4K - 1),
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4 ls -> mailbox */
 struct omap_hwmod_ocp_if am33xx_l4_per__mailbox = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_mailbox_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mailbox_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-- 
2.0.0

