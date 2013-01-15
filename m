From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 04/12] video: da8xx-fb: use devres
Date: Tue, 15 Jan 2013 19:12:22 +0530
Message-ID: <527f3adc41ba0090dd1362adde550eb0e7595e28.1358251447.git.afzal@ti.com>
References: <cover.1358251447.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1358251447.git.afzal-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Replace existing resource handling in the driver with managed device
resource.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |   35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index ca69e01..7a32e83 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1036,12 +1036,9 @@ static int fb_remove(struct platform_device *dev)
 				  par->p_palette_base);
 		dma_free_coherent(NULL, par->vram_size, par->vram_virt,
 				  par->vram_phys);
-		free_irq(par->irq, par);
 		pm_runtime_put_sync(&dev->dev);
 		pm_runtime_disable(&dev->dev);
 		framebuffer_release(info);
-		iounmap(da8xx_fb_reg_base);
-		release_mem_region(lcdc_regs->start, resource_size(lcdc_regs));
 
 	}
 	return 0;
@@ -1265,7 +1262,6 @@ static int fb_probe(struct platform_device *device)
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
-	resource_size_t len;
 	int ret, i;
 	unsigned long ulcm;
 
@@ -1275,29 +1271,16 @@ static int fb_probe(struct platform_device *device)
 	}
 
 	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
-	if (!lcdc_regs) {
-		dev_err(&device->dev,
-			"Can not get memory resource for LCD controller\n");
-		return -ENOENT;
-	}
-
-	len = resource_size(lcdc_regs);
-
-	lcdc_regs = request_mem_region(lcdc_regs->start, len, lcdc_regs->name);
-	if (!lcdc_regs)
-		return -EBUSY;
-
-	da8xx_fb_reg_base = ioremap(lcdc_regs->start, len);
+	da8xx_fb_reg_base = devm_request_and_ioremap(&device->dev, lcdc_regs);
 	if (!da8xx_fb_reg_base) {
-		ret = -EBUSY;
-		goto err_request_mem;
+		dev_err(&device->dev, "memory resource setup failed\n");
+		return -EADDRNOTAVAIL;
 	}
 
-	fb_clk = clk_get(&device->dev, "fck");
+	fb_clk = devm_clk_get(&device->dev, "fck");
 	if (IS_ERR(fb_clk)) {
 		dev_err(&device->dev, "Can not get device clock\n");
-		ret = -ENODEV;
-		goto err_ioremap;
+		return -ENODEV;
 	}
 
 	pm_runtime_enable(&device->dev);
@@ -1458,7 +1441,7 @@ static int fb_probe(struct platform_device *device)
 		lcdc_irq_handler = lcdc_irq_handler_rev02;
 	}
 
-	ret = request_irq(par->irq, lcdc_irq_handler, 0,
+	ret = devm_request_irq(&device->dev, par->irq, lcdc_irq_handler, 0,
 			DRIVER_NAME, par);
 	if (ret)
 		goto irq_freq;
@@ -1488,12 +1471,6 @@ err_pm_runtime_disable:
 	pm_runtime_put_sync(&device->dev);
 	pm_runtime_disable(&device->dev);
 
-err_ioremap:
-	iounmap(da8xx_fb_reg_base);
-
-err_request_mem:
-	release_mem_region(lcdc_regs->start, len);
-
 	return ret;
 }
 
-- 
1.7.9.5
