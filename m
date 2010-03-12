From: Sriramakrishnan <srk@ti.com>
Subject: [PATCHv2 3/3] AM3517 EVM : Enable TCA6416 keypad.
Date: Fri, 12 Mar 2010 14:48:19 +0530
Message-ID: <1268385499-7075-4-git-send-email-srk@ti.com>
References: <1268385499-7075-1-git-send-email-srk@ti.com>
 <1268385499-7075-2-git-send-email-srk@ti.com>
 <1268385499-7075-3-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50415 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab0CLJSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 04:18:25 -0500
In-Reply-To: <1268385499-7075-3-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>

Update kernel configuration for AM3517EVM to include
support for TCA6416 keypad.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index 66a10b5..93d5fdf 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -527,6 +527,7 @@ CONFIG_SCSI_LOWLEVEL=y
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
 # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -539,7 +540,20 @@ CONFIG_INPUT_EVDEV=y
 #
 # Input Device Drivers
 #
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_GPIO is not set
+CONFIG_KEYBOARD_TCA6416=y
+# CONFIG_KEYBOARD_MATRIX is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.6.2.4

