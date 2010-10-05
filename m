From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3] OMAP2: onenand: Fix static function warnings
Date: Wed,  6 Oct 2010 03:26:57 +0530
Message-ID: <1286315819-5906-2-git-send-email-manjugk@ti.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54670 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab0JEV43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 17:56:29 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o95LuTEZ010699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Oct 2010 16:56:29 -0500
Received: from legion.dal.design.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o95LuS31019341
	for <linux-omap@vger.kernel.org>; Tue, 5 Oct 2010 16:56:28 -0500 (CDT)
Received: from localhost (dfl-61.apr.dhcp.ti.com [172.24.137.86])
	by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id o95LuRf03423
	for <linux-omap@vger.kernel.org>; Tue, 5 Oct 2010 16:56:27 -0500 (CDT)
In-Reply-To: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fixes below sparse warning.

drivers/mtd/onenand/omap2.c:577:5: warning: symbol 'omap2_onenand_rephase' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
Changes since v1 and v2:
 - no logical changes, patch seperated from series based on Tony's suggestion.

 drivers/mtd/onenand/omap2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 9f322f1..608cc8d 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -574,7 +574,7 @@ static int __adjust_timing(struct device *dev, void *data)
 	return ret;
 }
 
-int omap2_onenand_rephase(void)
+static int omap2_onenand_rephase(void)
 {
 	return driver_for_each_device(&omap2_onenand_driver.driver, NULL,
 				      NULL, __adjust_timing);
-- 
1.7.0.4

