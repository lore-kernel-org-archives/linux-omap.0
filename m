From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/14] omap3 : Enable TWL4030 Keypad for Zoom2 and Zoom3 boards
Date: Fri, 11 Dec 2009 15:54:28 -0800
Message-ID: <20091211235428.3189.24306.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58811 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934038AbZLKXyW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:54:22 -0500
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Manjunatha GK <manjugk@ti.com>, linux-omap@vger.kernel.org

From: manjugk manjugk <manjugk@ti.com>

The TWL4030 keypad driver is not enabled by default for zoom2 and zoom3
boards.

This patch will enable the same for both zoom2 and zoom3 boards.

Tested on zoom2(3430) and zoom3(3630) boards.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

