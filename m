From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] OMAP2: avoid descending into disabled framebuffer dirs
Date: Mon,  9 May 2011 10:40:24 -0400
Message-ID: <1304952024-28296-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:51441 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab1EIOgf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 May 2011 10:36:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Rather than always add the omap2 dirs to the build list (and thus
force everyone to generate a useless built-in.o), bind the dirs to
their relevant kconfig symbol.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/omap2/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
index d853d05..5ddef12 100644
--- a/drivers/video/omap2/Makefile
+++ b/drivers/video/omap2/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_OMAP2_VRAM) += vram.o
 obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
 
-obj-y += dss/
-obj-y += omapfb/
+obj-$(CONFIG_OMAP2_DSS) += dss/
+obj-$(CONFIG_FB_OMAP2) += omapfb/
 obj-y += displays/
-- 
1.7.5.rc3

