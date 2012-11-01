From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
Date: Thu, 1 Nov 2012 16:14:29 -0700
Message-ID: <20121101231429.GO15766@atomide.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224828.2103.82950.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39912 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751770Ab2KAXOc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Nov 2012 19:14:32 -0400
Content-Disposition: inline
In-Reply-To: <20121101224828.2103.82950.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [121101 15:50]:
> This file has only omap_init_consistent_dma_size()
> left that can be moved to plat-omap/dma.c.

And this one needs the following compile fix for omap1
at least for Nokia 770. I'll fold it in.

Regards,

Tony


--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -35,6 +35,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 
 #include <plat-omap/dma-omap.h>
 
