From: Sriramakrishnan <srk@ti.com>
Subject: [PATCHv2 0/3] Add support for TCA6416 based Keypad driver.
Date: Fri, 12 Mar 2010 14:48:16 +0530
Message-ID: <1268385499-7075-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34300 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757081Ab0CLJSZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 04:18:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>

AM3517 EVM with APPS board includes keys interfaced to TCA6416 IO expander
User keys are connected as GPIO lines to TCA6416 IO expander. Unlike the
case with generic gpio-keypad driver individual keys do not generate an
interrupt event. Hence we implement a simple keypad driver, that
registers as direct I2C client.

The implementation has been tested on AM3517 EVM with the driver tested
in polling mode.

Version2 of the patch series addresses review comments from the earlier
posting - specifically redesigned to eliminate overhead of using gpio_keys
data structures.

Sriramakrishnan (3):
  TCA6416 keypad : Implement keypad driver for keys interfaced to
    TCA6416
  AM3517: Board hookup for TCA6416 keypad driver.
  AM3517 EVM : Enable TCA6416 keypad.

 arch/arm/configs/am3517_evm_defconfig   |   16 ++-
 arch/arm/mach-omap2/board-am3517evm.c   |   47 ++++-
 drivers/input/keyboard/Kconfig          |   16 ++
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/tca6416-keypad.c |  354 +++++++++++++++++++++++++++++++
 include/linux/tca6416_keypad.h          |   34 +++
 6 files changed, 462 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/board-am3517evm.c
 create mode 100755 drivers/input/keyboard/tca6416-keypad.c
 create mode 100755 include/linux/tca6416_keypad.h

