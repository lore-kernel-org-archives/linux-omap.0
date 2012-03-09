From: <mythripk@ti.com>
Subject: [PATCH 0/2] OMAPDSS: HDMI: Add support for OMAP5 HDMI core IP driver
Date: Fri, 9 Mar 2012 18:27:57 +0530
Message-ID: <1331297879-14622-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38628 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783Ab2CINFA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 08:05:00 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q29D4woU010127
	for <linux-omap@vger.kernel.org>; Fri, 9 Mar 2012 07:04:59 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q29D4vRQ020746
	for <linux-omap@vger.kernel.org>; Fri, 9 Mar 2012 18:34:58 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add basic functionality support for HDMI OMAP5 core driver.
Across OMAP4 and OMAP5 HDMI core IP block differs where as the PHY, PLL and
the wrapper blocks are reused, using the existing framework and extention to
support OMAP5 core driver is added.


Mythri P K (2):
  OMAPDSS: HDMI: Make Wrapper function non-static
  OMAPDSS: HDMI: Add support for OMAP5 HDMI core library in DSS

 drivers/video/omap2/dss/ti_hdmi.h         |    2 +
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   10 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    9 +
 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.c |  341 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.h |  254 +++++++++++++++++++++
 5 files changed, 611 insertions(+), 5 deletions(-)
 create mode 100644 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.c
 create mode 100644 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.h

-- 
1.7.5.4

