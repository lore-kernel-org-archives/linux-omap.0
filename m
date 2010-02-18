From: "Anna, Suman" <s-anna@ti.com>
Subject: [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
Date: Thu, 18 Feb 2010 15:07:19 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640D0235B@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45700 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab0BRVHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:07:25 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

>From 78d00b562548e1d95ad12a4d8121be67950daf68 Mon Sep 17 00:00:00 2001
From: Suman Anna <s-anna@ti.com>
Date: Mon, 25 Jan 2010 18:27:21 -0600
Subject: [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning

Remove a compiler warning in device-specific
mailbox module.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 2c9fd1c..c970cf6 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -419,8 +419,10 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 #endif
 	return 0;
 
+#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 err_iva1:
 	omap_mbox_unregister(&mbox_dsp_info);
+#endif
 
 err_dsp:
 	iounmap(mbox_base);
-- 
1.6.6.2

