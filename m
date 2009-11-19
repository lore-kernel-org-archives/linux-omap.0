From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 4/8] Driver for Always Innovating OMAP3-based Touch Book keyboard
Date: Thu, 19 Nov 2009 09:18:07 -0800
Message-ID: <1258651091-31727-5-git-send-email-gregoire@gentil.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
 <1258651091-31727-4-git-send-email-gregoire@gentil.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1258651091-31727-4-git-send-email-gregoire@gentil.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Gregoire Gentil <gregoire@gentil.com>, Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
 drivers/hid/Kconfig    |    7 +++++++
 drivers/hid/Makefile   |    1 +
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-ids.h  |    3 +++
 4 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 24d90ea..b56ddc5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -62,6 +62,13 @@ config HID_A4TECH
 	---help---
 	Support for A4 tech X5 and WOP-35 / Trust 450L mice.
 
+config HID_ALWAYSINNOVATING
+	tristate "Always Innovating" if EMBEDDED
+	depends on USB_HID
+	default !EMBEDDED
+	---help---
+	Support for Always Innovating Touch Book.
+
 config HID_APPLE
 	tristate "Apple" if EMBEDDED
 	depends on (USB_HID || BT_HIDP)
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 0de2dff..b6a2860 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -20,6 +20,7 @@ ifdef CONFIG_LOGIRUMBLEPAD2_FF
 endif
 
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
+obj-$(CONFIG_HID_ALWAYSINNOVATING)	+= hid-alwaysinnovating.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7d05c4b..2bb62c3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1252,6 +1252,7 @@ EXPORT_SYMBOL_GPL(hid_disconnect);
 static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_X5_005D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ALWAYSINNOVATING, USB_DEVICE_ID_ALWAYSINNOVATING_TOUCH_BOOK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index adbef5d..ebf53f7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -54,6 +54,9 @@
 #define USB_VENDOR_ID_ALPS		0x0433
 #define USB_DEVICE_ID_IBM_GAMEPAD	0x1101
 
+#define USB_VENDOR_ID_ALWAYSINNOVATING		0xa110
+#define USB_DEVICE_ID_ALWAYSINNOVATING_TOUCH_BOOK	0x0002
+
 #define USB_VENDOR_ID_APPLE		0x05ac
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI	0x020e
-- 
1.6.0.4

