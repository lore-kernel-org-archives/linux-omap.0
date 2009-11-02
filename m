From: manjugk@ti.com
Subject: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon,  2 Nov 2009 13:26:03 +0530
Message-ID: <1257148563-18604-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38692 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103AbZKBH4G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Nov 2009 02:56:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Manjunatha GK <manjugk@ti.com>

From: Manjunatha GK <manjugk@ti.com>


Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/configs/omap_zoom2_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index f1739fa..8ca835a 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -1350,7 +1350,7 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-- 
1.6.0.4

