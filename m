From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] ARM: OMAP2+: hwmod: add support for blocking WFI when a
 device is active
Date: Sun, 30 Dec 2012 11:28:30 -0700
Message-ID: <20121230182829.30526.32914.stgit@dusk.lan>
References: <20121230182745.30526.47072.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38196 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab2L3S25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 Dec 2012 13:28:57 -0500
In-Reply-To: <20121230182745.30526.47072.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Apparently, on some OMAPs, the MPU can't be allowed to enter WFI while
certain peripherals are active.  It's not clear why, and it's likely
that there is simply some other bug in the driver or integration code.
But since the likelihood that anyone will have the time to track these
problems down in the future seems quite small, we'll provide a
flag, HWMOD_BLOCK_WFI, to mark these issues in the hwmod data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++++
 arch/arm/mach-omap2/omap_hwmod.h |    9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..6804d47 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -139,6 +139,8 @@
 #include <linux/slab.h>
 #include <linux/bootmem.h>
 
+#include <asm/system_misc.h>
+
 #include "clock.h"
 #include "omap_hwmod.h"
 
@@ -2134,6 +2136,8 @@ static int _enable(struct omap_hwmod *oh)
 	_enable_clocks(oh);
 	if (soc_ops.enable_module)
 		soc_ops.enable_module(oh);
+	if (oh->flags & HWMOD_BLOCK_WFI)
+		disable_hlt();
 
 	if (soc_ops.update_context_lost)
 		soc_ops.update_context_lost(oh);
@@ -2195,6 +2199,8 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 
+	if (oh->flags & HWMOD_BLOCK_WFI)
+		enable_hlt();
 	if (soc_ops.disable_module)
 		soc_ops.disable_module(oh);
 
@@ -2303,6 +2309,8 @@ static int _shutdown(struct omap_hwmod *oh)
 	if (oh->_state == _HWMOD_STATE_ENABLED) {
 		_del_initiator_dep(oh, mpu_oh);
 		/* XXX what about the other system initiators here? dma, dsp */
+		if (oh->flags & HWMOD_BLOCK_WFI)
+			enable_hlt();
 		if (soc_ops.disable_module)
 			soc_ops.disable_module(oh);
 		_disable_clocks(oh);
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 3ae852a..80c00e7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -451,6 +451,14 @@ struct omap_hwmod_omap4_prcm {
  *     enabled.  This prevents the hwmod code from being able to
  *     enable and reset the IP block early.  XXX Eventually it should
  *     be possible to query the clock framework for this information.
+ * HWMOD_BLOCK_WFI: Some OMAP peripherals apparently don't work
+ *     correctly if the MPU is allowed to go idle while the
+ *     peripherals are active.  This is apparently true for the I2C on
+ *     OMAP2420, and also the EMAC on AM3517/3505.  It's unlikely that
+ *     this is really true -- we're probably not configuring something
+ *     correctly, or this is being abused to deal with some PM latency
+ *     issues -- but we're currently suffering from a shortage of
+ *     folks who are able to track these issues down properly.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -462,6 +470,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
 #define HWMOD_EXT_OPT_MAIN_CLK			(1 << 9)
+#define HWMOD_BLOCK_WFI				(1 << 10)
 
 /*
  * omap_hwmod._int_flags definitions


