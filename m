From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: hwmod: add support for lock and unlock hooks
Date: Wed, 10 Jun 2015 14:56:24 +0530
Message-ID: <1433928386-24891-2-git-send-email-lokeshvutla@ti.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54403 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbbFJJ3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2015 05:29:31 -0400
In-Reply-To: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, t-kristo@ti.com, lokeshvutla@ti.com

Some IP blocks like RTC, needs an additional setting for writing to its
registers. This is to prevent any spurious writes from changing the
register values.

This patch adds optional lock and unlock function pointers to
the IP block's hwmod data. These unlock and lock function pointers
are called by hwmod code before and after writing sysconfig registers.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 752969f..44c916d3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -299,7 +299,20 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
 
 	/* Module might have lost context, always update cache and register */
 	oh->_sysc_cache = v;
+
+	/*
+	 * Some IP blocks (such as RTC) require unlocking of IP before
+	 * accessing its registers. If a function pointer is present
+	 * to unlock, then call it before accessing sysconfig and
+	 * call lock after writing sysconfig.
+	 */
+	if (oh->class->unlock)
+		oh->class->unlock(oh);
+
 	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
+
+	if (oh->class->lock)
+		oh->class->lock(oh);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 9611c91..44c7db9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -570,6 +570,8 @@ struct omap_hwmod_omap4_prcm {
  * @pre_shutdown: ptr to fn to be executed immediately prior to device shutdown
  * @reset: ptr to fn to be executed in place of the standard hwmod reset fn
  * @enable_preprogram:  ptr to fn to be executed during device enable
+ * @lock: ptr to fn to be executed to lock IP registers
+ * @unlock: ptr to fn to be executed to unlock IP registers
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
@@ -594,6 +596,8 @@ struct omap_hwmod_class {
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
 	int					(*reset)(struct omap_hwmod *oh);
 	int					(*enable_preprogram)(struct omap_hwmod *oh);
+	void				(*lock)(struct omap_hwmod *oh);
+	void				(*unlock)(struct omap_hwmod *oh);
 };
 
 /**
-- 
1.9.1

