From: <mythripk@ti.com>
Subject: [PATCH v4 0/4] OMAPDSS: HDMI: Improve the timings logic in HDMI
Date: Fri, 6 Jan 2012 17:52:06 +0530
Message-ID: <1325852530-4829-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58538 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482Ab2AFM3k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:29:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06CTc0W027397
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:29:39 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06CTbsh022442
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 17:59:38 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

There are some duplicate timing structure which are not needed thus removing
them to clean the code.
Also the static mapped timing structure is quite complicated to add new
timings, so simplify it by using array indexed method.

changes since v3: Remove double call of function
changes since v2: Incorporate changes in find_timing function
changes since V1: change of hdmi_find_timing function to return pointer to the
timing struct rather than deep copy to timing structure passed as parameter
variable name change from temp to timing2 in comparator function.

Mythri P K (4):
  OMAPDSS: HDMI: remove duplicate video interface code
  OMAPDSS: HDMI: update static timing table
  OMAPDSS: HDMI: change the timing match logic
  OMAPDSS: HDMI: remove duplicate code and mode parameter

 drivers/video/omap2/dss/hdmi.c            |  256 +++++++++++++----------------
 drivers/video/omap2/dss/ti_hdmi.h         |   14 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   47 ++----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    7 -
 4 files changed, 135 insertions(+), 189 deletions(-)

-- 
1.7.5.4

