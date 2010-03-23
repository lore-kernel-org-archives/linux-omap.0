From: Sriramakrishnan <srk@ti.com>
Subject: [PATCHv3 0/3] Add support for TCA6416 based Keypad driver.
Date: Tue, 23 Mar 2010 20:40:32 +0530
Message-ID: <1269357035-19754-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33858 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359Ab0CWPKl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 11:10:41 -0400
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

Version3 is refreshed against the tip of linux-omap and 
file mode issues from the previous version is fixed.

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
 create mode 100644 drivers/input/keyboard/tca6416-keypad.c
 create mode 100644 include/linux/tca6416_keypad.h

