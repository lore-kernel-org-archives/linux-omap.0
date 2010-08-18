From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: usb: fix build warning
Date: Wed, 18 Aug 2010 14:55:27 +0530
Message-ID: <1282123527-7205-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47677 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175Ab0HRJZd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 05:25:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7I9PU8w007501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 Aug 2010 04:25:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

Fix this and similar build warnings when building with
omap_4430sdp_defconfig.

 CC      arch/arm/mach-omap2/board-4430sdp.o
In file included from arch/arm/mach-omap2/board-4430sdp.c:36:
arch/arm/plat-omap/include/plat/usb.h:109: warning: return type defaults to 'int'

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h	2010-08-18 14:52:01.076453606 +0530
+++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h	2010-08-18 14:52:09.652178332 +0530
@@ -105,7 +105,7 @@
 #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP_OTG_MODULE)
 void omap2_usbfs_init(struct omap_usb_config *pdata);
 #else
-static inline omap2_usbfs_init(struct omap_usb_config *pdata)
+static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
 {
 }
 #endif
