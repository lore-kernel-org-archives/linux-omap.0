From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ARM: omap1: add nand_chip declaration
Date: Wed, 26 Sep 2018 15:04:38 +0200
Message-ID: <20180926130458.2406549-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Recent MTD changes caused a minor build regression on OMAP1:

In file included from arch/arm/mach-omap1/devices.c:31:
arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 11b87a4c84d4..82f2c065040a 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -82,6 +82,7 @@ void omap1_restart(enum reboot_mode, const char *);
 
 extern void __init omap_check_revision(void);
 
+struct nand_chip;
 extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
 			       unsigned int ctrl);
 
-- 
2.18.0
