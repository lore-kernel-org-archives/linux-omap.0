From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 07/23] OMAP3 SDRC: initialize SDRC_POWER at boot
Date: Thu, 11 Dec 2008 17:52:26 +0200
Message-ID: <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55858 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204AbYLKP7X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:23 -0500
In-Reply-To: <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Initialize SDRC_POWER to a known-good setting when the kernel boots.
Necessary since some bootloaders don't initialize SDRC_POWER properly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sdrc.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2a30060..d62e4e1 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -37,6 +37,10 @@ static struct omap_sdrc_params *sdrc_init_params;
 void __iomem *omap2_sdrc_base;
 void __iomem *omap2_sms_base;
 
+/* SDRC_POWER register bits */
+#define SDRC_POWER_EXTCLKDIS_SHIFT		3
+#define SDRC_POWER_PWDENA_SHIFT			2
+#define SDRC_POWER_PAGEPOLICY_SHIFT		0
 
 /**
  * omap2_sdrc_get_params - return SDRC register values for a given clock rate
@@ -74,7 +78,14 @@ void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
 	omap2_sms_base = omap2_globals->sms;
 }
 
-/* turn on smart idle modes for SDRAM scheduler and controller */
+/**
+ * omap2_sdrc_init - initialize SMS, SDRC devices on boot
+ * @sp: pointer to a null-terminated list of struct omap_sdrc_params
+ *
+ * Turn on smart idle modes for SDRAM scheduler and controller.
+ * Program a known-good configuration for the SDRC to deal with buggy
+ * bootloaders.
+ */
 void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 {
 	u32 l;
@@ -90,4 +101,10 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 	sdrc_write_reg(l, SDRC_SYSCONFIG);
 
 	sdrc_init_params = sp;
+
+	/* XXX Enable SRFRONIDLEREQ here also? */
+	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
+		(1 << SDRC_POWER_PWDENA_SHIFT) |
+		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
+	sdrc_write_reg(l, SDRC_POWER);
 }
-- 
1.5.4.3

