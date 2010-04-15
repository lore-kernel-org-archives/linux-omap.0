From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v3 5/5(7)] OMAP1: Amstrad Delta: modify defconfig for external keyboard support
Date: Thu, 15 Apr 2010 04:32:32 +0200
Message-ID: <201004150432.35559.jkrzyszt@tis.icnet.pl>
References: <201004150419.05038.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <201004150419.05038.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, e3-hacking@earth.li
List-Id: linux-omap@vger.kernel.org

The patch adds a CONFIG directive required for supporting the Amstrad Delta
connected external keyboard by default.

Created and tested against linux-2.6.34-rc2.
Works on top of PATCH 4/5(7), "input: serio: add support for Amstrad Delta 
serial keyboard port".

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v2 changes:
- no functional changes,
- refreshed against linux-2.6.34-rc2.
v3 changes:
- since CONFIG_KEYBOARD_ATKBD and CONFIG_AMS_DELTA_FIQ are now selected 
  automatically, limit defconfig changes to CONFIG_SERIO_AMS_DELTA selection

 arch/arm/configs/ams_delta_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- git.orig/arch/arm/configs/ams_delta_defconfig	2010-04-14 03:11:50.000000000 +0200
+++ git/arch/arm/configs/ams_delta_defconfig	2010-04-15 03:29:05.000000000 +0200
@@ -699,6 +699,7 @@ CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
+CONFIG_SERIO_AMS_DELTA=y
 # CONFIG_GAMEPORT is not set
 
 #
