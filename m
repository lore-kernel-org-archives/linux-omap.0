From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH v2 4/4] OMAP4: Keyboard kernel configuration
Date: Thu, 13 May 2010 15:51:06 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E113BFE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758671Ab0EMUvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 16:51:08 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Update OMAP4430 configuration to enable OMAP4 keyboard driver

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index d87a349..b7928d4 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -439,7 +439,8 @@ CONFIG_INPUT_EVDEV=y
 #
 # Input Device Drivers
 #
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_OMAP4=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.5.4.3

