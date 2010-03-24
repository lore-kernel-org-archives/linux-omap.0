From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: vram.c broken in mainline
Date: Wed, 24 Mar 2010 10:04:51 +0200
Message-ID: <20100324080451.GF7534@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60521 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0CXIFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 04:05:22 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Tomi,

drivers/video/omap2/vram.c doesn't compile with 3430sdp in mainline. The 
patch below fixes it.

 From 668f08d0e3cabd0517a5472cd10ce3d147993d69 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Wed, 24 Mar 2010 10:03:57 +0200
Subject: [PATCH] video: omap2: vram: fix compilation of vram.c

a trivial patch changing __early_param into early_param.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
  drivers/video/omap2/vram.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 55a4de5..74df5ea 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -517,7 +517,7 @@ static void __init omap_vram_early_vram(char **p)
  	if (**p == ',')
  		omap_vram_def_sdram_start = simple_strtoul((*p) + 1, p, 16);
  }
-__early_param("vram=", omap_vram_early_vram);
+early_param("vram=", omap_vram_early_vram);
  
  /*
   * Called from map_io. We need to call to this early enough so that we
-- 
1.7.0.rc0.33.g7c3932


-- 
balbi
