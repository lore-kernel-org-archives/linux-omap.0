From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH V2 1/2] mcx: very basic support for HTKW mcx board
Date: Thu, 15 Dec 2011 01:53:02 +0100
Message-ID: <1323910383-1184-2-git-send-email-yanok@emcraft.com>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40164 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758432Ab1LOAxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 19:53:09 -0500
In-Reply-To: <1323910383-1184-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: yanok@emcraft.com, sasha_d@emcraft.com

Very basic support for HTKW mcx board. Able to boot via board-generic
and ramdisk/initramfs, however most of peripherals is unsupported.
Produces tons of twl4030 related errors as this board doesn't have
twl4030 installed.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>

---
Changes from V1:

 - device tree moved to the separate patch
 - iva node is disabled instead of using custom includes
 - removed bootargs entry

 arch/arm/boot/dts/mcx.dts |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/mcx.dts

diff --git a/arch/arm/boot/dts/mcx.dts b/arch/arm/boot/dts/mcx.dts
new file mode 100644
index 0000000..66b81bd
--- /dev/null
+++ b/arch/arm/boot/dts/mcx.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap3.dtsi"
+
+/ {
+	model = "HTKW mcx";
+	compatible = "htkw,mcx", "ti,omap3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	/* AM35xx doesn't have IVA */
+	soc {
+		iva {
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.6.4

