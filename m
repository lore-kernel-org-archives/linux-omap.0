From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 09/15] MAINTAINERS: Combine DSS2 and OMAPFB2 into one entry
Date: Fri,  8 Jan 2010 15:22:43 +0200
Message-ID: <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57044 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0AHNWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:24 -0500
In-Reply-To: <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

There isn't really any reason to divide those.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 MAINTAINERS |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d2fcee..d370787 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3955,23 +3955,14 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/video/omap/
 
-OMAP DISPLAY SUBSYSTEM SUPPORT (DSS2)
+OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
 M:	Tomi Valkeinen <tomi.valkeinen@nokia.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-fbdev@vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/video/omap2/dss/
-F:	drivers/video/omap2/vrfb.c
-F:	drivers/video/omap2/vram.c
+F:	drivers/video/omap2/
 F:	Documentation/arm/OMAP/DSS
 
-OMAP FRAMEBUFFER SUPPORT (FOR DSS2)
-M:	Tomi Valkeinen <tomi.valkeinen@nokia.com>
-L:	linux-omap@vger.kernel.org
-L:	linux-fbdev@vger.kernel.org (moderated for non-subscribers)
-S:	Maintained
-F:	drivers/video/omap2/omapfb/
-
 OMAP MMC SUPPORT
 M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
 L:	linux-omap@vger.kernel.org
-- 
1.6.5

