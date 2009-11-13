From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/14] omap3630: Add HSMMC related checks
Date: Thu, 12 Nov 2009 16:08:35 -0800
Message-ID: <20091113000835.9034.22039.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57687 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbZKMAIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:08:31 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

From: Madhu <madhu.cr@ti.com>

Change the cpu_is_omap3430() check to cpu_is_omap34xx() to allow HSMMC1/2
mux configuration for omap3630.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7d4513b..8d23e1f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -575,7 +575,7 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 		}
 	}
 
-	if (cpu_is_omap3430()) {
+	if (cpu_is_omap34xx()) {
 		if (controller_nr == 0) {
 			omap_cfg_reg(N28_3430_MMC1_CLK);
 			omap_cfg_reg(M27_3430_MMC1_CMD);

