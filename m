From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [PATCH 3/3] OMAP3: EVM: KEYPAD: Add twl4030 keypad to defconfig
Date: Wed, 25 Jun 2008 14:20:30 -0600
Message-ID: <4862A88E.30700@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:59285 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbYFYUQj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 16:16:39 -0400
Received: from [200.122.155.113] (helo=[192.168.10.40])
	by mail.navvo.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <miguel.aguilar@ridgerun.com>)
	id 1KBawq-0003vO-O9
	for linux-omap@vger.kernel.org; Wed, 25 Jun 2008 14:46:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Enable twl4030 keypad driver in omap3_evm_defconfig

Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com> 
---
 arch/arm/configs/omap3_evm_defconfig           |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/reference_kernel/arch/arm/configs/omap3_evm_defconfig b/linux-2.6.26/arch/arm/configs/omap3_evm_defconfig
index 43ae0c8..718c914 100644
--- a/reference_kernel/arch/arm/configs/omap3_evm_defconfig
+++ b/linux-2.6.26/arch/arm/configs/omap3_evm_defconfig
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
