From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/4] ARM: OMAP3+: PM: VP: check only the VPINIDLE status bit
Date: Thu, 31 May 2012 20:41:36 -0500
Message-ID: <1338514899-3560-2-git-send-email-nm@ti.com>
References: <1338514899-3560-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55968 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753943Ab2FABlv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 21:41:51 -0400
Received: by obceq6 with SMTP id eq6so2786834obc.37
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 18:41:49 -0700 (PDT)
In-Reply-To: <1338514899-3560-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>

Currently we check against the entire 32 bits of the status register
Where, bits 1-31 are marked as reserved and mentioned in TRM as read
returns undefined values. Hence, check against purely the vpinidle
status bit.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Reported-by: Vinay Amancha <vinaykumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vp.c          |    5 +++--
 arch/arm/mach-omap2/vp.h          |    1 +
 arch/arm/mach-omap2/vp3xxx_data.c |    1 +
 arch/arm/mach-omap2/vp44xx_data.c |    1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index f95c1ba..faefef7 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -270,8 +270,9 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 	/*
 	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
 	 */
-	omap_test_timeout((voltdm->read(vp->vstatus)),
-			  VP_IDLE_TIMEOUT, timeout);
+	omap_test_timeout((voltdm->read(vp->vstatus) &
+			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
+			  timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)
 		pr_warning("%s: vdd_%s idle timedout\n",
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 7c155d2..ac1d6cf 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -73,6 +73,7 @@ struct omap_vp_common {
 	u8 vpconfig_initvdd;
 	u8 vpconfig_forceupdate;
 	u8 vpconfig_vpenable;
+	u8 vstatus_vpidle;
 	u8 vstepmin_stepmin_shift;
 	u8 vstepmin_smpswaittimemin_shift;
 	u8 vstepmax_stepmax_shift;
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index bd89f80..a65909b 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -44,6 +44,7 @@ static const struct omap_vp_common omap3_vp_common = {
 	.vpconfig_initvdd = OMAP3430_INITVDD_MASK,
 	.vpconfig_forceupdate = OMAP3430_FORCEUPDATE_MASK,
 	.vpconfig_vpenable = OMAP3430_VPENABLE_MASK,
+	.vstatus_vpidle = OMAP3430_VPINIDLE_MASK,
 	.vstepmin_smpswaittimemin_shift = OMAP3430_SMPSWAITTIMEMIN_SHIFT,
 	.vstepmax_smpswaittimemax_shift = OMAP3430_SMPSWAITTIMEMAX_SHIFT,
 	.vstepmin_stepmin_shift = OMAP3430_VSTEPMIN_SHIFT,
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index 8c031d1..9d14881 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -44,6 +44,7 @@ static const struct omap_vp_common omap4_vp_common = {
 	.vpconfig_initvdd = OMAP4430_INITVDD_MASK,
 	.vpconfig_forceupdate = OMAP4430_FORCEUPDATE_MASK,
 	.vpconfig_vpenable = OMAP4430_VPENABLE_MASK,
+	.vstatus_vpidle = OMAP4430_VPINIDLE_MASK,
 	.vstepmin_smpswaittimemin_shift = OMAP4430_SMPSWAITTIMEMIN_SHIFT,
 	.vstepmax_smpswaittimemax_shift = OMAP4430_SMPSWAITTIMEMAX_SHIFT,
 	.vstepmin_stepmin_shift = OMAP4430_VSTEPMIN_SHIFT,
-- 
1.7.9.5

