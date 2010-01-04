From: hvaibhav@ti.com
Subject: [PATCH 1/9] Makfile:Removed duplicate entry of davinci
Date: Mon,  4 Jan 2010 19:32:54 +0530
Message-ID: <1262613782-20463-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45603 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab0ADODM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:03:12 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, hverkuil@xs4all.nl, davinci-linux-open-source@linux.davincidsp.com, m-karicheri2@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/media/video/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index 2af68ee..bebbee6 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -158,8 +158,6 @@ obj-$(CONFIG_VIDEO_MX3)			+= mx3_camera.o
 obj-$(CONFIG_VIDEO_PXA27x)		+= pxa_camera.o
 obj-$(CONFIG_VIDEO_SH_MOBILE_CEU)	+= sh_mobile_ceu_camera.o
 
-obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
-
 obj-$(CONFIG_VIDEO_AU0828) += au0828/
 
 obj-$(CONFIG_USB_VIDEO_CLASS)	+= uvc/
-- 
1.6.2.4

