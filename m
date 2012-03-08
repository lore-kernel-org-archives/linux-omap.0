From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv2 00/13] I2C updates
Date: Thu, 8 Mar 2012 18:47:52 +0530
Message-ID: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41262 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631Ab2CHNS5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 08:18:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

The patch series does the following 

- Warn fixes if CONFIG_PM_RUNTIME is not selected.
- I2C register restore only if context if the context is lost
- Bus busy recovery mechanism.
- the reset is not done in init.

v2 changes
-Adds a patch to use devm_* functions
-Also checks the return type of the get_sync and in case
 of errors prevents register access. 
- In case of i2c remove register access was done without any
 get_sync fix the same.
- Adds a pdata function pointer to do context save restore
 
Tested on omap4sdp and omap3sdp. 

Also available through 

git://gitorious.org/linus-tree/linus-tree.git for_3.4_i2c_fixes


Jon Hunter (1):
  I2C: OMAP: Correct I2C revision for OMAP3

Shubhrajyoti D (11):
  I2C : OMAP : make omap_i2c_unidle/idle functions depend on
    CONFIG_PM_RUNTIME
  OMAP : I2C : Remove reset at init
  OMAP: I2C: I2C register restore only if context is lost
  OMAP: I2C: Fix the interrupt clearing in OMAP4
  OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
  OMAP: I2C: Optimise the remove code
  OMAP: I2C: Fix the error handling
  I2C: OMAP: Don't check if wait_for_completion_timeout() returns less
    than zero
  OMAP : I2C : use devm_* functions
  I2C : OMAP : Fix the crash in i2c remove
  OMAP: I2C: Handle error check for pm runtime

Vikram Pandita (1):
  I2C: OMAP: Recover from Bus Busy condition

