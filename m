From: "Anna, Suman" <s-anna@ti.com>
Subject: [RESEND] [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
Date: Mon, 22 Feb 2010 17:41:28 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640F2C540@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162Ab0BVXlc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 18:41:32 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

>From 657358cd06a3f20bef2472945991749bacef12e6 Mon Sep 17 00:00:00 2001
From: Suman Anna <s-anna@ti.com>
Date: Mon, 25 Jan 2010 18:27:21 -0600
Subject: [PATCH] omap2/3/4: mailbox: remove compiler warning

Remove a compiler warning in device-specific
mailbox module.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 2c9fd1c..8b5fc2a 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -419,8 +419,11 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 #endif
 	return 0;
 
+#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 err_iva1:
-	omap_mbox_unregister(&mbox_dsp_info);
+	if (cpu_is_omap2420())
+		omap_mbox_unregister(&mbox_dsp_info);
+#endif
 
 err_dsp:
 	iounmap(mbox_base);
-- 
1.6.6.2
