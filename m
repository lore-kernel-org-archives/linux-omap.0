From: Kalle Valo <kalle.valo@nokia.com>
Subject: [PATCH 2/3] tsub6010: fix omap compile
Date: Thu, 22 Jan 2009 15:19:13 +0200
Message-ID: <20090122131913.18315.73478.stgit@tikku>
References: <20090122131602.18315.84862.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28523 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbZAVNU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 08:20:57 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0MDKoR6001674
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 15:20:54 +0200
Received: from [127.0.1.1] (essapo-nirac252253.europe.nokia.com [10.162.252.253])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0MDJEhx008239
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 15:19:14 +0200
In-Reply-To: <20090122131602.18315.84862.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

drivers/usb/musb/tusb6010_omap.c:18:26: error: asm/arch/dma.h: No such file or directory
drivers/usb/musb/tusb6010_omap.c:19:26: error: asm/arch/mux.h: No such file or directory

Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
---

 drivers/usb/musb/tusb6010_omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 52f7f29..7e073a0 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -15,8 +15,8 @@
 #include <linux/usb.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <asm/arch/dma.h>
-#include <asm/arch/mux.h>
+#include <mach/dma.h>
+#include <mach/mux.h>
 
 #include "musb_core.h"
 

