From: <mythripk@ti.com>
Subject: [PATCH 0/4] OMAPDSS: HDMI: Improve the timings logic in HDMI
Date: Mon, 2 Jan 2012 14:14:52 +0530
Message-ID: <1325493896-26355-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55984 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab2ABIw0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jan 2012 03:52:26 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q028qOav014009
	for <linux-omap@vger.kernel.org>; Mon, 2 Jan 2012 02:52:25 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q028qNKL015794
	for <linux-omap@vger.kernel.org>; Mon, 2 Jan 2012 14:22:23 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

There are some duplicate timing structure which are not needed thus removing
them to clean the code.
Also the static mapped timing structure is quite complicated to add new
timings, so simplify it by using array indexed method.

changes since V1: change of hdmi_find_timing function to return pointer to the
timing struct rather than deep copy to timing structure passed as parameter
variable name change from temp to timing2 in comparator function.

Mythri P K (4):
  OMAPDSS: HDMI: remove duplicate video interface code
  OMAPDSS: HDMI: update static timing table
  OMAPDSS: HDMI: change the timing match logic
  OMAPDSS: HDMI: remove duplicate code and mode parameter

 drivers/video/omap2/dss/hdmi.c            |  254 +++++++++++++----------------
 drivers/video/omap2/dss/ti_hdmi.h         |   14 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   47 ++----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    7 -
 4 files changed, 134 insertions(+), 188 deletions(-)

-- 
1.7.5.4

