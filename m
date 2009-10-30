From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH 3/3] ARM OMAP3: rx51_defconfig: enable support for gpio keys
Date: Fri, 30 Oct 2009 15:38:28 +0200
Message-ID: <93e74e7b4be2dcdbc489c0c92987fc36ef0db447.1256907278.git.ext-jani.1.nikula@nokia.com>
References: <20091027162040.GB22541@core.coreip.homeip.net>
 <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
 <48e6c73d2c8e67e1d2eec68556e7885f6d10c203.1256907278.git.ext-jani.1.nikula@nokia.com>
 <859ce18ccdcfac80d2fafa73b6aef2fa5fd6feb6.1256907278.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61668 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221AbZJ3Nil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 09:38:41 -0400
In-Reply-To: <859ce18ccdcfac80d2fafa73b6aef2fa5fd6feb6.1256907278.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dmitry.torokhov@gmail.com
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Compile gpio_keys driver a module.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 arch/arm/configs/rx51_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index e7e3133..1559734 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -784,7 +784,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-# CONFIG_KEYBOARD_GPIO is not set
+CONFIG_KEYBOARD_GPIO=m
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.6.5.2

