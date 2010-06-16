From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v4 0/4] OMAP4 Keyboard Controller Support
Date: Wed, 16 Jun 2010 11:08:05 -0500
Message-ID: <1276704485-30486-1-git-send-email-x0066660@ti.com>
References: <x0066660@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50999 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759206Ab0FPQIE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 12:08:04 -0400
In-Reply-To: <x0066660@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>

Keyboard controller for OMAP4 includes

 - built-in scanning algorithm
 - debouncing feature
 - handling mechanism up to 9 x 9 keys
 - wake-up event generation

Tested using SDP4430 board in Kevin Hillman's tree,
pm-wip/hwmods-omap4 branch

---

v1
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26502.html

v2
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28334.html

v3
 Dmitry.Torokhov | Rework in driver code
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg29297.html

v4
 Felipe.Balbi.01    | rows, cols, base and irq definitions
 Felipe.Balbi.02    | device_* calls
 Felipe.Balbi.03    | input device registration before irq enabling
 Felipe.Balbi.04    | kzalloc allocation never to be freed

 Tony.Lindgren.01   | test in omap2 and omap3
 Tony.Lindgren.02   | add cpu_is_omap44xx()

 Kevin.Hillman.01   | drop device_* calls
 Kevin.Hillman.01   | use runtime PM API

 Tomas.Petazzoni.01 | oh_name declaration

---

Abraham Arce (3):
  OMAP4: Keyboard controller support
  OMAP4: Keyboard device registration
  OMAP4: Keyboard board support

Syed Rafiuddin (1):
  OMAP4: Keyboard kernel configuration

 arch/arm/configs/omap_4430sdp_defconfig        |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c            |   99 ++++++++
 arch/arm/mach-omap2/devices.c                  |   50 ++++
 arch/arm/plat-omap/include/plat/omap4-keypad.h |   19 ++
 drivers/input/keyboard/Kconfig                 |   10 +
 drivers/input/keyboard/Makefile                |    1 +
 drivers/input/keyboard/omap4-keypad.c          |  288 ++++++++++++++++++++++++
 7 files changed, 469 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap4-keypad.h
 create mode 100644 drivers/input/keyboard/omap4-keypad.c

