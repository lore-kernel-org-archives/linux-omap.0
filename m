From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/2] Resend TWl4030 MADC driver
Date: Mon,  7 Apr 2008 14:55:14 +0300
Message-ID: <1207569316-7053-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42263 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758246AbYDGL4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 07:56:47 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m37BuVeH016053
	for <linux-omap@vger.kernel.org>; Mon, 7 Apr 2008 14:56:44 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Updated help text on Kconfig clarifying that MADC stands to
Monitoring Analog-Digital Converter.

Mikko Ylinen (2):
  I2C: TWL4030: Introduce twl4030 madc driver
  I2C: TWL4030: Kconfig and Makefile changes

 drivers/i2c/chips/Kconfig        |   21 ++
 drivers/i2c/chips/Makefile       |    1 +
 drivers/i2c/chips/twl4030-madc.c |  453 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h |  134 +++++++++++
 4 files changed, 609 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/twl4030-madc.c
 create mode 100644 include/linux/i2c/twl4030-madc.h

