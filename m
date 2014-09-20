From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v4 5/5] mtd: nand: Constrain omap_elm to built-in
Date: Sat, 20 Sep 2014 17:53:16 +0100
Message-ID: <1411231996-6387-6-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:56450 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbaITQyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2014 12:54:41 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so1045886wes.26
        for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2014 09:54:40 -0700 (PDT)
In-Reply-To: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

This fixes the following build error when omap2_nand is chosen built-in,
and omap_elm is chosen as a module:

  drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
  drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
  drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
  drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bch_error_page'

Fix this by making omap_elm a 'bool' driver.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index f1cf503..549c0cb 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -96,7 +96,7 @@ config MTD_NAND_OMAP2
 
 config MTD_NAND_OMAP_BCH
 	depends on MTD_NAND_OMAP2
-	tristate "Support hardware based BCH error correction"
+	bool "Support hardware based BCH error correction"
 	default n
 	select BCH
 	help
-- 
2.1.0

