From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: fix compile break
Date: Sat, 29 Oct 2011 16:44:07 -0700
Message-ID: <1319931847-5140-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46872 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384Ab1J2XoM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Oct 2011 19:44:12 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p9TNiBEt030400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 29 Oct 2011 18:44:11 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p9TNiBu1025275
	for <linux-omap@vger.kernel.org>; Sat, 29 Oct 2011 18:44:11 -0500 (CDT)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p9TNiBru018127
	for <linux-omap@vger.kernel.org>; Sat, 29 Oct 2011 18:44:11 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

omap_hsmmc.c: In function 'omap_hsmmc_protect_card':
omap_hsmmc.c:1273: error: 'pr_info' undeclared (first use in this function)
omap_hsmmc.c:1273: error: (Each undeclared identifier is reported only once
omap_hsmmc.c:1273: error: for each function it appears in.)
omap_hsmmc.c:1273: error: expected ';' before string constant
omap_hsmmc.c:1275: error: expected statement before ')' token

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e8ff123..101cd31 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 		}
 	} else {
 		if (!host->protect_card) {
-			pr_info"%s: cover is open, "
+			pr_info("%s: cover is open, "
 					 "card is now inaccessible\n",
 					 mmc_hostname(host->mmc));
 			host->protect_card = 1;
-- 
1.7.5.4

