From: hvaibhav@ti.com
Subject: [PATCH 0/3] Introducing TouchScreen TSC2004 driver support
Date: Thu, 19 Nov 2009 20:15:43 +0530
Message-ID: <1258641943-2176-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

This is first version of TSC2004 driver support, which has been
validated on AM3517EVM platform. Driver is derived from existing
touchscreen driver TSC2007.

Vaibhav Hiremath (3):
  Mux configuration for AM3517 TouchScreen support
  Input:TouchScreen: Introduce TSC2004 driver support
  AM3517: Add support for TSC2004 driver

 arch/arm/mach-omap2/board-am3517evm.c |   62 ++++
 arch/arm/mach-omap2/mux.c             |    3 +
 arch/arm/plat-omap/include/plat/mux.h |    1 +
 drivers/input/touchscreen/Kconfig     |   11 +
 drivers/input/touchscreen/Makefile    |    1 +
 drivers/input/touchscreen/tsc2004.c   |  525 +++++++++++++++++++++++++++++++++
 include/linux/i2c/tsc2004.h           |   17 +
 7 files changed, 620 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc2004.c
 create mode 100644 include/linux/i2c/tsc2004.h

