From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP3 : Enable TWL4030 Keypad for Zoom2 and Zoom3 boards
Date: Tue, 17 Nov 2009 21:53:46 +0530
Message-ID: <20091117162346.GA16240@DFL-61>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41366 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbZKQQWp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 11:22:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAHGMmhq006992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 10:22:50 -0600
Received: from localhost (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAHGMlF7002795
	for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 21:52:47 +0530 (IST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The TWL4030 keypad driver is not enabled by default for zoom2 and zoom3
boards.

This patch will enable the same for both zoom2 and zoom3 boards.

Tested on zoom2(3430) and zoom3(3630) boards.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/configs/omap_zoom2_defconfig |    3 ++-
 arch/arm/configs/omap_zoom3_defconfig |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index eef9362..4b00a43 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -610,7 +610,8 @@ CONFIG_INPUT_EVDEV=y
 #
 # Input Device Drivers
 #
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_TWL4030=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index f0e7d0f..0d7e37a 100644
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -629,7 +629,8 @@ CONFIG_INPUT_EVDEV=y
 #
 # Input Device Drivers
 #
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_TWL4030=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.6.0.4

