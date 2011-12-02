From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 0/3] I2C driver updates
Date: Fri, 2 Dec 2011 14:51:11 +0530
Message-ID: <1322817674-25384-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53074 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab1LBJVo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Dec 2011 04:21:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, ben-linux@fluff.org, Shubhrajyoti D <shubhrajyoti@ti.com>

The series attempts to do the following

- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.


Incorporated review comments:

 - Fix the indentation.
 - Restore in the error path is not needed as we are
   doing a init.
 - Combine the patch 1 and 2 as i2c-omap.h isn't a generic header
 - Making the changelogs more descriptive.
 
This is rebased on Kevin's tree  for_3.2/fixes/i2c branch.


Acknowledge Balaji ,Santosh and Kevin for the review comments.


Shubhrajyoti D (3):
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition

 arch/arm/plat-omap/i2c.c      |   18 ++++++++
 drivers/i2c/busses/i2c-omap.c |   87 ++++++++++------------------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 41 insertions(+), 65 deletions(-)

