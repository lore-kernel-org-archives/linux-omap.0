From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 8/8] OMAP2+: hwmod: Update the sysc_cache in case module
	context is lost
Date: Tue, 16 Nov 2010 03:18:17 -0700
Message-ID: <20101116101812.22777.51753.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51545 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934201Ab0KPKTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:15 -0500
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Do not skip the sysc programming in the hmwod framework based
on the cached value alone, since at times the module might have lost
context (due to the Powerdomain in which the module belongs
transitions to either Open Switch RET or OFF).

Identifying if a module has lost context requires atleast one
register read, and since a register read has more latency than
a write, it makes sense to do a blind write always.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 589c282..8a9847e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -211,10 +211,9 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
 
 	/* XXX ensure module interface clock is up */
 
-	if (oh->_sysc_cache != v) {
-		oh->_sysc_cache = v;
-		omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
-	}
+	/* Module might have lost context, always update cache and register */
+	oh->_sysc_cache = v;
+	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
 }
 
 /**


