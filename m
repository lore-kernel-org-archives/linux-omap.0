From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 4/6] OMAP2+: hwmod: Do not write the enawakeup bit if SYSC_HAS_ENAWAKEUP is not set
Date: Thu, 23 Jun 2011 23:00:40 +0200
Message-ID: <1308862842-3933-5-git-send-email-b-cousson@ti.com>
References: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43085 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948Ab1FWVBN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:01:13 -0400
In-Reply-To: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

The Type 2 type of IPs will not have any enawakeup bit in their sysconfig.
Writing to that bit will instead trigger a softreset.
Check the flag to write this bit only if the module supports it.

Reported-by: Miguel Vadillo <vadillo@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
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

