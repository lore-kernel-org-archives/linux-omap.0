From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] OMAP1: Add support for SoC camera interface
Date: Thu, 30 Sep 2010 11:46:20 -0700
Message-ID: <20100930184620.12052.14564.stgit@baageli.muru.com>
References: <20100930184459.12052.14542.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55136 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0I3SqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:46:25 -0400
In-Reply-To: <20100930184459.12052.14542.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

This patch adds a definition of the OMAP1 camera interface platform device,
and a function that allows for providing a board specific platform data.
The device will be used with the upcoming OMAP1 SoC camera interface driver.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c             |   43 +++++++++++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/camera.h |   11 +++++++
 2 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/camera.h

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index aa07256..2c9a030 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -9,6 +9,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -191,6 +192,48 @@ static inline void omap_init_spi100k(void)
 }
 #endif
 
+
+#define OMAP1_CAMERA_BASE	0xfffb6800
+#define OMAP1_CAMERA_IOSIZE	0x1c
+
+static struct resource omap1_camera_resources[] = {
+	[0] = {
+		.start	= OMAP1_CAMERA_BASE,
+		.end	= OMAP1_CAMERA_BASE + OMAP1_CAMERA_IOSIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= INT_CAMERA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 omap1_camera_dma_mask = DMA_BIT_MASK(32);
+
+static struct platform_device omap1_camera_device = {
+	.name		= "omap1-camera",
+	.id		= 0, /* This is used to put cameras on this interface */
+	.dev		= {
+		.dma_mask		= &omap1_camera_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(omap1_camera_resources),
+	.resource	= omap1_camera_resources,
+};
+
+void __init omap1_camera_init(void *info)
+{
+	struct platform_device *dev = &omap1_camera_device;
+	int ret;
+
+	dev->dev.platform_data = info;
+
+	ret = platform_device_register(dev);
+	if (ret)
+		dev_err(&dev->dev, "unable to register device: %d\n", ret);
+}
+
+
 /*-------------------------------------------------------------------------*/
 
 static inline void omap_init_sti(void) {}
diff --git a/arch/arm/mach-omap1/include/mach/camera.h b/arch/arm/mach-omap1/include/mach/camera.h
new file mode 100644
index 0000000..fd54b45
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/camera.h
@@ -0,0 +1,11 @@
+#ifndef __ASM_ARCH_CAMERA_H_
+#define __ASM_ARCH_CAMERA_H_
+
+void omap1_camera_init(void *);
+
+static inline void omap1_set_camera_info(struct omap1_cam_platform_data *info)
+{
+	omap1_camera_init(info);
+}
+
+#endif /* __ASM_ARCH_CAMERA_H_ */

