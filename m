From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP: hwmod: add read/write API for SYSCONFIG
Date: Tue, 24 Nov 2009 10:10:40 -0800
Message-ID: <1259086241-14088-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:65231 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359AbZKXSKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 13:10:41 -0500
Received: by fxm5 with SMTP id 5so6115990fxm.28
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 10:10:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Some HW blocks have errata which requires selective enabling/disabling
of SYSCONFIG bits.  In particular, some blocks have known issues with
smart-idle so smart-idle has to be disabled under certain conditions.

Add API to read/write a modules SYSCONFIG register which takes
advantage of the built-in caching of omap_hwmod.  Any manual
reading/writing of SYSCONFIG registers outside of hwmod will cause
potential problems in omap_hwmod due to the caching.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   10 ++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eedcc5f..c5c4ddc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -993,6 +993,16 @@ void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 	__raw_writel(v, oh->_rt_va + reg_offs);
 }
 
+u32 omap_hwmod_read_sysc(struct omap_hwmod *oh)
+{
+	return oh->_sysc_cache;
+}
+
+void omap_hwmod_write_sysc(u32 v, struct omap_hwmod *oh)
+{
+	_write_sysconfig(v, oh);
+}
+
 /**
  * omap_hwmod_register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 007935a..db1e6ef 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -446,6 +446,9 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs);
 u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs);
 
+void omap_hwmod_write_sysc(u32 v, struct omap_hwmod *oh);
+u32 omap_hwmod_read_sysc(struct omap_hwmod *oh);
+
 int omap_hwmod_count_resources(struct omap_hwmod *oh);
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
 
-- 
1.6.5.1

