From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH] OMAP: Fixing build warning with omap3_defconfig
Date: Tue,  2 Mar 2010 16:26:08 +0530
Message-ID: <1267527368-19690-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59523 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab0CBK4O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Mar 2010 05:56:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Anuj Aggarwal <anuj.aggarwal@ti.com>

Fixes the below build warning when compiled with omap3_defconfig:

  CC      arch/arm/mach-omap2/board-am3517evm.o
  In file included from arch/arm/mach-omap2/board-am3517evm.c:23:
  include/linux/i2c/pca953x.h:14: warning: 'struct i2c_client' declared
  	inside parameter list
  include/linux/i2c/pca953x.h:14: warning: its scope is only this definition
  	or declaration, which is probably not what you want
  include/linux/i2c/pca953x.h:17: warning: 'struct i2c_client' declared inside
  	parameter list
  CC      arch/arm/mach-omap2/usb-musb.o

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 include/linux/i2c/pca953x.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
index 81736d6..6c8f853 100644
--- a/include/linux/i2c/pca953x.h
+++ b/include/linux/i2c/pca953x.h
@@ -1,4 +1,5 @@
 /* platform data for the PCA9539 16-bit I/O expander driver */
+#include <linux/i2c.h>
 
 struct pca953x_platform_data {
 	/* number of the first GPIO */
-- 
1.6.2.4

