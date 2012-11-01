From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 3/4] ARM: OMAP: gpmc: don't create devices from initcall on DT
Date: Thu,  1 Nov 2012 19:36:09 +0100
Message-ID: <1351794970-14675-4-git-send-email-zonque@gmail.com>
References: <1351794970-14675-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:55040 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762143Ab2KASgi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Nov 2012 14:36:38 -0400
In-Reply-To: <1351794970-14675-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, linux-omap@vger.kernel.org, jon-hunter@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, Daniel Mack <zonque@gmail.com>

On DT driven boards, the gpmc node will match the driver. Hence, there's
no need to do that unconditionally from the initcall.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 60f1cce..1dcb30c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -844,6 +844,13 @@ static int __init omap_gpmc_init(void)
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

