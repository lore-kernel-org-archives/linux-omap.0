From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP: Move omap2+ specific parts of sram.c
 to mach-omap2
Date: Wed, 31 Oct 2012 15:40:44 -0700
Message-ID: <20121031224044.GE15766@atomide.com>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121030235249.25936.15471.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:13570 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755502Ab2JaWkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 18:40:47 -0400
Content-Disposition: inline
In-Reply-To: <20121030235249.25936.15471.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [121030 16:54]:
> Let's make the omap2+ specific parts private to mach-omap2.
> 
> This leaves just a minimal shared code into plat-omap like
> it should be.

Found an error with make randconfig if we have
CONFIG_OMAP4_ERRATA_I688 enabled, I'll fold in the
following fix to this patch.

Regards,

Tony


--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -32,6 +32,7 @@
 #include "hsmmc.h"
 #include "omap4-sar-layout.h"
 #include "omap-secure.h"
+#include "sram.h"
 
 #ifdef CONFIG_CACHE_L2X0
 static void __iomem *l2cache_base;
