From: Balaji T K <balajitk2@gmail.com>
Subject: [PATCH] MAINTAINERS: omap_hsmmc: remove myself from MAINTAINERS
Date: Wed, 17 Sep 2014 22:50:11 +0530
Message-ID: <1410974411-2938-1-git-send-email-balajitk2@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:50164 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbaIQRUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 13:20:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk2@gmail.com>

As I won't be able to maintain omap_hsmmc driver

Signed-off-by: Balaji T K <balajitk2@gmail.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e7866a..b296e43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6540,10 +6540,9 @@ S:	Maintained
 F:	drivers/mmc/host/omap.c
 
 OMAP HS MMC SUPPORT
-M:	Balaji T K <balajitk@ti.com>
 L:	linux-mmc@vger.kernel.org
 L:	linux-omap@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/mmc/host/omap_hsmmc.c
 
 OMAP RANDOM NUMBER GENERATOR SUPPORT
-- 
1.9.1

