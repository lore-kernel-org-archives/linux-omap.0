From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] omap: delete unused bootloader tag variables
Date: Mon, 22 Mar 2010 19:28:19 +0200
Message-ID: <1269278899-16098-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28906 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab0CVRZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 13:25:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com

They are not needed and add over 512 bytes to kernel data.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/plat-omap/common.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 01cbb48..f12f0e3 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -44,9 +44,6 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-unsigned char omap_bootloader_tag[512];
-int omap_bootloader_tag_len;
-
 struct omap_board_config_kernel *omap_board_config;
 int omap_board_config_size;
 
-- 
1.5.6.5

