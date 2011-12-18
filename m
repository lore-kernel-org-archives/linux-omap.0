From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ARM: OMAP: avoid NULL pointer dereference when no PMIC is configured
Date: Sun, 18 Dec 2011 20:13:48 +0100
Message-ID: <1324235628-26439-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:60499 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab1LRTNz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Dec 2011 14:13:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/vp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 66bd700..5407173 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -41,6 +41,11 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	u32 val, sys_clk_rate, timeout, waittime;
 	u32 vddmin, vddmax, vstepmin, vstepmax;
 
+	if (!voltdm->pmic) {
+		pr_err("%s: No PMIC configured.\n", __func__, voltdm->name);
+		return;
+	}
+
 	if (!voltdm->read || !voltdm->write) {
 		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
 			__func__, voltdm->name);
-- 
1.7.7.4

