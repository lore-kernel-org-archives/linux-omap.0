From: Hema HK <hemahk@ti.com>
Subject: [PATCH 7/9 v3] OMAP: Hwmod api changes
Date: Wed, 22 Sep 2010 20:30:16 -0400
Message-ID: <1285201816-26516-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46047 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab0IVO7t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 10:59:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

OMAP USBOTG modules has a requirement to set the auto idle bit only after
setting smart idle bit. Modified the _sys_enable api to set the smart idle
first and then the autoidle bit. Setting this will not have any impact on the
other modules.

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c
+++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
@@ -654,12 +654,6 @@ static void _sysc_enable(struct omap_hwm
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	if (sf & SYSC_HAS_AUTOIDLE) {
-		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
-			0 : 1;
-		_set_module_autoidle(oh, idlemode, &v);
-	}
-
 	/* XXX OCP ENAWAKEUP bit? */
 
 	/*
@@ -672,6 +666,19 @@ static void _sysc_enable(struct omap_hwm
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
 	_write_sysconfig(v, oh);
+
+	/*
+	 * Set the auto idle bit only after setting the smartidle bit
+	 * as this is requirement for some modules like USBOTG
+	 * setting this will not have any impact on the other modues.
+	 */
+
+	if (sf & SYSC_HAS_AUTOIDLE) {
+		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
+			0 : 1;
+		_set_module_autoidle(oh, idlemode, &v);
+	}
+	_write_sysconfig(v, oh);
 }
 
 /**
