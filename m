From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHV4 0/4] I2C: driver updates
Date: Thu, 21 Jul 2011 20:53:34 +0530
Message-ID: <1311261818-25784-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39274 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab1GUPX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 11:23:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com, santosh.shilimkar@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

The series attempts to do the following

- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.
- Restore the context only if the context is lost.

version 2
 - Fix the indentation.
 - Restore in the error path is not needed as we are
   doing a init.

version 3
 - Combine the patch 1 and 2 as i2c-omap.h isn't a generic header

version 4
 - Adding the description of patch 2.	

Acknowledge Balaji and Santosh for the review comments.
Tested on sdp4430 and on omap3430

Shubhrajyoti D (4):
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition
  OMAP: I2C: I2C register restore only if context is lost

 arch/arm/plat-omap/i2c.c      |   17 +++++++
 drivers/i2c/busses/i2c-omap.c |  101 ++++++++++++++++-------------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 57 insertions(+), 62 deletions(-)

