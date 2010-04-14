From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH 3/3] OMAP4: Keyboard Kernel Configuration
Date: Tue, 13 Apr 2010 20:11:07 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Update OMAP4430 default configuration to add OMAP4 keyboard driver

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index a52094f..e9d804a 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -443,7 +443,8 @@ CONFIG_INPUT_EVDEV=y
 #
 CONFIG_INPUT_KEYBOARD=y
 CONFIG_KEYBOARD_ATKBD=y
-CONFIG_KEYBOARD_OMAP=y
+# CONFIG_KEYBOARD_OMAP is not set
+CONFIG_KEYBOARD_OMAP4=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.5.4.3

