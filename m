From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: 32k counter: resolve sparse warnings
Date: Wed, 2 Jan 2013 19:36:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301021935580.17366@utopia.booyaka.com>
References: <20121224012304.13698.43551.stgit@dusk.lan> <20121224012456.13698.41839.stgit@dusk.lan> <20130101181319.GA22106@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41595 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3ABTgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jan 2013 14:36:49 -0500
In-Reply-To: <20130101181319.GA22106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi,

On Tue, 1 Jan 2013, Tony Lindgren wrote:

> Here it's OK to include <plat/counter-32k.h> for multiplatform builds
> as the path will be included in plat-omap/Makefile.

Thanks for the clarification; the patch has been updated as follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 10 Dec 2012 11:48:44 -0700
Subject: [PATCH] ARM: OMAP: 32k counter: resolve sparse warnings

Commit 1fe97c8f6a1de67a5f56e029a818903d5bed8017 ("ARM: OMAP: Make OMAP
clocksource source selection using kernel param") results in a new warning
from sparse:

arch/arm/plat-omap/counter_32k.c:86:12: warning: symbol 'omap_init_clocksource_32k' was not declared. Should it be static?

This second version fixes this warning by including <plat/counter-32k.h>,
at Tony's request.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/counter_32k.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index f3771cd..5b0b86b 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -22,6 +22,8 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
+#include <plat/counter-32k.h>
+
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
 #define OMAP2_32KSYNCNT_REV_OFF		0x0
 #define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
-- 
1.7.10.4

