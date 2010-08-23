From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: DSS2 broken with 36-rc1
Date: Mon, 23 Aug 2010 09:46:02 +0300
Message-ID: <4C72192A.9050801@compulab.co.il>
References: <1281962906.1888.25.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52593 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab0HWGqr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 02:46:47 -0400
In-Reply-To: <1281962906.1888.25.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: tomi.valkeinen@nokia.com, linux-omap <linux-omap@vger.kernel.org>

Hi Ameya,

Ameya Palande wrote:
> Hi Tomi,
> 
> When I tried to boot 2.6.36-rc1 kernel on Nokia N900, omapfb failed with
> following error messages:
> 
> [    0.124145] OMAP DSS rev 2.0
> [    0.124237] OMAP DISPC rev 3.0
> 
> [    0.303833] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected
> 
> [    0.805419] omapfb omapfb: failed to allocate framebuffer
> [    0.810882] omapfb omapfb: failed to allocate fbmem
> [    0.815856] omapfb omapfb: failed to setup omapfb
> [    0.820648] omapfb: probe of omapfb failed with error -12

Can you try this one:

 From 28de4496224d1e2ae72dcb5bb52b72d850d3cc49 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <mike@compulab.co.il>
Date: Mon, 23 Aug 2010 09:40:09 +0300
Subject: [PATCH] OMAP: DSS2: OMAPFB: use phys_to_virt for RAM mappings

After commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8 (ARM: Prohibit
ioremap() on kernel managed RAM) it is impossible to ioremap SDRAM for
the framebuffer. Use phys_to_virt for kernel managed RAM mapping and
ioremap for other memory types

Reported-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
  drivers/video/omap2/omapfb/omapfb-main.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 04034d4..7f7b1c2 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1436,7 +1436,10 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
  	}

  	if (ofbi->rotation_type != OMAP_DSS_ROT_VRFB) {
-		vaddr = ioremap_wc(paddr, size);
+		if (region_mem_type(paddr) == OMAP_VRAM_MEMTYPE_SDRAM)
+			vaddr = phys_to_virt(paddr);
+		else
+			vaddr = ioremap_wc(paddr, size);

  		if (!vaddr) {
  			dev_err(fbdev->dev, "failed to ioremap framebuffer\n");
-- 
1.6.6.2




-- 
Sincerely yours,
Mike.

