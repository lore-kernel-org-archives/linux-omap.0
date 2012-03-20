From: <mythripk@ti.com>
Subject: [PATCH 0/3] OMAPDSS: HDMI: Interrupt and PHY state handling support
Date: Tue, 20 Mar 2012 18:45:04 +0530
Message-ID: <1332249307-26875-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48443 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929Ab2CTNWE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 09:22:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q2KDM2Mr026766
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 08:22:03 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q2KDM1mA018727
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 18:52:02 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support for handling the DSS_HDMI interrupt in HDMI, A line that serves to
notify HDMI of status change in PHY, PLL and CORE based on the registration.
Also logic to support enabling of the PHY in TX_ON state only when a PHY_CONNECT
which would make sure that TMDS lines are high before putting it in TX_ON state.

Mythri P K (3):
  OMAPDSS: HDMI: support for interrupt enabling
  OMAPDSS: HDMI: Add support for DSS_HDMI Interrupt
  OMAPDSS: HDMI: wait for TMDS to be high before putting phy in TX_ON

 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   21 +++++
 drivers/video/omap2/dss/ti_hdmi.h         |   20 +++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  117 +++++++++++++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    3 +
 5 files changed, 157 insertions(+), 5 deletions(-)

-- 
1.7.5.4

