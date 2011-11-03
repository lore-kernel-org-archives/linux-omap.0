From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
Date: Thu, 03 Nov 2011 15:00:38 +0800
Message-ID: <1320303638.17983.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55755 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1KCHAp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 03:00:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Include linux/export.h to fix below build warning:

  CC      arch/arm/plat-omap/omap_device.o
arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This resend also CC linux-omap@vger.kernel.org and linux-arm-kernel@lists.infradead.org.
This patch is against linux-next 20111103.

 arch/arm/plat-omap/omap_device.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index cd90bed..f839f94 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -78,6 +78,7 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-- 
1.7.5.4



