From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] am35xx: musb: add missing linux/module.h header
Date: Tue,  8 Nov 2011 22:59:40 +0100
Message-ID: <1320789580-23224-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50086 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab1KHV7x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 16:59:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com
Cc: Ilya Yanok <yanok@emcraft.com>

Fix compilation errors by including linux/module.h header.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 drivers/usb/musb/am35x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 08f1d0b6..ea2a258 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/module.h>
 
 #include <plat/usb.h>
 
-- 
1.7.6.4

