From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 18/20] omapfb: Fix coding style / remove dead line
Date: Thu,  4 Jun 2009 20:52:43 +0300
Message-ID: <63e0213f6444a9d3c99c659dbef14207e8756b37.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
 <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
 <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
 <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
 <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
 <d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
 <36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
 <024fee28b6c89decf0d50747127db8fc61ac789e.1244131952.git.imre.deak@nokia.com>
 <20541a2436ab1399a93c28197244bb05e8657859.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42256 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbZFDR4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:56:14 -0400
In-Reply-To: <20541a2436ab1399a93c28197244bb05e8657859.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, arun c <arunedarath@mistralsolutions.com>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>

From: arun c <arunedarath@mistralsolutions.com>

- use __iomem type attribute where appropriate
- expand (a ? : b) to (a ? a : b)
As suggested by Russell King <linux@arm.linux.org.uk>

- remove a dead line from omapfb_main.c

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
CC: linux-arm-kernel@lists.arm.linux.org.uk
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/plat-omap/include/mach/omapfb.h |    4 ++--
 drivers/video/omap/omapfb_main.c         |    5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index 7b74d12..b226bdf 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -276,8 +276,8 @@ typedef int (*omapfb_notifier_callback_t)(struct notifier_block *,
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
index 098177b..0df4523 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -562,7 +562,6 @@ static int set_fb_var(struct fb_info *fbi,
 		var->xoffset = var->xres_virtual - var->xres;
 	if (var->yres + var->yoffset > var->yres_virtual)
 		var->yoffset = var->yres_virtual - var->yres;
-	line_size = var->xres * bpp / 8;
 
 	if (plane->color_mode == OMAPFB_COLOR_RGB444) {
 		var->red.offset	  = 8; var->red.length	 = 4;
@@ -1719,8 +1718,8 @@ static int omapfb_do_probe(struct platform_device *pdev,
 
 	pr_info("omapfb: configured for panel %s\n", fbdev->panel->name);
 
-	def_vxres = def_vxres ? : fbdev->panel->x_res;
-	def_vyres = def_vyres ? : fbdev->panel->y_res;
+	def_vxres = def_vxres ? def_vxres : fbdev->panel->x_res;
+	def_vyres = def_vyres ? def_vyres : fbdev->panel->y_res;
 
 	init_state++;
 
-- 
1.6.3.1

