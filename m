From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 5/6] OMAP2+: hwmod: Add wakeup support for new OMAP4 IPs
Date: Wed, 15 Dec 2010 15:49:26 +0100
Message-ID: <1292424567-25794-6-git-send-email-b-cousson@ti.com>
References: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50949 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab0LOOwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 09:52:00 -0500
In-Reply-To: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

The new OMAP4 IPs introduced a new idle mode named smart-idle with wakeup.

This new idlemode replaces the enawakeup for the new IPs but seems to
coexist as well for some legacy IPs (UART, GPIO, MCSPI...)

Add the new SIDLE_SMART_WKUP flag to mark the IPs that support this
capability.
The omap_hwmod_44xx_data.c will have to be updated to add this new flag.

Enable this new mode when applicable in _enable_wakeup, _enable_sysc and
_idle_sysc.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Tested-by: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   16 ++++++++++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c576121..03ffa3b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -393,7 +393,8 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 	u32 wakeup_mask;
 
 	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
+	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
+	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)))
 		return -EINVAL;
 
 	if (!oh->class->sysc->sysc_fields) {
@@ -405,6 +406,9 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	*v |= wakeup_mask;
 
+	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
+		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
+
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
 	oh->_int_flags |= _HWMOD_WAKEUP_ENABLED;
@@ -424,7 +428,8 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 	u32 wakeup_mask;
 
 	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
+	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
+	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)))
 		return -EINVAL;
 
 	if (!oh->class->sysc->sysc_fields) {
@@ -436,6 +441,9 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	*v &= ~wakeup_mask;
 
+	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
+		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
+
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
 	oh->_int_flags &= ~_HWMOD_WAKEUP_ENABLED;
@@ -832,6 +840,10 @@ static void _idle_sysc(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
+	/* If slave is in SMARTIDLE, also enable wakeup */
+	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
+		_enable_wakeup(oh, &v);
+
 	_write_sysconfig(v, oh);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index ab99b8c..619877c 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -76,6 +76,8 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 #define HWMOD_IDLEMODE_FORCE		(1 << 0)
 #define HWMOD_IDLEMODE_NO		(1 << 1)
 #define HWMOD_IDLEMODE_SMART		(1 << 2)
+/* Slave idle mode flag only */
+#define HWMOD_IDLEMODE_SMART_WKUP	(1 << 3)
 
 /**
  * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
@@ -227,11 +229,12 @@ struct omap_hwmod_ocp_if {
 /* Macros for use in struct omap_hwmod_sysconfig */
 
 /* Flags for use in omap_hwmod_sysconfig.idlemodes */
-#define MASTER_STANDBY_SHIFT	2
+#define MASTER_STANDBY_SHIFT	4
 #define SLAVE_IDLE_SHIFT	0
 #define SIDLE_FORCE		(HWMOD_IDLEMODE_FORCE << SLAVE_IDLE_SHIFT)
 #define SIDLE_NO		(HWMOD_IDLEMODE_NO << SLAVE_IDLE_SHIFT)
 #define SIDLE_SMART		(HWMOD_IDLEMODE_SMART << SLAVE_IDLE_SHIFT)
+#define SIDLE_SMART_WKUP	(HWMOD_IDLEMODE_SMART_WKUP << SLAVE_IDLE_SHIFT)
 #define MSTANDBY_FORCE		(HWMOD_IDLEMODE_FORCE << MASTER_STANDBY_SHIFT)
 #define MSTANDBY_NO		(HWMOD_IDLEMODE_NO << MASTER_STANDBY_SHIFT)
 #define MSTANDBY_SMART		(HWMOD_IDLEMODE_SMART << MASTER_STANDBY_SHIFT)
-- 
1.7.0.4

