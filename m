From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: zoom3: Update defconfig for USB
Date: Thu, 12 Nov 2009 12:57:44 +0530
Message-ID: <1258010864-30133-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50840 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbZKLH1n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Nov 2009 02:27:43 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAC7RkZ8022511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 01:27:48 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

omap: zoom3: Update defconfig for USB

- Enable CONFIG_USB_DEVICEFS
  - Temporary until usbtest is fixed
- Disable deprecated CONFIG_USB_DEVICE_CLASS
- Disable some unnecessary debug messages
- Modularize gadget drivers, and enable more of them
  - So we can switch gadgets on the fly.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
---
The same set of changes apply for zoom3 as well.

 arch/arm/configs/omap_zoom3_defconfig |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

Index: linux-omap-2.6/arch/arm/configs/omap_zoom3_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_zoom3_defconfig
+++ linux-omap-2.6/arch/arm/configs/omap_zoom3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32-rc5
-# Tue Nov  3 09:50:40 2009
+# Linux kernel version: 2.6.32-rc6
+# Thu Nov 12 12:39:26 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -232,6 +232,7 @@ CONFIG_ARCH_OMAP3430=y
 # CONFIG_MACH_OMAP_ZOOM2 is not set
 # CONFIG_MACH_CM_T35 is not set
 CONFIG_MACH_OMAP_ZOOM3=y
+# CONFIG_MACH_OMAP_3630SDP is not set
 
 #
 # Processor Type
@@ -903,6 +904,8 @@ CONFIG_DUMMY_CONSOLE=y
 CONFIG_SOUND=y
 # CONFIG_SOUND_OSS_CORE is not set
 CONFIG_SND=y
+CONFIG_SND_TIMER=m
+CONFIG_SND_PCM=m
 # CONFIG_SND_SEQUENCER is not set
 # CONFIG_SND_MIXER_OSS is not set
 # CONFIG_SND_PCM_OSS is not set
@@ -980,8 +983,8 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 #
 # Miscellaneous USB options
 #
-# CONFIG_USB_DEVICEFS is not set
-CONFIG_USB_DEVICE_CLASS=y
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_OTG=y
@@ -1036,7 +1039,7 @@ CONFIG_USB_MUSB_DEBUG=y
 # also be needed; see USB_STORAGE Help for more info
 #
 CONFIG_USB_STORAGE=y
-CONFIG_USB_STORAGE_DEBUG=y
+# CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
 # CONFIG_USB_STORAGE_ISD200 is not set
@@ -1082,10 +1085,10 @@ CONFIG_USB_STORAGE_DEBUG=y
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
-# CONFIG_USB_TEST is not set
+CONFIG_USB_TEST=m
 # CONFIG_USB_ISIGHTFW is not set
 # CONFIG_USB_VST is not set
-CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_VBUS_DRAW=2
@@ -1110,16 +1113,19 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_LANGWELL is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 CONFIG_USB_GADGET_DUALSPEED=y
-CONFIG_USB_ZERO=y
+CONFIG_USB_ZERO=m
 # CONFIG_USB_ZERO_HNPTEST is not set
-# CONFIG_USB_AUDIO is not set
-# CONFIG_USB_ETH is not set
-# CONFIG_USB_GADGETFS is not set
-# CONFIG_USB_FILE_STORAGE is not set
-# CONFIG_USB_G_SERIAL is not set
+CONFIG_USB_AUDIO=m
+CONFIG_USB_ETH=m
+CONFIG_USB_ETH_RNDIS=y
+# CONFIG_USB_ETH_EEM is not set
+CONFIG_USB_GADGETFS=m
+CONFIG_USB_FILE_STORAGE=m
+# CONFIG_USB_FILE_STORAGE_TEST is not set
+CONFIG_USB_G_SERIAL=m
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
-# CONFIG_USB_CDC_COMPOSITE is not set
+CONFIG_USB_CDC_COMPOSITE=m
 
 #
 # OTG and related infrastructure
