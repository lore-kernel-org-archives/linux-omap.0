From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: [PATCH 2/2] OMAPDSS: Optionally enable write-through cache for the framebuffer
Date: Tue, 22 May 2012 22:54:04 +0300
Message-ID: <1337716444-30139-3-git-send-email-siarhei.siamashka@gmail.com>
References: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64910 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198Ab2EVTyb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 15:54:31 -0400
In-Reply-To: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux@arm.linux.org.uk, tomi.valkeinen@ti.com, Siarhei Siamashka <siarhei.siamashka@gmail.com>

Write-through cached framebuffer eliminates the need for using shadow
framebuffer in xf86-video-fbdev DDX. At the very least this reduces
memory footprint, but the performance is also the same or better
when moving windows or scrolling on ARM11 and Cortex-A8 hardware.

Benchmark with xf86-video-fbdev on IGEPv2 board (TI DM3730, 1GHz),
1280x1024 screen resolution and 32bpp desktop color depth:

$ x11perf -scroll500 -copywinwin500 -copypixpix500 \
          -copypixwin500 -copywinpix500

-- omapfb.vram_cache=n, Option "ShadowFB" "true" in xorg.conf
 10000 trep @   3.4583 msec ( 289.0/sec): Scroll 500x500 pixels
  6000 trep @   4.3255 msec ( 231.0/sec): Copy 500x500 from window to window
  8000 trep @   3.2738 msec ( 305.0/sec): Copy 500x500 from pixmap to window
  8000 trep @   3.1707 msec ( 315.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4761 msec ( 288.0/sec): Copy 500x500 from pixmap to pixmap

-- omapfb.vram_cache=n, Option "ShadowFB" "false" in xorg.conf
  5000 trep @   5.2357 msec ( 191.0/sec): Scroll 500x500 pixels
  1200 trep @  21.0346 msec (  47.5/sec): Copy 500x500 from window to window
  8000 trep @   3.1590 msec ( 317.0/sec): Copy 500x500 from pixmap to window
  6000 trep @   4.5062 msec ( 222.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4767 msec ( 288.0/sec): Copy 500x500 from pixmap to pixmap

-- omapfb.vram_cache=y, Option "ShadowFB" "true" in xorg.conf
 10000 trep @   3.4580 msec ( 289.0/sec): Scroll 500x500 pixels
  6000 trep @   4.3424 msec ( 230.0/sec): Copy 500x500 from window to window
  8000 trep @   3.2673 msec ( 306.0/sec): Copy 500x500 from pixmap to window
  8000 trep @   3.1626 msec ( 316.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4733 msec ( 288.0/sec): Copy 500x500 from pixmap to pixmap

-- omapfb.vram_cache=y, Option "ShadowFB" "false" in xorg.conf
 10000 trep @   3.4893 msec ( 287.0/sec): Scroll 500x500 pixels
  8000 trep @   4.0600 msec ( 246.0/sec): Copy 500x500 from window to window
  8000 trep @   3.1565 msec ( 317.0/sec): Copy 500x500 from pixmap to window
  8000 trep @   3.1373 msec ( 319.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4631 msec ( 289.0/sec): Copy 500x500 from pixmap to pixmap

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 Documentation/arm/OMAP/DSS               |   10 ++++++++++
 drivers/video/omap2/omapfb/omapfb-main.c |    7 ++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 888ae7b..4e41a15 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -293,6 +293,16 @@ omapfb.rotate=<angle>
 omapfb.mirror=<y|n>
 	- Default mirror for all framebuffers. Only works with DMA rotation.
 
+omapfb.vram_cache=<y|n>
+	- Sets the framebuffer memory to be write-through cached. This may be
+	  useful in the configurations where only CPU is allowed to write to
+	  the framebuffer and eliminate the need for enabling shadow
+	  framebuffer in Xorg DDX drivers such as xf86-video-fbdev and
+	  xf86-video-omapfb. Enabling write-through cache is only useful
+	  for ARM11 and Cortex-A8 processors. Cortex-A9 does not support
+	  write-through cache well, see "Cortex-A9 behavior for Normal Memory
+	  Cacheable memory regions" section in Cortex-A9 TRM for more details.
+
 omapdss.def_disp=<display>
 	- Name of default display, to which all overlays will be connected.
 	  Common examples are "lcd" or "tv".
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index b00db40..a684920 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -46,6 +46,7 @@ static char *def_vram;
 static bool def_vrfb;
 static int def_rotate;
 static bool def_mirror;
+static bool def_vram_cache;
 static bool auto_update;
 static unsigned int auto_update_freq;
 module_param(auto_update, bool, 0);
@@ -1123,7 +1124,10 @@ static int omapfb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 	vma->vm_flags |= VM_IO | VM_RESERVED;
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	if (def_vram_cache)
+		vma->vm_page_prot = pgprot_writethrough(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	vma->vm_ops = &mmap_user_ops;
 	vma->vm_private_data = rg;
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
@@ -2493,6 +2497,7 @@ module_param_named(vram, def_vram, charp, 0);
 module_param_named(rotate, def_rotate, int, 0);
 module_param_named(vrfb, def_vrfb, bool, 0);
 module_param_named(mirror, def_mirror, bool, 0);
+module_param_named(vram_cache, def_vram_cache, bool, 0444);
 
 /* late_initcall to let panel/ctrl drivers loaded first.
  * I guess better option would be a more dynamic approach,
-- 
1.7.3.4

