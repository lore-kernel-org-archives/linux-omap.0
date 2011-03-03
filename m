From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/2] mfd: TWL6030: add version check for errata handling
Date: Thu,  3 Mar 2011 18:28:32 +0530
Message-ID: <1299157114-19381-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36405 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757762Ab1CCMzt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 07:55:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, linux-omap@vger.kernel.org
Cc: leslyam@ti.com, paul@pwsan.com, Balaji T K <balajitk@ti.com>

Phoenix TWL6030: add version check for errata handling

This patch series has dependency on omap3: pm: TWL5030 version checking
for twl_idcode variable
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg45929.html

Balaji T K (2):
  mfd: TWL6030: Add support for version detection
  mfd: TWL6030: Fix buggy burst read in TWL6030 ES1.0

 drivers/mfd/twl-core.c  |   74 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/twl.h |   10 ++++++
 2 files changed, 82 insertions(+), 2 deletions(-)

