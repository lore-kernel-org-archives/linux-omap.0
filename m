From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [Resend][PATCH] Maintainers update for hsmmc driver
Date: Fri, 7 Aug 2009 20:51:44 +0530 (IST)
Message-ID: <50872.192.168.10.88.1249658504.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58439 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZHGPVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 11:21:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com, felipe.balbi@nokia.com

Hi,

Resending the patch after changing omap_hs* to omap_hsmmc.c.

Regards,
Madhu



Update maintainers entry for TI OMAP HS MMC support.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 MAINTAINERS |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/MAINTAINERS
===================================================================
--- linux-omap-2.6.orig/MAINTAINERS
+++ linux-omap-2.6/MAINTAINERS
@@ -3698,7 +3698,13 @@ OMAP MMC SUPPORT
 M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-F:	drivers/mmc/host/*omap*
+F:	drivers/mmc/host/omap.c
+
+OMAP HS MMC SUPPORT
+M:	Madhusudhan Chikkature <madhu.cr@ti.com>
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/omap_hsmmc.c

 OMAP RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>


