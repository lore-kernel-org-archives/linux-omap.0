From: charu@ti.com
Subject: [PATCH v2 0/4] RTC-MSECURE: platform data structure defined
Date: Mon, 24 Aug 2009 20:36:50 +0530
Message-ID: <1251126410-27105-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43309 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbZHXPHG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Aug 2009 11:07:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com, Charulatha V <charu@ti.com>

Review comments are incorporated.
This series contains patches which does the following. 
        1. define TWL4030 rtc platform data which has msecure gpio line info
        2. initialise msecure gpio line from rtc driver
        3. twl core file passes rtc platform data from board file to rtc driver
        4. Board files handle mux configuration of msecure gpio line

This series applies on top of linux-2.6.31-rc5.

CharuLatha (4):

        [PATCH 1/4] RTC platform data structure defined
        [PATCH 2/4] RTC msecure initialization
        [PATCH 3/4] handling rtc platform data
        [PATCH 4/4] board files do msecure line mux configuration


Signed-off-by: Charulatha V <charu@ti.com>
---
 include/linux/i2c/twl4030.h 	       |    5 +++++
 drivers/rtc/rtc-twl4030.c 	       |   38 +++++++++++++++++++++++++++++++++++++-
 drivers/mfd/twl4030-core.c 	       |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c   |    7 +++++++
 arch/arm/mach-omap2/board-3430sdp.c   |   18 +++++++++++++++++-
 arch/arm/mach-omap2/board-ldp.c       |   19 +++++++++++++++++++
 arch/arm/mach-omap2/mux.c             |    5 +++++
 arch/arm/plat-omap/include/mach/mux.h |    2 ++
 
 8 files changed, 93 insertions(+), 3 deletions(-)
