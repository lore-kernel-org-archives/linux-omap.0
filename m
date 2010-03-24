From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 1/9] OMAP: Devkit8000: Fix typo in supplies
Date: Wed, 24 Mar 2010 13:52:10 +0100
Message-ID: <1269435138-27192-2-git-send-email-weber@corscience.de>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51886 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab0CXMxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:53:01 -0400
In-Reply-To: <1269435138-27192-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Replace wrong vdss_dsi with vdds_dsi.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..fb0f2f8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -303,7 +303,7 @@ static struct regulator_consumer_supply devkit8000_vpll2_supplies[] = {
 	.dev		= &devkit8000_lcd_device.dev,
 	},
 	{
-	.supply		= "vdss_dsi",
+	.supply		= "vdds_dsi",
 	.dev		= &devkit8000_dss_device.dev,
 	}
 };
-- 
1.6.4.4

