From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch v2 0/2] OMAP2PLUS:DSS2: use opt-clocks information from hwmod.
Date: Mon, 28 Feb 2011 20:32:41 +0530
Message-ID: <1298905363-28871-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50282 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab1B1PDM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 10:03:12 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1SF3BrV029697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 09:03:11 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

This series uses information about opt-clocks provided by omap_hwmod framework
to select which of the non-mandatory DSS clocks are available on a given
platform.

A function pointer opt_clock_available is exported via pdata, which checks the
clock roles returned by hwmod database.
In the driver, while doing clk-get, it is checked if as per hwmod a given clock
is an opt-clock or not, and is handled accordingly.

Tested on: OMAP3430sdp

Sumit Semwal (2):
  OMAP2PLUS:DSS2: add opt_clock_available in pdata
  OMAP2PLUS:DSS2: Use opt_clock_available from pdata

changes from v1:
- made opt_clock_available a function pointer in the omap_display_platform_data
  to avoid having to copy the opt-clock role names.

Based on top of:
http://gitorious.org/linux-omap-dss2/linux/commits/master
commit: ad1c76c: OMAP: Overo Palo43 LCD support


 arch/arm/mach-omap2/display.c             |   20 ++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    2 +
 drivers/video/omap2/dss/dss.c             |   46 +++++++++++++++++++----------
 3 files changed, 52 insertions(+), 16 deletions(-)

