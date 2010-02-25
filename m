From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH 0/3] Add support for TCA6416 based Keypad driver.
Date: Thu, 25 Feb 2010 18:44:58 +0530
Message-ID: <1267103701-23823-1-git-send-email-srk@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>
List-Id: linux-omap@vger.kernel.org

AM3517 EVM with APPS board includes keys interfaced to TCA6416 IO expander.
User keys are connected as GPIO lines to TCA6416 IO expander. Unlike the
case with generic gpio-keypad driver individual keys do not generate an
interrupt event. Hence we implement a simple keypad driver(based on gpio-keys)
that registers as direct I2C client.

The implementation has been tested on AM3517 EVM with the driver tested
in polling mode.

Sriramakrishnan (3):
  TCA6416 keypad : Implement keypad driver for keys interfaced to
    TCA6416
  AM3517 EVM : Enable TCA6416 keypad
  AM3517: Board hookup for TCA6416 keypad driver.

 arch/arm/configs/am3517_evm_defconfig   |   15 ++-
 arch/arm/mach-omap2/board-am3517evm.c   |   48 ++++-
 drivers/input/keyboard/Kconfig          |   17 ++
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/tca6416-keypad.c |  355 +++++++++++++++++++++++++++++++
 include/linux/tca6416_keypad.h          |   30 +++
 6 files changed, 460 insertions(+), 6 deletions(-)
 create mode 100755 drivers/input/keyboard/tca6416-keypad.c
 create mode 100755 include/linux/tca6416_keypad.h

