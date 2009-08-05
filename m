From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [RFC][PATCH] Maintainers update for hsmmc driver
Date: Thu, 6 Aug 2009 05:12:21 +0530 (IST)
Message-ID: <39332.192.168.10.88.1249515741.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36555 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbZHEXm2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Aug 2009 19:42:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com

Hi,

I intend to post this patch upstream for TI OMAP 2430/3430 HSMMC controller
driver maintainance. Any thoughts or comments welcome.

Regards,
Madhu

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-omap-2.6/MAINTAINERS
===================================================================
--- linux-omap-2.6.orig/MAINTAINERS
+++ linux-omap-2.6/MAINTAINERS
@@ -3700,6 +3700,12 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/*omap*

+OMAP HS MMC SUPPORT
+M:	Madhusudhan Chikkature <madhu.cr@ti.com>
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/*omap_hsmmc*
+
 OMAP RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained



