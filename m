From: <mythripk@ti.com>
Subject: [PATCH 0/4] OMAPDSS: HDMI: Improve the timings logic in HDMI
Date: Fri, 11 Nov 2011 18:39:33 +0530
Message-ID: <1321016977-1808-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40761 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757854Ab1KKNRZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 08:17:25 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pABDHMaE020182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 07:17:24 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pABDHLMJ021982
	for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 18:47:21 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

There are some duplicate timing structure which are not needed thus removing
them to clean the code.
Also the static mapped timing structure is quite complicated to add new
timings, so simplify it by using array indexed method.

Mythri P K (4):
  OMAPDSS: HDMI: remove duplicate video interface code
  OMAPDSS: HDMI: update static timing table
  OMAPDSS: HDMI: change the timing match logic
  OMAPDSS: HDMI: remove duplicate code and mode parameter

 drivers/video/omap2/dss/hdmi.c            |  246 +++++++++++++----------------
 drivers/video/omap2/dss/ti_hdmi.h         |   14 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   47 ++----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    7 -
 4 files changed, 128 insertions(+), 186 deletions(-)

-- 
1.7.5.4

