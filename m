From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 4/8] AI TB: Driver for Always Innovating OMAP3-based Touch
 Book keyboard
Date: Wed, 18 Nov 2009 18:57:49 -0800
Message-ID: <1258599469.8001.35.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
	 <1258345850.9089.21.camel@gregoire-laptop>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-z66cAISFxWfZelgVeFhI"
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1258345850.9089.21.camel@gregoire-laptop>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>
List-Id: linux-omap@vger.kernel.org


--=-z66cAISFxWfZelgVeFhI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

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
+ tristate "Always Innovating" if EMBEDDED
+ depends on USB_HID
+ default !EMBEDDED
+ ---help---
+ Support for Always Innovating Touch Book.
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

obj-$(CONFIG_HID_A4TECH) += hid-a4tech.o
+obj-$(CONFIG_HID_ALWAYSINNOVATING) += hid-alwaysinnovating.o
obj-$(CONFIG_HID_APPLE) += hid-apple.o
obj-$(CONFIG_HID_BELKIN) += hid-belkin.o
obj-$(CONFIG_HID_CHERRY) += hid-cherry.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7d05c4b..2bb62c3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1252,6 +1252,7 @@ EXPORT_SYMBOL_GPL(hid_disconnect);
static const struct hid_device_id hid_blacklist[] = {
{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU) },
{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_X5_005D) },
+ { HID_USB_DEVICE(USB_VENDOR_ID_ALWAYSINNOVATING,
USB_DEVICE_ID_ALWAYSINNOVATING_TOUCH_BOOK) },
{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index adbef5d..ebf53f7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -54,6 +54,9 @@
#define USB_VENDOR_ID_ALPS 0x0433
#define USB_DEVICE_ID_IBM_GAMEPAD 0x1101

+#define USB_VENDOR_ID_ALWAYSINNOVATING 0xa110
+#define USB_DEVICE_ID_ALWAYSINNOVATING_TOUCH_BOOK 0x0002
+
#define USB_VENDOR_ID_APPLE 0x05ac
#define USB_DEVICE_ID_APPLE_MIGHTYMOUSE 0x0304
#define USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI 0x020e
-- 
1.6.0.4



--=-z66cAISFxWfZelgVeFhI
Content-Disposition: attachment; filename="0004-Driver-for-Always-Innovating-OMAP3-based-Touch-Bo.patch"
Content-Type: text/x-patch; name="0004-Driver-for-Always-Innovating-OMAP3-based-Touch-Bo.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 0eaf7bd7a3ece14751708728ebcb25dab588c172 Mon Sep 17 00:00:00 2001
From: Gregoire Gentil <gregoire@gentil.com>
Date: Wed, 18 Nov 2009 18:32:15 -0800
Subject: [PATCH] Driver for Always Innovating OMAP3-based Touch Book keyboard


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


--=-z66cAISFxWfZelgVeFhI
Content-Disposition: attachment; filename*0=0004-Driver-for-Always-Innovating-OMAP3-based-Touch-Bo.patch.; filename*1=zip
Content-Type: application/zip; name="0004-Driver-for-Always-Innovating-OMAP3-based-Touch-Bo.patch.zip"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIADaVcjthXWw6EgQAAFMKAAA8ABUAMDAwNC1Ecml2ZXItZm9yLUFsd2F5cy1Jbm5v
dmF0aW5nLU9NQVAzLWJhc2VkLVRvdWNoLUJvLnBhdGNoVVQJAANnsARLc7AES1V4BADoA+gDpVZr
b+I4FP2Mf8Xd2f1QRJM6L6Dszmp4BBoVSAShD41GURI74ClNUBI6U033v68dWB4FupUagUmuzz2+
9jl26KbJI2DqR7WA1HyNhlTRa4ZSw/WaWqdBGKgG8QOjXg+VmgqDJIYxXYBSA4wbxQdUjBXU5TQN
6KV0mrCUQo/GOZvDX9N14Mu0CMhh8vg36vg5bcAtJeeg1GGYPAmKS37f0NSGYoCE6xij8TL4TsO8
AV+dptu++gadlD3RFKIkheb8h/+cgRXHyZOfs3gK9qDpaFLgZ5SAmyzDGbSS5AEe6HOQ+ClBCI3Z
NKZESqJICp7fW6okSQhIMXB2MWPk4jpM4ohNgV8voqlBZXXtwwb+A43YnP4HU+AVgH+lMEmpHL4B
YCSTZ2sGDYpBdBC0GYQzP54WK6gCizOa5iyJs7NK+RwwEDqnq2epjBBhUQSSNGU5+BfH5hIciyIW
E/oTVJ1ccnfIcmBUCQkNUDCu6rpYmONsiJd5gvHLF5Cq6nkVKrxVNODP6wqurI7X1F2zfYWgxKln
dL4olr40Xi4WSZqvVNchp1zZOwP8mMCt7UiaARfgpsssB93AfXhkIZURoMoucf+2eT+2hkP7pula
wx6qlPKUZTl3IXw6cNInYBGYg5bZ6ZgdDiV0QWOSATf+ZNzyOGERjPzlPIffdoA7ZVf2yz4w69ag
MuKa7tbqOH2TT3unwMViTveLgt2iztZVwcsLtFxx55RPS77xZXA0vBYdE6qSKOKiV321XsWnRd8k
Hqq+6RKyq1jIztuaUJ1FfAGhbQ+7Vs/r2z1rNBm0+qbT7Khet4uAz41FXEVIgu/SH2dr4NYk5VLl
M4gN4uvCEHKCKofIV6pvcwo52EYNnn1kHKFDubTJESIcBbbM/rU13JAHdP7A4qPI9pU5Gt1vkOGM
pukzR57UaueICE50rPWqEWyEeiDLahBU1VA7rddO6qFiO51CM0U1is1a/Ba6mXeOPXK98f2gZfe9
ntM/4ykeYRl3cMzP6vKfCIRtWSg8zfdklqfLMIcCRZ/43vQYKZ6CuR8+zLnHv36Dz/CLW/pX4X9h
5o55Y7XNwtc35rBjj7yN8OewBWyj3m3b0VRnUoZ/zj/IdGd4GBudgqnyv0yvLHbA+arfc+0JH6Nl
29fvLFW48IBVBL2me+NZI24vd2T3P8y2YdI/TDWwelfu/cCejM2C6017r15why4s4mtz+ySgkUFk
mQaRoUW1t829yjzu7VWfsLahC2Pz9pLbGsHv/DhiMYXX8jrjUgn/xLqm7WO2c7ZaA6/XHIijiyMV
hf8T4i+fU3z7dhDcPk/Zx7/LPqIqjFXx8jgxltCiKN7ww1PFHwgm8BrW38Z37cnQbVpDrzkcWyJD
xZSLAUiRqzKWdYT+BVBLAQIXAxQAAAAIADaVcjthXWw6EgQAAFMKAAA8AA0AAAAAAAEAAACkgQAA
AAAwMDA0LURyaXZlci1mb3ItQWx3YXlzLUlubm92YXRpbmctT01BUDMtYmFzZWQtVG91Y2gtQm8u
cGF0Y2hVVAUAA2ewBEtVeAAAUEsFBgAAAAABAAEAdwAAAIEEAAAAAA==


--=-z66cAISFxWfZelgVeFhI--

