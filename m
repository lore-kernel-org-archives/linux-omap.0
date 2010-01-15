From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP: hwmod: add read/write API for SYSCONFIG - for 2.6.34
Date: Fri, 15 Jan 2010 10:11:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001151009280.9529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41800 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab0AORLI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 12:11:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com


Hi,

this patch is currently queued for 2.6.34, but is being posted here in 
case anyone has any further comments.


- Paul


From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Mon, 23 Nov 2009 09:41:54 -0800
Subject: [PATCH 2/2] OMAP: hwmod: add API for slave idlemode setting

Some HW blocks have errata which requires specific slave idle mode
under certain conditions.

This patch adds an hwmod API to allow setting slave idlemode
ensuring that any SYSCONFIG register updates go through hwmod.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   17 +++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d8c8545..3bc47dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -993,6 +993,23 @@ void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 	__raw_writel(v, oh->_rt_va + reg_offs);
 }
 
+int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
+{
+	u32 v;
+	int retval = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	v = oh->_sysc_cache;
+
+	retval = _set_slave_idlemode(oh, idlemode, &v);
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	return retval;
+}
+
 /**
  * omap_hwmod_register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 007935a..1f57330 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -440,6 +440,8 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh);
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
+int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
+
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 
-- 
1.6.6
