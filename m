From: <mythripk@ti.com>
Subject: [PATCH 0/3] OMAPDSS: HDMI: HDMI Hot-plug detect support.
Date: Fri, 6 Jan 2012 18:14:34 +0530
Message-ID: <1325853877-6712-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35753 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193Ab2AFMwH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:52:07 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06Cq4Qo031296
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:52:05 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06Cq4rp025606
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 18:22:04 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

HDMI phy should be in the LDO_ON state when cable is not connected.
Only when cable is connected and transmission is possible HDMI Phy should move
to TX_ON state.
This is supported by the Hot-plug feature.
Now when HDMI is enabled the following steps are followed:
-It registers to the GPIO irq handler
-If an HPD interrupt is received the corresponding IRQ handler is called where
it checks if it is a connect / disconnect based on which PHY is moved to
appropriate state.

Mythri P K (3):
  OMAPDSS: HDMI: HPD support in boardfile
  OMAPDSS: HDMI: Handle HPD event in ip
  OMAPDSS: HDMI: HPD support added to HDMI driver

 arch/arm/mach-omap2/board-4430sdp.c       |   37 +++++-----------
 arch/arm/mach-omap2/board-omap4panda.c    |   37 +++++-----------
 arch/arm/mach-omap2/display.c             |   21 ++++++++--
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   65 ++++++++++++++++++++++-------
 drivers/video/omap2/dss/ti_hdmi.h         |    4 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   31 +++++++++++--
 include/video/omapdss.h                   |    6 ++-
 8 files changed, 126 insertions(+), 76 deletions(-)

-- 
1.7.5.4

