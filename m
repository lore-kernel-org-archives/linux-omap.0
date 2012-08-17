From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 10/10] mmc: omap_hsmmc: Move to Maintained state in MAINTAINERS
Date: Sat, 18 Aug 2012 00:22:30 +0530
Message-ID: <1345229550-8672-11-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50411 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517Ab2HQSyO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 14:54:14 -0400
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>

I can continue to look after this driver.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72c2681..75e3c3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4933,8 +4933,10 @@ S:	Maintained
 F:	drivers/mmc/host/omap.c
 
 OMAP HS MMC SUPPORT
+M:	Venkatraman S <svenkatr@ti.com>
+L:	linux-mmc@vger.kernel.org
 L:	linux-omap@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	drivers/mmc/host/omap_hsmmc.c
 
 OMAP RANDOM NUMBER GENERATOR SUPPORT
-- 
1.7.11.1.25.g0e18bef

