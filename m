From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/4] i2c drivers fixes
Date: Tue, 13 May 2008 15:22:06 +0300
Message-ID: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41383 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYEMMXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:23:13 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCMleL012502
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:23:10 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Basically add i2c_device_id and fix some warnings.

Felipe Balbi (4):
  I2C: TSL2563: Add i2c_device_id
  I2C: LP5521: Add i2c_device_id
  I2C: RADIO: TEA5761: Add i2c_device_id
  I2C: Get rid of warnings

 drivers/i2c/chips/lp5521.c          |   11 +++++++++--
 drivers/i2c/chips/tsl2563.c         |   11 +++++++++--
 drivers/input/keyboard/lm8323.c     |    2 +-
 drivers/media/radio/radio-tea5761.c |   11 +++++++++--
 4 files changed, 28 insertions(+), 7 deletions(-)

