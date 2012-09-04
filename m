From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP: remove unused hwmod function prototypes
Date: Tue,  4 Sep 2012 22:15:49 +0300
Message-ID: <1346786149-9228-1-git-send-email-grinberg@compulab.co.il>
References: <y>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:46922 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2IDTQL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Sep 2012 15:16:11 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

Several hwmod function prototypes appear to not have an implementation
because the corresponding functions were removed or renamed.
Those prototypes are unneeded anymore - remove them.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6132972..a673f45 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -591,9 +591,7 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 int __init omap_hwmod_setup_one(const char *name);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
-int _omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
-int _omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
 
 int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *name);
@@ -626,11 +624,6 @@ int omap_hwmod_add_initiator_dep(struct omap_hwmod *oh,
 int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
 				 struct omap_hwmod *init_oh);
 
-int omap_hwmod_set_clockact_both(struct omap_hwmod *oh);
-int omap_hwmod_set_clockact_main(struct omap_hwmod *oh);
-int omap_hwmod_set_clockact_iclk(struct omap_hwmod *oh);
-int omap_hwmod_set_clockact_none(struct omap_hwmod *oh);
-
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh);
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh);
 
-- 
1.7.8.6

