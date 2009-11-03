From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/2] omap3evm: Enable keypad in defconfig
Date: Tue,  3 Nov 2009 18:59:09 +0530
Message-ID: <1257254949-22471-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48254 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbZKCN3I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Nov 2009 08:29:08 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3DTAKA018620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 07:29:12 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Enable the TWL4030/TPS65590 keypad in the
default configuration.

Also updated the section with related config
options in .config for easy diff.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/configs/omap3_evm_defconfig |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index d5ff477..24d8b08 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -676,13 +676,19 @@ CONFIG_INPUT_EVDEV=y
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_KEYBOARD_MATRIX is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+CONFIG_KEYBOARD_TWL4030=y
+# CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.6.2.2

