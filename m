From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch v3 0/2] OMAP2PLUS:DSS2: use opt-clocks information from hwmod.
Date: Tue,  1 Mar 2011 14:12:12 +0530
Message-ID: <1298968934-22697-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48777 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757Ab1CAIm2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 03:42:28 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p218gRpn001031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 02:42:27 -0600
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

changes from v2:
- made oh_core a static variable, looked up only once in omap_display_init.

changes from v1:
- made opt_clock_available a function pointer in the omap_display_platform_data
  to avoid having to copy the opt-clock role names.


 arch/arm/mach-omap2/display.c             |   22 ++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    2 +
 drivers/video/omap2/dss/dss.c             |   46 +++++++++++++++++++----------
 3 files changed, 54 insertions(+), 16 deletions(-)

