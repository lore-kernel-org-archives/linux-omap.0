From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v3][PATCH 10/10] omap3: zoom2/3: Register only 1 8250 port
Date: Tue,  9 Mar 2010 10:16:54 -0600
Message-ID: <1268151414-17071-11-git-send-email-saaguirre@ti.com>
References: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46189 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab0CIQQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Mar 2010 11:16:09 -0500
In-Reply-To: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

There's no more serial ports available, so, doesn't make sense
to create 4 device nodes.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/configs/omap_zoom2_defconfig |    2 +-
 arch/arm/configs/omap_zoom3_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index a82e813..3dfd2d5 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -660,7 +660,7 @@ CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=32
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index ff8ac3d..a1c0c43 100644
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -680,7 +680,7 @@ CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=32
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-- 
1.6.3.3

