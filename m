From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/3] twl4030: keypad: Support for suspend-resume
Date: Thu,  4 Feb 2010 21:36:29 +0530
Message-ID: <1265299589-29998-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57171 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758122Ab0BDQGf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 11:06:35 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o14G6V4C001297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Feb 2010 10:06:34 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This set adds suspend-resume functionality to the TWL4030
keypad driver. It also adds the capability to wakeup from
the OFF mode.

These 2 patches don't depend upon the code in pm branch. And
have been tested on linux-omap/master (c6348aa):
  twl4030: keypad: Add suspend-resume functions
  twl4030: keypad: Hooks for board specific suspend-resume

The complete set has been tested on linux-omap/pm (c6348aa).

All testing done on OMAP3EVM.

Sanjeev Premi (3):
  twl4030: keypad: Add suspend-resume functions
  twl4030: keypad: Hooks for board specific suspend-resume
  OMAP3: PM: Wakeup from TWL4030 keypad with OFF mode

 arch/arm/mach-omap2/board-omap3evm.c    |   86 +++++++++++++++++++++++++++++++
 drivers/input/keyboard/twl4030_keypad.c |   28 ++++++++++
 include/linux/i2c/twl.h                 |   12 ++++
 3 files changed, 126 insertions(+), 0 deletions(-)
