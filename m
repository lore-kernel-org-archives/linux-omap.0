From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/4] OMAP: hwmod: Do not disable clocks if hwmod already in idle
Date: Wed,  4 Aug 2010 23:38:28 +0200
Message-ID: <1280957910-22718-3-git-send-email-b-cousson@ti.com>
References: <1280957910-22718-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57736 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab0HDVil (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 17:38:41 -0400
In-Reply-To: <1280957910-22718-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

The disable function was disabling clocks and dependencies
from both enable and idle state. Since idle function is already
disabling both, an enable -> idle -> disable sequence will
try to disable twice the clocks and thus generate a
"Trying disable clock XXX with 0 usecount" warning.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8bf19a7..5bb25e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -982,9 +982,13 @@ static int _shutdown(struct omap_hwmod *oh)
 
 	if (oh->class->sysc)
 		_sysc_shutdown(oh);
-	_del_initiator_dep(oh, mpu_oh);
-	/* XXX what about the other system initiators here? DMA, tesla, d2d */
-	_disable_clocks(oh);
+
+	/* clocks and deps are already disabled in idle */
+	if (oh->_state == _HWMOD_STATE_ENABLED) {
+		_del_initiator_dep(oh, mpu_oh);
+		/* XXX what about the other system initiators here? dma, dsp */
+		_disable_clocks(oh);
+	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
 	/* XXX mux any associated balls to safe mode */
-- 
1.6.1.3

