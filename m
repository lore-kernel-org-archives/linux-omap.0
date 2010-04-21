From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/1] i2c PM change for omap-testing
Date: Wed, 21 Apr 2010 12:04:13 -0700
Message-ID: <1271876654-13613-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64358 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab0DUTJ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 15:09:58 -0400
Received: by pwj9 with SMTP id 9so5403524pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 12:09:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This I2C PM patch has been in the PM branch for awhile.  This should
be queued in omap-testing with the other I2C changes targetted for
upstream.

Kevin


Kalle Jokiniemi (1):
  i2c-omap: add mpu wake up latency constraint in i2c

 arch/arm/plat-omap/i2c.c      |   55 ++++++++++++++++++++++++++++++++---------
 drivers/i2c/busses/i2c-omap.c |   24 +++++++++++++++---
 include/linux/i2c-omap.h      |    9 ++++++
 3 files changed, 72 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/i2c-omap.h

