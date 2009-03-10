From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/6] OMAP: mmc-twl4030 fix name buffer length
Date: Tue, 10 Mar 2009 11:33:02 +0200
Message-ID: <20090310093302.16889.4535.sendpatchset@ahunter-laptop>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51111 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbZCJJeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 05:34:25 -0400
In-Reply-To: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, David Brownell <david-b@pacbell.net>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 60238a3a80b5be3e1843a049b39eabf729c315aa Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 22 Jan 2009 17:58:04 +0200
Subject: [PATCH] OMAP: mmc-twl4030 fix name buffer length

Add 1 to buffer length for null terminator.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 33e5b9b..aeaab5a 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -61,7 +61,7 @@ static struct twl_mmc_controller {
 	struct omap_mmc_platform_data	*mmc;
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
-	char		name[HSMMC_NAME_LEN];
+	char		name[HSMMC_NAME_LEN + 1];
 } hsmmc[OMAP34XX_NR_MMC] = {
 	{
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
-- 
1.5.6.3

