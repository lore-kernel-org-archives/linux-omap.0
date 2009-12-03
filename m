From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/10] OMAP3 hwmod: reprogram OCP_SYSCONFIG register after
	setting SOFTRESET
Date: Thu, 03 Dec 2009 06:49:41 -0700
Message-ID: <20091203134940.17146.90982.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49040 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbZLCNyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:54:36 -0500
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Reprogram the module's OCP_SYSCONFIG register after module reset (SOFTRESET
= 1).  This may not be needed, but the definition of the reset performed by
the SOFTRESET bit is unclear.

Kevin Hilman <khilman@deeprootsystems.com> tested an earlier version of
this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 633b216..4aab1b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -948,11 +948,19 @@ static int _setup(struct omap_hwmod *oh)
 
 	_enable(oh);
 
-	if (!(oh->flags & HWMOD_INIT_NO_RESET))
-		_reset(oh);
-
-	/* XXX OCP AUTOIDLE bit? */
-	/* XXX OCP ENAWAKEUP bit? */
+	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+		/*
+		 * XXX Do the OCP_SYSCONFIG bits need to be
+		 * reprogrammed after a reset?  If not, then this can
+		 * be removed.  If they do, then probably the
+		 * _enable() function should be split to avoid the
+		 * rewrite of the OCP_SYSCONFIG register.
+		 */
+		if (oh->sysconfig) {
+			_update_sysc_cache(oh);
+			_sysc_enable(oh);
+		}
+	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_IDLE))
 		_idle(oh);


