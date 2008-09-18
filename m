From: "arun c" <arun.edarath@gmail.com>
Subject: [PATCH] omapfb: Remove casting and change coding style
Date: Thu, 18 Sep 2008 08:49:31 -0400
Message-ID: <c656a4d20809180549y7ad49f40tb235a52ac6d9de8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.245]:16417 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbYIRMtg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 08:49:36 -0400
Received: by ag-out-0708.google.com with SMTP id 31so6400437agc.10
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 05:49:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

As sugested by RMK

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 arch/arm/plat-omap/include/mach/omapfb.h |    4 ++--
 drivers/video/omap/omapfb_main.c         |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omapfb.h
b/arch/arm/plat-omap/include/mach/omapfb.h
index a4a84f3..a3c4408 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -276,8 +276,8 @@ typedef int (*omapfb_notifier_callback_t)(struct
notifier_block *,
 					  void *fbi);

 struct omapfb_mem_region {
-	dma_addr_t	paddr;
-	void		*vaddr;
+	u32		paddr;
+	void __iomem	*vaddr;
 	unsigned long	size;
 	u8		type;		/* OMAPFB_PLANE_MEM_* */
 	unsigned	alloc:1;	/* allocated by the driver */
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index d176a2c..3bb4247 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -402,7 +402,7 @@ static void set_fb_fix(struct fb_info *fbi)
 	int bpp;

 	rg = &plane->fbdev->mem_desc.region[plane->idx];
-	fbi->screen_base	= (char __iomem *)rg->vaddr;
+	fbi->screen_base	= rg->vaddr;
 	fix->smem_start		= rg->paddr;
 	fix->smem_len		= rg->size;

@@ -1718,8 +1718,8 @@ static int omapfb_do_probe(struct platform_device *pdev,

 	pr_info("omapfb: configured for panel %s\n", fbdev->panel->name);

-	def_vxres = def_vxres ? : fbdev->panel->x_res;
-	def_vyres = def_vyres ? : fbdev->panel->y_res;
+	def_vxres = def_vxres ? def_vxres : fbdev->panel->x_res;
+	def_vyres = def_vyres ? def_vyres : fbdev->panel->y_res;

 	init_state++;

-- 
1.5.3.4
