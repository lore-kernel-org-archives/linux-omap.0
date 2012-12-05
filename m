From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v7 1/5] ARM: OMAP: gpmc: don't create devices from initcall on DT
Date: Wed,  5 Dec 2012 20:09:27 +0100
Message-ID: <1354734571-10774-2-git-send-email-zonque@gmail.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:50934 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875Ab2LETJq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 14:09:46 -0500
In-Reply-To: <1354734571-10774-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>

On DT driven boards, the gpmc node will match the driver. Hence, there's
no need to do that unconditionally from the initcall.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 65468f6..d5cbd29 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1214,6 +1214,13 @@ static int __init omap_gpmc_init(void)
 	struct platform_device *pdev;
 	char *oh_name = "gpmc";
 
+	/*
+	 * if the board boots up with a populated DT, do not
+	 * manually add the device from this initcall
+	 */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	oh = omap_hwmod_lookup(oh_name);
 	if (!oh) {
 		pr_err("Could not look up %s\n", oh_name);
-- 
1.7.11.7

