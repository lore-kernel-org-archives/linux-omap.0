From: Kalle Valo <kalle.valo@nokia.com>
Subject: [PATCH] musb: fix tusb6010_omap compilation errors
Date: Fri, 23 Jan 2009 18:00:37 +0200
Message-ID: <20090123160037.7547.71504.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49893 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbZAWQF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 11:05:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

drivers/usb/musb/tusb6010_omap.c:18:26: error: asm/arch/dma.h:
  No such file or directory
drivers/usb/musb/tusb6010_omap.c:19:26: error: asm/arch/mux.h:
  No such file or directory

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
 

