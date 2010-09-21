From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/11] OMAP: hwmod: Fix omap_hwmod_reset wrong state test
Date: Tue, 21 Sep 2010 10:34:45 -0600
Message-ID: <20100921163444.20258.66902.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47023 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031Ab0IUQfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:35:39 -0400
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>

From: Liam Girdwood <lrg@slimlogic.co.uk>

The reset function wrongly used the state flag as a bit mask and was trying
to re-enable after a reset.

hwmod is still enabled for the PRCM point of view after a softreset
so there is no need to re-enable.

Remove the state check from omap_hwmod_reset since the _reset
function is checking that as well and in addition can generate
a warning

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
[b-cousson@ti.com: remove the wrong test, remove the re-enable]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5bb25e3..100115f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1434,19 +1434,17 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh)
  *
  * Under some conditions, a driver may wish to reset the entire device.
  * Called from omap_device code.  Returns -EINVAL on error or passes along
- * the return value from _reset()/_enable().
+ * the return value from _reset().
  */
 int omap_hwmod_reset(struct omap_hwmod *oh)
 {
 	int r;
 
-	if (!oh || !(oh->_state & _HWMOD_STATE_ENABLED))
+	if (!oh)
 		return -EINVAL;
 
 	mutex_lock(&omap_hwmod_mutex);
 	r = _reset(oh);
-	if (!r)
-		r = _omap_hwmod_enable(oh);
 	mutex_unlock(&omap_hwmod_mutex);
 
 	return r;


