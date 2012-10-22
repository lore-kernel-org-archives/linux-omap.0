From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/4] ARM: OMAP: gpmc: don't create devices from initcall on DT
Date: Mon, 22 Oct 2012 21:55:57 +0200
Message-ID: <1350935758-9215-4-git-send-email-zonque@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:40382 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab2JVT42 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 15:56:28 -0400
In-Reply-To: <1350935758-9215-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, Daniel Mack <zonque@gmail.com>

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

