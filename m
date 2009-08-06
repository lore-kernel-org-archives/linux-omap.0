From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [Resend][PATCH] Maintainers update for hsmmc driver
Date: Thu, 6 Aug 2009 21:58:51 +0530 (IST)
Message-ID: <44306.192.168.10.88.1249576131.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41551 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922AbZHFQ3A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 12:29:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com

Hi,

Resending the patch after fixing the conflict pointed out by Nishant.

Regards,
Madhu
-----------------------------------------------

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
+F:	drivers/mmc/host/omap_hs*

 OMAP RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>


