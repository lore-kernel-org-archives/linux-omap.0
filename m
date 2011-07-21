From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 0/5] I2C: driver updates
Date: Thu, 21 Jul 2011 12:23:00 +0530
Message-ID: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43095 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab1GUGxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 02:53:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

The series attempts to do the following
- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.
- Restore the context only if the context is lost.

Shubhrajyoti D (5):
  OMAP: I2C: Add a device reset field to platform data
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition
  OMAP: I2C: Restore only if context is lost

 arch/arm/plat-omap/i2c.c      |   18 ++++++++
 drivers/i2c/busses/i2c-omap.c |   90 ++++++++++++++++------------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 55 insertions(+), 54 deletions(-)

