From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP: hwmod: add read/write API for SYSCONFIG
Date: Fri,  8 Jan 2010 15:26:52 -0800
Message-ID: <1262993213-19866-3-git-send-email-khilman@deeprootsystems.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com>
 <1262993213-19866-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:51668 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0AHX07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 18:26:59 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so4078226pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 15:26:59 -0800 (PST)
In-Reply-To: <1262993213-19866-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Some HW blocks have errata which requires selective enabling/disabling
of SYSCONFIG bits.  In particular, some blocks have known issues with
smart-idle so smart-idle has to be disabled under certain conditions.

Add API to read/write a modules SYSCONFIG register which takes
advantage of the built-in caching of omap_hwmod.  Any manual
reading/writing of SYSCONFIG registers outside of hwmod will cause
potential problems in omap_hwmod due to the caching.

RFC: would an API to only touch smart-idle be more appropriate?
Maybe omap_hwmod_smart_idle_enable(oh, bool enable)?

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   10 ++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d8c8545..307deea 100644
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
1.6.6.rc2.1.g42108

