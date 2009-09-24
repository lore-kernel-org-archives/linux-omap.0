From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 19/19] MAINTAINERS: Add OMAP2/3 DSS and OMAPFB maintainer
Date: Thu, 24 Sep 2009 14:56:24 +0300
Message-ID: <1253793384-31158-20-git-send-email-tomi.valkeinen@nokia.com>
References: <1253793384-31158-1-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-2-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-3-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-4-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-5-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-6-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-7-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-8-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-9-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-10-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-11-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-12-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-13-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-14-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-15-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-16-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-17-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-18-git-send-email-tomi.valkeinen@nokia.com>
 <1253793384-31158-19-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17816 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZIXL4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 07:56:53 -0400
In-Reply-To: <1253793384-31158-19-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 MAINTAINERS |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1c0b0..7245dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3778,6 +3778,23 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/video/omap/
 
+OMAP DISPLAY SUBSYSTEM SUPPORT (DSS2)
+M:	Tomi Valkeinen <tomi.valkeinen@nokia.com>
+L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/video/omap2/dss/
+F:	drivers/video/omap2/vrfb.c
+F:	drivers/video/omap2/vram.c
+F:	Documentation/arm/OMAP/DSS
+
+OMAP FRAMEBUFFER SUPPORT (FOR DSS2)
+M:	Tomi Valkeinen <tomi.valkeinen@nokia.com>
+L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/video/omap2/omapfb/
+
 OMAP MMC SUPPORT
 M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
 L:	linux-omap@vger.kernel.org
-- 
1.6.4

