From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2.6.37-rc1] OMAP1: camera.h: readd missing include
Date: Tue, 2 Nov 2010 15:04:01 +0100
Message-ID: <201011021504.03168.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:36540 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab0KBOFX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Nov 2010 10:05:23 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

#include <media/omap1_camera.h> directive, required for successfull 
compilation of dependant boards (board-ams-delta for now), has been lost 
somehow from arch/arm/mach-omap1/include/mach/camera.h on creation. Readd it.

Created and tested against linux-2.6.37-rc1.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 arch/arm/mach-omap1/include/mach/camera.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.37-rc1/arch/arm/mach-omap1/include/mach/camera.h.orig	2010-11-01 22:41:04.000000000 +0100
+++ linux-2.6.37-rc1/arch/arm/mach-omap1/include/mach/camera.h	2010-11-01 23:18:44.000000000 +0100
@@ -1,6 +1,8 @@
 #ifndef __ASM_ARCH_CAMERA_H_
 #define __ASM_ARCH_CAMERA_H_
 
+#include <media/omap1_camera.h>
+
 void omap1_camera_init(void *);
 
 static inline void omap1_set_camera_info(struct omap1_cam_platform_data *info)
