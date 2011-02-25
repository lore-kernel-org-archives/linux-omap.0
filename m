From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch 0/2] OMAP2PLUS:DSS2: use opt-clocks information from hwmod.
Date: Fri, 25 Feb 2011 13:57:48 +0530
Message-ID: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab1BYI2F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 03:28:05 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P8S42o000613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 02:28:04 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

This series uses information about opt-clocks provided by omap_hwmod framework
to select which of the non-mandatory DSS clocks are available on a given
platform.
The clock roles returned by hwmod database are added to pdata, and in the
driver, while doing clk-get, it is checked if as per hwmod a given clock 
is an opt-clock or not, and is handled accordingly.

Tested on: OMAP3430sdp, panda(OMAP4430)

Sumit Semwal (2):
  OMAP2PLUS: DSS2: Add dss_opt_clk_roles in pdata
  OMAP2PLUS: DSS2: Use opt-clocks from hwmod

 arch/arm/mach-omap2/display.c             |   41 +++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/display.h |    3 +-
 drivers/video/omap2/dss/dss.c             |   54 ++++++++++++++++++++---------
 3 files changed, 79 insertions(+), 19 deletions(-)

