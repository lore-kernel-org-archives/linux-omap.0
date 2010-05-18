From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 11/14] OMAP2: Devkit8000: Fix comment
Date: Tue, 18 May 2010 14:05:32 +0200
Message-ID: <1274184335-29322-12-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60380 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313Ab0ERMGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:04 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

The comment says VAUX4 which is not used for ads7846.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 637a2c3..bb3f3f5 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -334,7 +334,7 @@ static struct regulator_init_data devkit8000_vpll1 = {
 	.consumer_supplies	= &devkit8000_vpll1_supply,
 };
 
-/* VAUX4 for ads7846 and nubs */
+/* VIO for ads7846 */
 static struct regulator_init_data devkit8000_vio = {
 	.constraints = {
 		.min_uV                 = 1800000,
-- 
1.6.4.4

