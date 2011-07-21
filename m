From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHV2 0/5] I2C: driver updates
Date: Thu, 21 Jul 2011 16:39:09 +0530
Message-ID: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47352 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab1GULJ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 07:09:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

The series attempts to do the following
- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.
- Restore the context only if the context is lost.

version 2
 - Fix the indentation.
 - Restore in the error path is not needed as we are
   doing a init.

Tested on sdp4430 and on omap3430

Shubhrajyoti D (5):
  OMAP: I2C: Add a device reset field to platform data
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition
  OMAP: I2C: Restore only if context is lost

 arch/arm/plat-omap/i2c.c      |   17 +++++++
 drivers/i2c/busses/i2c-omap.c |  101 ++++++++++++++++-------------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 57 insertions(+), 62 deletions(-)

