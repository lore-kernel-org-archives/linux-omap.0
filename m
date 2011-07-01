From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/8] OMAP2+: hwmod: Do not write the enawakeup bit if SYSC_HAS_ENAWAKEUP is not set
Date: Fri, 1 Jul 2011 22:54:03 +0200
Message-ID: <1309553647-14624-5-git-send-email-b-cousson@ti.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58576 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757070Ab1GAUyW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:54:22 -0400
In-Reply-To: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The Type 2 type of IPs will not have any enawakeup bit in their sysconfig.
Writing to that bit will instead trigger a softreset.
Check the flag to write this bit only if the module supports it.

Reported-by: Miguel Vadillo <vadillo@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbc2a8a..3800084 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -387,8 +387,6 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
  */
 static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 {
-	u32 wakeup_mask;
-
 	if (!oh->class->sysc ||
 	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
 	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP) ||
@@ -400,9 +398,8 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 		return -EINVAL;
 	}
 
-	wakeup_mask = (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
-
-	*v |= wakeup_mask;
+	if (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)
+		*v |= 0x1 << oh->class->sysc->sysc_fields->enwkup_shift;
 
 	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
@@ -425,8 +422,6 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
  */
 static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 {
-	u32 wakeup_mask;
-
 	if (!oh->class->sysc ||
 	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
 	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP) ||
@@ -438,9 +433,8 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 		return -EINVAL;
 	}
 
-	wakeup_mask = (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
-
-	*v &= ~wakeup_mask;
+	if (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)
+		*v &= ~(0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
 
 	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
-- 
1.7.0.4

