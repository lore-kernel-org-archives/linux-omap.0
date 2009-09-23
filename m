From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv2 0/5] dspbridge: OSAL: Simplify so called 'registry'
Date: Wed, 23 Sep 2009 19:03:18 +0300
Message-ID: <1253721804-22816-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59835 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbZIWQDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 12:03:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There are several patches which simplify registry API and code.

Andy Shevchenko (5):
  DSPBRIDGE: OSAL: Simplify REG API
  DSPBRIDGE: OSAL: Remove unused registry variables
  DSPBRIDGE: OSAL: Clean up dbreg.h and move it
  DSPBRIDGE: OSAL: Implement registry as linked list
  DSPBRIDGE: OSAL: Remove printS()

 arch/arm/plat-omap/include/dspbridge/dbdefs.h |   26 +++
 arch/arm/plat-omap/include/dspbridge/dbreg.h  |  113 ------------
 arch/arm/plat-omap/include/dspbridge/reg.h    |  102 ++---------
 drivers/dsp/bridge/pmgr/dev.c                 |    1 -
 drivers/dsp/bridge/rmgr/dbdcd.c               |   22 +--
 drivers/dsp/bridge/rmgr/drv.c                 |   25 +--
 drivers/dsp/bridge/rmgr/drv_interface.c       |   37 +---
 drivers/dsp/bridge/rmgr/dspdrv.c              |    3 -
 drivers/dsp/bridge/rmgr/mgr.c                 |    1 -
 drivers/dsp/bridge/rmgr/node.c                |    1 -
 drivers/dsp/bridge/rmgr/proc.c                |    1 -
 drivers/dsp/bridge/rmgr/strm.c                |    1 -
 drivers/dsp/bridge/services/cfg.c             |   53 ++----
 drivers/dsp/bridge/services/reg.c             |   29 +--
 drivers/dsp/bridge/services/regsup.c          |  243 +++++++-----------------
 drivers/dsp/bridge/services/regsup.h          |    7 +-
 drivers/dsp/bridge/wmd/io_sm.c                |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c           |    5 +-
 18 files changed, 164 insertions(+), 507 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/dbreg.h

