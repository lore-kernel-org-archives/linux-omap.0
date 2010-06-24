From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR] [PATCH 1/4] omap: sr: export sr_dbg_dir
Date: Thu, 24 Jun 2010 16:29:23 -0500
Message-ID: <1277414966-31806-2-git-send-email-nm@ti.com>
References: <1277414966-31806-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48902 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653Ab0FXV3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 17:29:31 -0400
In-Reply-To: <1277414966-31806-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

sr_dbg_dir is currently used privately in smartreflex.c, however,
smartreflex class drivers could store their own debugfs entries there
as well.

This also fixes the sparse warning:
arch/arm/mach-omap2/smartreflex.c:44:15: warning: symbol 'sr_dbg_dir' was not declared. Should it be static?

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/smartreflex.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
index 1105db0..df58026 100644
--- a/arch/arm/plat-omap/include/plat/smartreflex.h
+++ b/arch/arm/plat-omap/include/plat/smartreflex.h
@@ -263,6 +263,11 @@ int omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
 
 /* API to register the pmic specific data with the smartreflex driver. */
 void omap_sr_register_pmic(struct omap_smartreflex_pmic_data *pmic_data);
+
+#ifdef CONFIG_PM_DEBUG
+extern struct dentry *sr_dbg_dir;
+#endif
+
 #else
 static inline void omap_smartreflex_enable(int srid) {}
 static inline void omap_smartreflex_disable(int srid) {}
-- 
1.6.3.3

