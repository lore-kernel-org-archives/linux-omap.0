From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: fix dependency on indirect header inclusion
Date: Thu, 11 Jul 2013 16:09:05 +0300
Message-ID: <1373548145-3833-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932260Ab3GKNJ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 09:09:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, a-bindra@ti.com, Tony Lindgren <tony@atomide.com>, ezequiel.garcia@free-electrons.com, nm@ti.com, Felipe Balbi <balbi@ti.com>

omap_hsmmc.c depends on <linux/sizes.h> being
included indirectly by another header. Once we
enable COMPILE_TEST for this driver, we might
compile under architectures which won't include
<linux/sizes.h> for us. In fact, one such case
is x86.

In order to prevent compile breakages, let's
explicitly include <linux/sizes.h>

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

This should be applied before http://marc.info/?l=linux-omap&m=137347241524118&w=2
in order to maintain bisectability.

cheers

 drivers/mmc/host/omap_hsmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1865321..c937ffc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -21,6 +21,7 @@
 #include <linux/debugfs.h>
 #include <linux/dmaengine.h>
 #include <linux/seq_file.h>
+#include <linux/sizes.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-- 
1.8.2.1

