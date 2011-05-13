From: Julia Lawall <julia@diku.dk>
Subject: [PATCH] arch/arm/mach-omap1/dma.c: Invert calls to platform_device_put and platform_device_del
Date: Fri, 13 May 2011 18:46:10 +0200
Message-ID: <1305305170-16922-1-git-send-email-julia@diku.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Platform_device_del should be called before platform_device_put, as
platform_device_put can delete the structure.

Additionally, improve the error handling code for the call to ioremap, so
that it calls platform_device_put.

The semantic match that finds this problem is:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
@@

*platform_device_put(e1);
... when != e1 = e2
*platform_device_del(e1);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
Is an ioremap needed also?  Not clear, because dma_base i a global variable.

 arch/arm/mach-omap1/dma.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index d855934..f5a5220 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -284,14 +284,15 @@ static int __init omap1_system_dma_init(void)
 	dma_base = ioremap(res[0].start, resource_size(&res[0]));
 	if (!dma_base) {
 		pr_err("%s: Unable to ioremap\n", __func__);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto exit_device_put;
 	}
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_device_del;
+		goto exit_device_put;
 	}
 
 	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
@@ -299,7 +300,7 @@ static int __init omap1_system_dma_init(void)
 		dev_err(&pdev->dev, "%s: Unable to allocate 'p' for %s\n",
 			__func__, pdev->name);
 		ret = -ENOMEM;
-		goto exit_device_put;
+		goto exit_device_del;
 	}
 
 	d = kzalloc(sizeof(struct omap_dma_dev_attr), GFP_KERNEL);
@@ -380,10 +381,10 @@ exit_release_d:
 	kfree(d);
 exit_release_p:
 	kfree(p);
-exit_device_put:
-	platform_device_put(pdev);
 exit_device_del:
 	platform_device_del(pdev);
+exit_device_put:
+	platform_device_put(pdev);
 
 	return ret;
 }
