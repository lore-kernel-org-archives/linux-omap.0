From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2] OMAP: hwmod: Update the sysc_cache in case module context is lost
Date: Tue, 26 Oct 2010 18:30:21 +0530
Message-ID: <1288098021-31097-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58705 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab0JZNAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 09:00:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Do not skip the sysc programming in the hmwod framework based
on the cached value alone, since at times the module might have lost
context (due to the Powerdomain in which the module belongs
transitions to either Open Switch RET or OFF).

Identifying if a module has lost context requires atleast one
register read, and since a register read has more latency than
a write, it makes sense to do a blind write always.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a30658..aadd6dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -209,10 +209,9 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
 
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
-- 
1.7.0.4

