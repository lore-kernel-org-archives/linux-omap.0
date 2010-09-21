From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] OMAP: hwmod: Force a softreset during _setup
Date: Mon, 20 Sep 2010 23:04:51 -0600
Message-ID: <20100921050450.31230.89186.stgit@twilight.localdomain>
References: <20100921050437.31230.13420.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33960 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0IUFHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 01:07:18 -0400
In-Reply-To: <20100921050437.31230.13420.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Benoit Cousson <b-cousson@ti.com>

Force the softreset of every IPs during the _setup phase.
IPs that cannot support softreset or that should not
be reset must set the HWMOD_INIT_NO_RESET flag in the
hwmod struct.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f4a569c..3e90984 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -980,8 +980,8 @@ static int _reset(struct omap_hwmod *oh)
 
 	/* clocks must be on for this operation */
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
-		WARN(1, "omap_hwmod: %s: reset can only be entered from "
-		     "enabled state\n", oh->name);
+		pr_warning("omap_hwmod: %s: reset can only be entered from "
+			   "enabled state\n", oh->name);
 		return -EINVAL;
 	}
 
@@ -998,8 +998,8 @@ static int _reset(struct omap_hwmod *oh)
 			  MAX_MODULE_SOFTRESET_WAIT, c);
 
 	if (c == MAX_MODULE_SOFTRESET_WAIT)
-		WARN(1, "omap_hwmod: %s: softreset failed (waited %d usec)\n",
-		     oh->name, MAX_MODULE_SOFTRESET_WAIT);
+		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
+			   oh->name, MAX_MODULE_SOFTRESET_WAIT);
 	else
 		pr_debug("omap_hwmod: %s: softreset in %d usec\n", oh->name, c);
 
@@ -1198,12 +1198,12 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+		_reset(oh);
+
 		/*
-		 * XXX Do the OCP_SYSCONFIG bits need to be
-		 * reprogrammed after a reset?  If not, then this can
-		 * be removed.  If they do, then probably the
-		 * _omap_hwmod_enable() function should be split to avoid the
-		 * rewrite of the OCP_SYSCONFIG register.
+		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
+		 * The _omap_hwmod_enable() function should be split to
+		 * avoid the rewrite of the OCP_SYSCONFIG register.
 		 */
 		if (oh->class->sysc) {
 			_update_sysc_cache(oh);


