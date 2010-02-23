From: hvaibhav@ti.com
Subject: [PATCH-V1 01/10] Makfile:Removed duplicate entry of davinci
Date: Tue, 23 Feb 2010 14:04:24 +0530
Message-ID: <1266914073-30135-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37791 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab0BWIej (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 03:34:39 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, hverkuil@xs4all.nl, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/media/video/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index b88b617..c51c386 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -160,8 +160,6 @@ obj-$(CONFIG_VIDEO_MX3)			+= mx3_camera.o
 obj-$(CONFIG_VIDEO_PXA27x)		+= pxa_camera.o
 obj-$(CONFIG_VIDEO_SH_MOBILE_CEU)	+= sh_mobile_ceu_camera.o
 
-obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
-
 obj-$(CONFIG_VIDEO_AU0828) += au0828/
 
 obj-$(CONFIG_USB_VIDEO_CLASS)	+= uvc/
-- 
1.6.2.4

