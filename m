From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: SRAM: resolve sparse warnings
Date: Wed, 2 Jan 2013 19:37:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301021937120.17366@utopia.booyaka.com>
References: <20121224012304.13698.43551.stgit@dusk.lan> <20121224012500.13698.73653.stgit@dusk.lan> <20130101181508.GB22106@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41612 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3ABThv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jan 2013 14:37:51 -0500
In-Reply-To: <20130101181508.GB22106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Tue, 1 Jan 2013, Tony Lindgren wrote:

> Here too we should just include <plat/sram.h>, that's OK for the
> multiplatform builds. Just drivers will not have it available.
> Then eventually the issue disappears as this code becomes a regular
> device driver.

Sounds good; the updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 28 Dec 2012 02:09:15 -0700
Subject: [PATCH] ARM: OMAP: SRAM: resolve sparse warnings

Commit bb77209432873214a796a70a4539e4ebdf3feb54 ("ARM: OMAP: Move
omap2+ specific parts of sram.c to mach-omap2") adds some new sparse
warnings:

arch/arm/plat-omap/sram.c:43:6: warning: symbol 'omap_sram_push_address' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:65:6: warning: symbol 'omap_sram_reset' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:73:13: warning: symbol 'omap_map_sram' was not declared. Should it be static?

This second version fixes the warnings by including <plat/sram.h>, at
Tony's request.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 743fc28..a5bc92d 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -26,6 +26,8 @@
 
 #include <asm/mach/map.h>
 
+#include <plat/sram.h>
+
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
 static void __iomem *omap_sram_base;
-- 
1.7.10.4

