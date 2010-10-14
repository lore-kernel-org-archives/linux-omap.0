From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context is lost
Date: Thu, 14 Oct 2010 23:52:35 +0530
Message-ID: <1287080555-25399-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33183 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab0JNSWq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 14:22:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Do not skip the sysc programming in the hmwod framework based
on the cached value alone, since at times the module might have lost
context (due to the Powerdomain in which the module belongs
transitions to either Open Switch RET or OFF).

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cb911d7..e57fe21 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -115,7 +115,10 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
 
 	/* XXX ensure module interface clock is up */
 
-	if (oh->_sysc_cache != v) {
+	if ((oh->_sysc_cache != v) ||
+		/* Did the module go to off and loose context? */
+		(oh->_sysc_cache !=
+			 omap_hwmod_readl(oh, oh->class->sysc->sysc_offs))) {
 		oh->_sysc_cache = v;
 		omap_hwmod_writel(v, oh, oh->class->sysc->sysc_offs);
 	}
-- 
1.7.0.4

