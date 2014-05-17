From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 0/2] remove unused omap4-keypad files and pdata support
Date: Sat, 17 May 2014 23:24:09 +0200
Message-ID: <1400361851-32274-1-git-send-email-manabian@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: illia.smyrnov@ti.com, dmitry.torokhov@gmail.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This patch removes unused omap4-keypad init functions from mach-omap2
and makes the driver DT only. Board files for omap4 are long gone and
this has been unused since.

Note: This has only been compile tested!

Joachim Eastwood (2):
  ARM: OMAP2+: remove unused omap4-keypad file and code
  Input: omap-keypad - remove platform data support

 arch/arm/mach-omap2/devices.c              | 33 ------------------------------
 arch/arm/mach-omap2/omap4-keypad.h         |  8 --------
 drivers/input/keyboard/Kconfig             |  2 +-
 drivers/input/keyboard/omap4-keypad.c      | 31 ++++++----------------------
 include/linux/platform_data/omap4-keypad.h | 13 ------------
 5 files changed, 7 insertions(+), 80 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap4-keypad.h
 delete mode 100644 include/linux/platform_data/omap4-keypad.h

-- 
1.8.0

