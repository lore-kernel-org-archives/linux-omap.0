From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/4] OMAP3:PM: T2 keypad: Wakeup with support for OFF mode
Date: Mon,  9 Nov 2009 22:09:07 +0530
Message-ID: <1257784747-18059-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36088 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbZKIQjH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Nov 2009 11:39:07 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA9GdAYa012859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 10:39:12 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch series incrementally adds support for wake-up from
TWL4030 keypad when OFF mode is hot during suspend.

In the process, it extends existing driver to support board
specific implementation during suspend and resume operations.

The patch has been tested on OMAP3EVM and would be good to find
if it works on the 3430SDP as well.

TODO:
  The structire 'omap_keypad_pm_state' is being defined (and
  duplicated) in board specific files - board-omap3evm.c and
  board-3430sdp.c.

  This definition should ideally be in a header file, but
  matrix_keypad.h is not the right one. Also, plat/keypad.h
  is no longer used (inclusion results in warnings for duplicate
  definitions).
  
  Possible alternatives:
  - Cleanup plat/keypad.h - Not sure if it is being used by any
    other platform.
  - Create a new header file alongside the board files for TWL4030
    keypad. (Much of existing duplication also gets addressed).
  
  Either of these alternatives can be taken as a separate patch.
  OR, as follow-up to last 2 patches in this series. Thoughts?


Sanjeev Premi (4):
  OMAP3: PM: Add suspend-resume to TWL4030 keypad
  OMAP3: PM: T2 keypad: Add board specific suspend-resume functions
  OMAP3: PM: Wakeup from T2 keypad with OFF mode
  OMAP3: PM: Extend T2 wakeup support to 3430SDP

 arch/arm/mach-omap2/board-3430sdp.c     |   89 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c    |   89 +++++++++++++++++++++++++++++++
 drivers/input/keyboard/twl4030_keypad.c |   28 ++++++++++
 include/linux/i2c/twl4030.h             |   12 ++++
 4 files changed, 218 insertions(+), 0 deletions(-)

