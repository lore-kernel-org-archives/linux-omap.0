From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] MTD: NAND: ams-delta: select for built-in by default
Date: Wed, 15 Dec 2010 12:58:15 +0100
Message-ID: <201012151258.16764.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47200 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839Ab0LOL7x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 06:59:53 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Now that the Amstrad Delta NAND driver is converted to a platform driver, 
which prevents it from interfering with other unrelated hardware in multiple 
OMAP1 cpu and machine configurations, it can be automatically configured for 
being built into the kernel if the Amstrad Delta board is also selected.

Created against linux-2.6.37-rc5.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 drivers/mtd/nand/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.37-rc5/drivers/mtd/nand/Kconfig.orig	2010-12-09 23:08:16.000000000 +0100
+++ linux-2.6.37-rc5/drivers/mtd/nand/Kconfig	2010-12-11 15:58:12.000000000 +0100
@@ -96,6 +96,7 @@ config MTD_NAND_SPIA
 config MTD_NAND_AMS_DELTA
 	tristate "NAND Flash device on Amstrad E3"
 	depends on MACH_AMS_DELTA
+	default y
 	help
 	  Support for NAND flash on Amstrad E3 (Delta).
 
