From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] OMAP: hwmod: Set autoidle after smartidle during
	_sysc_enable
Date: Fri, 24 Sep 2010 10:40:15 -0600
Message-ID: <20100924164014.19418.88198.stgit@twilight.localdomain>
References: <20100924163936.19418.47065.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56389 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933054Ab0IXQlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:41:22 -0400
In-Reply-To: <20100924163936.19418.47065.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hema HK <hemahk@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Partha Basak <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Hema HK <hemahk@ti.com>

OMAP USBOTG module has a requirement to set the autoidle bit only after
setting smartidle bit. Modified the _sys_enable api to set the smartidle
first and then the autoidle bit. Setting this will not have any impact on the
other modules.

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c3a5889..955861a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -777,12 +777,6 @@ static void _enable_sysc(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	if (sf & SYSC_HAS_AUTOIDLE) {
-		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
-			0 : 1;
-		_set_module_autoidle(oh, idlemode, &v);
-	}
-
 	/*
 	 * XXX The clock framework should handle this, by
 	 * calling into this code.  But this must wait until the
@@ -797,6 +791,17 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	/* If slave is in SMARTIDLE, also enable wakeup */
 	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
 		_enable_wakeup(oh);
+
+	/*
+	 * Set the autoidle bit only after setting the smartidle bit
+	 * Setting this will not have any impact on the other modules.
+	 */
+	if (sf & SYSC_HAS_AUTOIDLE) {
+		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
+			0 : 1;
+		_set_module_autoidle(oh, idlemode, &v);
+		_write_sysconfig(v, oh);
+	}
 }
 
 /**


