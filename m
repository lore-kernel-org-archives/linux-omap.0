From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of sysconfig
 register.
Date: Mon, 11 Jan 2010 15:32:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001111529380.8534@utopia.booyaka.com>
References: <1260098674-27143-1-git-send-email-thara@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E171@dbde02.ent.ti.com> <alpine.DEB.2.00.1001051730230.21295@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E1D6B7B@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001111515080.8534@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37632 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab0AKWcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 17:32:21 -0500
In-Reply-To: <alpine.DEB.2.00.1001111515080.8534@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 11 Jan 2010, Paul Walmsley wrote:

> Queued for .33-rc (fixes).

By the way, the patch had to be slightly tweaked to apply it since the 
original was based on the configurable clockactivity offset patch - here's 
what is queued in the 'for_2.6.33rc_d' branch of 
git://git.pwsan.com/linux-2.6

- Paul


>From 5d121735372f9983cca1747bc0332a045151d4a8 Mon Sep 17 00:00:00 2001
From: Thara Gopinath <thara@ti.com>
Date: Mon, 11 Jan 2010 15:25:05 -0700
Subject: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of sysconfig register.

In the current implementation the sysconfig value is read into
 _sysc_cache once and an actual update to the sysconfig register
happens only if the new value paased is differnt from the one in _sysc_cache.
_sysc_cache is updated only if _HWMOD_SYSCONFIG_LOADED is not set.
This can lead to the follwing issue if off mode is enabled in modules
which employs "always-retore" mechanism of context save and restore.

        a. The module sets the sysconfig register through omap_device_enable.
           Here _sysc_cache is updated with the value written to the sysconfig
           register and left.
        b. The power domain containig the module enters off mode and the
           module context is lost.
        c. The module in use becomes active and calls omap_device_enable to
           enable itself. Here a read of sysconfig register does not happen
           as _HWMOD_SYSCONFIG_LOADED flag is set. The value to be written
           to the sysconfig register will be same as the one written in step a.
           Since _sysc_cache reflects the previous written value an update
           of the sysconfig register does not happen.
This means in modules which employs "always-restore" mechanism
after off , the sysconfig regsiters will never get updated.

This patch introduces a flag SYSC_NO_CACHE which if set ensures that the
sysconfig register is always read into _sysc_cache before an update is
attempted.

This flags need to be set only by modules which does not do a context save
but re-initializes the registers every time the module is accessed. This
includes modules like i2c, smartreflex etc.

Signed-off-by: Thara Gopinath <thara@ti.com>
[paul@pwsan.com: tweaked to apply on a different head]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d8c8545..478ae58 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -94,7 +94,8 @@ static int _update_sysc_cache(struct omap_hwmod *oh)
 
 	oh->_sysc_cache = omap_hwmod_readl(oh, oh->sysconfig->sysc_offs);
 
-	oh->_int_flags |= _HWMOD_SYSCONFIG_LOADED;
+	if (!(oh->sysconfig->sysc_flags & SYSC_NO_CACHE))
+		oh->_int_flags |= _HWMOD_SYSCONFIG_LOADED;
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 007935a..c110c8a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -227,6 +227,7 @@ struct omap_hwmod_ocp_if {
 #define SYSC_HAS_SIDLEMODE	(1 << 5)
 #define SYSC_HAS_MIDLEMODE	(1 << 6)
 #define SYSS_MISSING		(1 << 7)
+#define SYSC_NO_CACHE		(1 << 8)
 
 /* omap_hwmod_sysconfig.clockact flags */
 #define CLOCKACT_TEST_BOTH	0x0
-- 
1.6.6.rc2.5.g49666

