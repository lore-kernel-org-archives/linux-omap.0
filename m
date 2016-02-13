From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Sat, 13 Feb 2016 09:25:11 +0200
Message-ID: <56BEDA57.4030300@gmail.com>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011301.27415@pali> <568A5970.2000201@ti.com>
 <568A6DD1.5050700@gmail.com> <5693F5B7.8040608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5693F5B7.8040608@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On 11.01.2016 20:34, Tomi Valkeinen wrote:
>
> So, I'm not very enthusiastic about adding this feature as an omapfb
> specific boot parameter.
>

What about something like (not properly formatted, just want your 
opinion on the idea):

diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
index 1f1ecf8..0d109d8 100644
--- a/arch/arm/mach-omap2/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -28,6 +28,7 @@
  #include <linux/io.h>
  #include <linux/omapfb.h>
  #include <linux/dma-mapping.h>
+#include <linux/of_reserved_mem.h>

  #include <asm/mach/map.h>

@@ -110,6 +111,49 @@ int __init omap_init_fb(void)
  {
         return platform_device_register(&omap_fb_device);
  }
+
+static int rmem_omapfb_device_init(struct reserved_mem *rmem, struct 
device *dev)
+{
+       int dma;
+
+       if (rmem->priv)
+               return 0;
+
+       dma = dma_declare_coherent_memory(&omap_fb_device.dev, rmem->base,
+                                         rmem->base, rmem->size,
+                                         DMA_MEMORY_MAP |
+                                         DMA_MEMORY_EXCLUSIVE);
+
+       if (!(dma & DMA_MEMORY_MAP)) {
+               pr_err("omapfb: dma_declare_coherent_memory failed\n");
+               return -ENOMEM;
+       }
+       else
+               rmem->priv = omap_fb_device.dev.dma_mem;
+
+       return 0;
+}
+
+static void rmem_omapfb_device_release(struct reserved_mem *rmem,
+                                      struct device *dev)
+{
+       dma_release_declared_memory(&omap_fb_device.dev);
+}
+
+static const struct reserved_mem_ops rmem_omapfb_ops = {
+       .device_init    = rmem_omapfb_device_init,
+       .device_release = rmem_omapfb_device_release,
+};
+
+static int __init rmem_omapfb_setup(struct reserved_mem *rmem)
+{
+       rmem->ops = &rmem_omapfb_ops;
+       pr_info("omapfb: reserved %d bytes at %pa\n", rmem->size, 
&rmem->base);
+
+       return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(dss, "ti,omapfb-memsize", rmem_omapfb_setup);
  #else
  int __init omap_init_fb(void) { return 0; }
  #endif

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 6ab13d1..6f0ba03 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -28,6 +28,7 @@
  #include <linux/slab.h>
  #include <linux/mfd/syscon.h>
  #include <linux/regmap.h>
+#include <linux/of_reserved_mem.h>

  #include <video/omapdss.h>
  #include "omap_hwmod.h"
@@ -640,6 +641,7 @@ int __init omapdss_init_of(void)
         omap_display_device.dev.platform_data = &board_data;

         r = platform_device_register(&omap_display_device);
+
         if (r < 0) {
                 pr_err("Unable to register omapdss device\n");
                 return r;
@@ -666,6 +668,9 @@ int __init omapdss_init_of(void)
                 return r;
         }

+       /* Init fb reserved memory, there may be none so ignore the 
result */
+       of_reserved_mem_device_init(&pdev->dev);
+
         /* create V4L2 display device */
         r = omap_init_vout();
         if (r < 0) {


Regards,
Ivo
