From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/7] arm: mach-omap1: board-innovator: make innovator_mmc_init() static
Date: Tue, 18 Jan 2011 09:52:41 +0200
Message-ID: <1295337165-22934-4-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:44484 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab1ARHwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 02:52:37 -0500
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Eliminates the following sparse warning:

	arch/arm/mach-omap1/board-innovator.c:368:13: warning: symbol 'innovator_mmc_init' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-innovator.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index a36e674..2d9b8cb 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -365,7 +365,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 
 static struct omap_mmc_platform_data *mmc_data[OMAP16XX_NR_MMC];
 
-void __init innovator_mmc_init(void)
+static void __init innovator_mmc_init(void)
 {
 	mmc_data[0] = &mmc1_data;
 	omap1_init_mmc(mmc_data, OMAP15XX_NR_MMC);
-- 
1.5.6.5

