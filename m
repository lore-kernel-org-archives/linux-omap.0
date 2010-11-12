From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] OMAP1: camera.h: add missing include
Date: Thu, 11 Nov 2010 17:03:30 -0800
Message-ID: <20101112010330.3827.16286.stgit@baageli.muru.com>
References: <20101112010245.3827.75329.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50371 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab0KLBDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 20:03:37 -0500
In-Reply-To: <20101112010245.3827.75329.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

#include <media/omap1_camera.h> directive is required to
compile the dependant boards (board-ams-delta for now).

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
[tony@atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/camera.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/camera.h b/arch/arm/mach-omap1/include/mach/camera.h
index fd54b45..847d00f 100644
--- a/arch/arm/mach-omap1/include/mach/camera.h
+++ b/arch/arm/mach-omap1/include/mach/camera.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ARCH_CAMERA_H_
 #define __ASM_ARCH_CAMERA_H_
 
+#include <media/omap1_camera.h>
+
 void omap1_camera_init(void *);
 
 static inline void omap1_set_camera_info(struct omap1_cam_platform_data *info)

