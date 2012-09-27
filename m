From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] ARM: OMAP4: hwmod data: Add McASP data port address space
Date: Thu, 27 Sep 2012 11:33:34 -0500
Message-ID: <1348763614-4298-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60952 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab2I0Qfc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 12:35:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

McASP has a configuration port and a data port. This patch adds the address
space entry for the data port as described in the OMAP4 TRM.

Also, add names to the address spaces.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f31f3bc..cb5b463 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4951,10 +4951,16 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp = {
 
 static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] = {
 	{
+		.name		= "cfg",
 		.pa_start	= 0x49028000,
 		.pa_end		= 0x490283ff,
 		.flags		= ADDR_TYPE_RT
 	},
+	{
+		.name		= "dat",
+		.pa_start	= 0x4902A000,
+		.pa_end		= 0x4902Afff,
+	},
 	{ }
 };
 
-- 
1.7.5.4

