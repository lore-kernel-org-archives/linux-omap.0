From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Wed, 7 Jan 2009 13:16:15 +0200
Message-ID: <20090107111615.GG27566@atomide.com>
References: <20090107111415.GF27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49940 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZAGLQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 06:16:16 -0500
Content-Disposition: inline
In-Reply-To: <20090107111415.GF27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Include irqs.h or cpu.h directly as needed to fix
omap builds.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 7de7c69..2fcdad1 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/mux.h>
 #include <mach/cpu.h>
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index cae3ebe..6549656 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/mux.h>
 #include <mach/cpu.h>
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 89a6ab0..467531e 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <mach/irqs.h>
 #include <mach/mux.h>
 
 #define OMAP_I2C_SIZE		0x3f
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index b59c385..18179ac 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -38,6 +38,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 
+#include <mach/cpu.h>
 
 /*
  * The TWL4030 "Triton 2" is one of a family of a multi-function "Power
