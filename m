From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 5/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
Date: Fri, 9 Mar 2012 21:01:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203092100390.30879@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34107 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab2CJEBw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 23:01:52 -0500
In-Reply-To: <1331046702-2472-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Hi

On Tue, 6 Mar 2012, Tero Kristo wrote:

> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> IO Daisychain feature has to be triggered whenever there is a change in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
> 
> Now devices can idle independent of the powerdomain, there can be a
> window where device is idled and corresponding powerdomain can be
> ON/INACTIVE state. In such situations, since both module wake up is
> enabled at padlevel as well as io daisychain sequence is triggered,
> there will be 2 PRCM interrupts (Module async wake up via swakeup and
> IO Pad interrupt). But as PRCM Interrupt handler clears the Module
> Padlevel WKST bit in the first interrupt, module specific interrupt
> handler will not triggered for the second time
> 
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Here's an updated version of this patch that removes the dependency on 
mach-omap2/pm.*.


- Paul

From: Vishwanath BS <vishwanath.bs@ti.com>
Date: Fri, 2 Mar 2012 17:17:54 +0200
Subject: [PATCH 5/6] ARM: OMAP3PLUS: hwmod: reconfigure IO Daisychain during
 hwmod mux

IO Daisychain feature has to be triggered whenever there is a change in
device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).

Now devices can idle independent of the powerdomain, there can be a
window where device is idled and corresponding powerdomain can be
ON/INACTIVE state. In such situations, since both module wake up is
enabled at padlevel as well as io daisychain sequence is triggered,
there will be 2 PRCM interrupts (Module async wake up via swakeup and
IO Pad interrupt). But as PRCM Interrupt handler clears the Module
Padlevel WKST bit in the first interrupt, module specific interrupt
handler will not triggered for the second time

Also look at detailed explanation given by Rajendra at
http://www.spinics.net/lists/linux-serial/msg04480.html

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul@pwsan.com: remove dependency on pm.c & pm.h; add kerneldoc]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eba6cd3..58a5920 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -152,6 +152,7 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "mux.h"
+#include "pm.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
@@ -165,6 +166,8 @@ static LIST_HEAD(omap_hwmod_list);
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
 
+/* io_chain_lock: used to serialize reconfigurations of the I/O chain */
+static DEFINE_SPINLOCK(io_chain_lock);
 
 /* Private functions */
 
@@ -1481,6 +1484,32 @@ static int _reset(struct omap_hwmod *oh)
 }
 
 /**
+ * _reconfigure_io_chain - clear any I/O chain wakeups and reconfigure chain
+ *
+ * Call the appropriate PRM function to clear any logged I/O chain
+ * wakeups and to reconfigure the chain.  This apparently needs to be
+ * done upon every mux change.  Since hwmods can be concurrently
+ * enabled and idled, hold a spinlock around the I/O chain
+ * reconfiguration sequence.  No return value.
+ *
+ * XXX When the PRM code is moved to drivers, this function can be removed,
+ * as the PRM infrastructure should abstract this.
+ */
+static void _reconfigure_io_chain(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_chain_lock, flags);
+
+	if (cpu_is_omap34xx() && omap3_has_io_chain_ctrl())
+		omap3xxx_prm_reconfigure_io_chain();
+	else if (cpu_is_omap44xx())
+		omap44xx_prm_reconfigure_io_chain();
+
+	spin_unlock_irqrestore(&io_chain_lock, flags);
+}
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -1535,8 +1564,10 @@ static int _enable(struct omap_hwmod *oh)
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
 			((oh->_state == _HWMOD_STATE_IDLE) &&
-			 oh->mux->pads_dynamic)))
+			 oh->mux->pads_dynamic))) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+		_reconfigure_io_chain();
+	}
 
 	_add_initiator_dep(oh, mpu_oh);
 
@@ -1622,8 +1653,10 @@ static int _idle(struct omap_hwmod *oh)
 		clkdm_hwmod_disable(oh->clkdm, oh);
 
 	/* Mux pins for device idle if populated */
-	if (oh->mux && oh->mux->pads_dynamic)
+	if (oh->mux && oh->mux->pads_dynamic) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+		_reconfigure_io_chain();
+	}
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
-- 
1.7.9.1

