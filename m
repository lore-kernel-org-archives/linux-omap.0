From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 1/2] OMAP1: allow reserving memory for camera
Date: Sun, 5 Dec 2010 19:32:32 +0100
Message-ID: <201012051932.34260.jkrzyszt@tis.icnet.pl>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:53701 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715Ab0LESdC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Dec 2010 13:33:02 -0500
In-Reply-To: <201012051929.07220.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

OMAP1 camera driver, when starting up in its videobuf_contig mode, may have 
problems with allocating dma coherent memory after system memory gets 
fragmented if there is no dedicated memory declared as a dma coherent memory 
block associated with the device. To solve this issue, allow for removing a 
block of memory from system memory early on boot, then, if reserved this way, 
declare it as the device dedicated dma coherent memory.

An example use case on Amstrad Delta will be provided with patch 2/2.

Created and tested against linux-2.6.37-rc4.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/devices.c             |   36 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/camera.h |    1
 2 files changed, 37 insertions(+)

--- linux-2.6.37-rc4/arch/arm/mach-omap1/devices.c.orig	2010-12-04 18:00:39.000000000 +0100
+++ linux-2.6.37-rc4/arch/arm/mach-omap1/devices.c	2010-12-04 22:22:13.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
+#include <linux/memblock.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
@@ -222,13 +223,48 @@ static struct platform_device omap1_came
 	.resource	= omap1_camera_resources,
 };
 
+static phys_addr_t omap1_camera_phys_mempool_base;
+static phys_addr_t omap1_camera_phys_mempool_size;
+
+void __init omap1_camera_reserve(phys_addr_t size)
+{
+	phys_addr_t paddr;
+
+	if (!size)
+		return;
+
+	paddr = memblock_alloc(size, SZ_1M);
+
+	if (!paddr) {
+		pr_err("%s: failed to reserve %x bytes\n", __func__, size);
+		return;
+	}
+	memblock_free(paddr, size);
+	memblock_remove(paddr, size);
+
+	omap1_camera_phys_mempool_base = paddr;
+	omap1_camera_phys_mempool_size = size;
+}
+
 void __init omap1_camera_init(void *info)
 {
 	struct platform_device *dev = &omap1_camera_device;
+	dma_addr_t paddr = omap1_camera_phys_mempool_base;
+	dma_addr_t size = omap1_camera_phys_mempool_size;
 	int ret;
 
 	dev->dev.platform_data = info;
 
+	if (paddr) {
+		if (dma_declare_coherent_memory(&dev->dev, paddr, paddr, size,
+				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE))
+			pr_info("%s: reserved %d bytes camera buffer memory\n",
+					__func__, size);
+		else
+			pr_warn("%s: cannot reserve camera buffer memory\n",
+					__func__);
+	}
+
 	ret = platform_device_register(dev);
 	if (ret)
 		dev_err(&dev->dev, "unable to register device: %d\n", ret);
--- linux-2.6.37-rc4/arch/arm/mach-omap1/include/mach/camera.h.orig	2010-12-04 18:00:39.000000000 +0100
+++ linux-2.6.37-rc4/arch/arm/mach-omap1/include/mach/camera.h	2010-12-04 22:26:23.000000000 +0100
@@ -3,6 +3,7 @@
 
 #include <media/omap1_camera.h>
 
+void omap1_camera_reserve(phys_addr_t);
 void omap1_camera_init(void *);
 
 static inline void omap1_set_camera_info(struct omap1_cam_platform_data *info)
