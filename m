From: <mythripk@ti.com>
Subject: [PATCH 0/3] OMAPDSS: HDMI: HDMI Hot-plug detect support.
Date: Tue, 13 Dec 2011 18:54:55 +0530
Message-ID: <1323782698-24428-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39520 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab1LMNch (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:32:37 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBDDWYTZ008536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:32:36 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBDDWX31012425
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 19:02:33 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

HDMI even if enabled by default should be powered on only when the cable is
connected. This is supported by the Hot-plug feature.
Now when HDMI is enabled the following steps are followed:
-Display enable for HDMI is based on Hot-plug-detect(HPD).
-It registers to the GPIO irq handler and checks if cable is connected,
	-If yes then it turns on HDMI
-If an HPD interrupt is received the corresponding IRQ handler is called where
it checks if it is a connect / disconnect based on which appropriate action
is taken. 


Mythri P K (3):
  OMAPDSS: HDMI: HPD support in boardfile
  OMAPDSS: HDMI: HPD support added to HDMI driver
  OMAPDSS: HDMI: Add option to enable HDMI in HPD mode

 arch/arm/mach-omap2/board-4430sdp.c    |   35 ++++--------
 arch/arm/mach-omap2/board-omap4panda.c |   35 ++++---------
 arch/arm/mach-omap2/display.c          |   20 ++++++--
 drivers/video/omap2/dss/dss.h          |    2 +
 drivers/video/omap2/dss/hdmi.c         |   92 ++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/hdmi_panel.c   |   54 ++++++++++++++++++-
 include/video/omapdss.h                |   10 +++-
 7 files changed, 176 insertions(+), 72 deletions(-)

-- 
1.7.5.4

