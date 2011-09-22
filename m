From: <mythripk@ti.com>
Subject: [PATCH 0/5] OMAPDSS: HDMI: Debug support and Register cleanup
Date: Thu, 22 Sep 2011 13:37:41 +0530
Message-ID: <1316678866-17749-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53523 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab1IVIPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 04:15:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8M8FlgX030170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 03:15:49 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8M8Flmw011454
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 13:45:47 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support to dump HDMI core, wrapper, PHY and PLL registers and the clock
dividers for HDMI.
Some changes such as 
1.Add some H/w indexable registers missed in definition.
2.Remove usage of struct hdmi_reg and use u16 instead.
3.Move the avi_infoframe parameters comments above the field.
are also added as a part of this patch series.

changes since V1 :
1.Make the dump of register with index more readable.
2.Make the clock dump more readable

Tested as below:
mount debugfs : mount -t debugfs none /sys/kernel/debug
Test for register dump : /sys/kernel/debug/omapdss/hdmi
Test for clock dump : /sys/kernel/debug/omapdss/clk
and verify the dumps for correctness and readablitiy.
 
Mythri P K (5):
  OMAPDSS: HDMI: Move the comments in avi infoframe structure
  OMAPDSS: HDMI: Replace hdmi_reg struct with u16
  OMAPDSS: HDMI: Add missing register definitions
  OMAPDSS: HDMI: Add support to dump registers through      debugfs
  OMAPDSS: HDMI: Add support to dump clocks through debugfs

 drivers/video/omap2/dss/core.c            |    4 +
 drivers/video/omap2/dss/dss.c             |    3 +
 drivers/video/omap2/dss/dss.h             |    2 +
 drivers/video/omap2/dss/dss_features.c    |    5 +
 drivers/video/omap2/dss/hdmi.c            |   51 +++++
 drivers/video/omap2/dss/ti_hdmi.h         |   14 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  183 +++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |  296 ++++++++++++++---------------
 8 files changed, 403 insertions(+), 155 deletions(-)

-- 
1.7.5.4

