From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/13] ARM: OMAP: No need to include board-nokia.h from
	hardware.h
Date: Thu, 26 Feb 2009 16:07:40 -0800
Message-ID: <20090227000740.20192.91013.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60434 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbZB0AHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:07:44 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the associated board file and remove
the now unnecessary header file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/board-nokia.h |   54 -------------------------
 arch/arm/plat-omap/include/mach/board.h       |    3 -
 2 files changed, 0 insertions(+), 57 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-nokia.h

diff --git a/arch/arm/plat-omap/include/mach/board-nokia.h b/arch/arm/plat-omap/include/mach/board-nokia.h
deleted file mode 100644
index 2abbe00..0000000
--- a/arch/arm/plat-omap/include/mach/board-nokia.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/board-nokia.h
- *
- *  Information structures for Nokia-specific board config data
- *
- *  Copyright (C) 2005	Nokia Corporation
- */
-
-#ifndef _OMAP_BOARD_NOKIA_H
-#define _OMAP_BOARD_NOKIA_H
-
-#include <linux/types.h>
-
-#define OMAP_TAG_NOKIA_BT	0x4e01
-#define OMAP_TAG_WLAN_CX3110X	0x4e02
-#define OMAP_TAG_CBUS		0x4e03
-#define OMAP_TAG_EM_ASIC_BB5	0x4e04
-
-
-#define BT_CHIP_CSR		1
-#define BT_CHIP_TI		2
-
-#define BT_SYSCLK_12		1
-#define BT_SYSCLK_38_4		2
-
-struct omap_bluetooth_config {
-	u8    chip_type;
-	u8    bt_wakeup_gpio;
-	u8    host_wakeup_gpio;
-	u8    reset_gpio;
-	u8    bt_uart;
-	u8    bd_addr[6];
-	u8    bt_sysclk;
-};
-
-struct omap_wlan_cx3110x_config {
-	u8  chip_type;
-	s16 power_gpio;
-	s16 irq_gpio;
-	s16 spi_cs_gpio;
-};
-
-struct omap_cbus_config {
-	s16 clk_gpio;
-	s16 dat_gpio;
-	s16 sel_gpio;
-};
-
-struct omap_em_asic_bb5_config {
-	s16 retu_irq_gpio;
-	s16 tahvo_irq_gpio;
-};
-
-#endif
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 9466772..4a0afd2 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -133,9 +133,6 @@ struct omap_version_config {
 	char version[12];
 };
 
-
-#include <mach/board-nokia.h>
-
 struct omap_board_config_entry {
 	u16 tag;
 	u16 len;

