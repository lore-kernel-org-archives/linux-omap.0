From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH v2 6/6] OMAP_LDP: Add keypad related configs into defconfig.
Date: Tue, 11 Nov 2008 19:50:58 +0800
Message-ID: <1226404258-13027-7-git-send-email-stanley.miao@windriver.com>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-2-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-3-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-4-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-5-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-6-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63325 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432AbYKKLpf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 06:45:35 -0500
In-Reply-To: <1226404258-13027-6-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: johnpol@2ka.mipt.ru

Add keypad related configs into omap_ldp_defconfig.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/configs/omap_ldp_defconfig |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index add0b71..d88e6d7 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -549,7 +549,16 @@ CONFIG_INPUT_EVDEV=y
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
+CONFIG_KEYBOARD_TWL4030=y
+# CONFIG_KEYBOARD_LM8323 is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.5.6.3

