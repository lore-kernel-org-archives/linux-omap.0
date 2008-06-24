From: Miguel Angel Aguilar Ulloa <miguel.aguilar@ridgerun.com>
Subject: [PATCH 3/3] OMAP3: EVM: KEYPAD: Add twl4030 keypad to defconfig
Date: Tue, 24 Jun 2008 07:59:58 -0600
Message-ID: <4860FDDE.1000905@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:38415 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460AbYFXN4N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2008 09:56:13 -0400
Received: from [200.122.155.113] (helo=[192.168.10.40])
	by mail.navvo.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <miguel.aguilar@ridgerun.com>)
	id 1KB8X8-0006jH-Nw
	for linux-omap@vger.kernel.org; Tue, 24 Jun 2008 08:26:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Enable twl4030 keypad driver in omap3_evm_defconfig

Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com>

--- a/arch/arm/configs/omap3_evm_defconfig    2008-06-11 08:32:45.000000000 -0600
+++ b/arch/arm/configs/omap3_evm_defconfig    2008-06-23 14:35:23.000000000 -0600
@@ -601,7 +601,16 @@ CONFIG_INPUT=y
#
# Input Device Drivers
#
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_KEYBOARD_TWL4030=m
+# CONFIG_KEYBOARD_LM8323 is not set
+# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
