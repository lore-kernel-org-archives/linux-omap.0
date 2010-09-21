From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/11] OMAP: hwmod: Do not disable clocks if hwmod already in
	idle
Date: Tue, 21 Sep 2010 10:34:44 -0600
Message-ID: <20100921163442.20258.7393.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47019 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab0IUQfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:35:39 -0400
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

The disable function was disabling clocks and dependencies
from both enable and idle state. Since idle function is already
disabling both, an enable -> idle -> disable sequence will
try to disable twice the clocks and thus generate a
"Trying disable clock XXX with 0 usecount" warning.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


