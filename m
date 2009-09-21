From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 0/2] dspbridge: OSAL: Simplify REG API
Date: Mon, 21 Sep 2009 19:11:11 +0300
Message-ID: <1253549473-13109-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23594 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbZIUQLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 12:11:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There are two patches which simplify registry API.

Andy Shevchenko (2):
  DSPBRIDGE: OSAL: Simplify REG API
  DSPBRIDGE: OSAL: Remove unused registry variables

 arch/arm/plat-omap/include/dspbridge/dbreg.h |    3 -
 arch/arm/plat-omap/include/dspbridge/reg.h   |  102 +++----------------------
 drivers/dsp/bridge/rmgr/dbdcd.c              |   22 ++---
 drivers/dsp/bridge/rmgr/drv.c                |   22 ++----
 drivers/dsp/bridge/rmgr/drv_interface.c      |   35 ++-------
 drivers/dsp/bridge/services/cfg.c            |   50 ++++---------
 drivers/dsp/bridge/services/reg.c            |   26 ++-----
 drivers/dsp/bridge/services/regsup.c         |    3 +-
 drivers/dsp/bridge/services/regsup.h         |    4 +-
 drivers/dsp/bridge/wmd/tiomap3430.c          |    4 +-
 10 files changed, 68 insertions(+), 203 deletions(-)

