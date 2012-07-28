From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/2] OMAPDSS: DISPC: Improvements to DIGIT sync signal selection
Date: Fri, 27 Jul 2012 19:21:35 -0500
Message-ID: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37325 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab2G1AXQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 20:23:16 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6S0NF1i011846
	for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 19:23:15 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6S0NFAR020569
	for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 19:23:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Hello,

DSS code wrongly assumes that VENC is always available as source for the external
sync signal for the display controller DIGIT channel. One cannot blindly
rely only on the value of DSS_CONTROL register as certain processors may not
have VENC (e.g., OMAP5).

These patches add logic to correctly set/get the sync signal based on the
available displays in the DIGIT channel.

For the HDMI driver, handle the error in the selection of the source.

BR,

Ricardo


Ricardo Neri (2):
  OMAPDSS: DISPC: Improve logic of selection of external sync signal
  OMAPDSS:HDMI: Improve error handling at power on

 drivers/video/omap2/dss/dss.c  |   19 +++++++++++++++++--
 drivers/video/omap2/dss/dss.h  |    2 +-
 drivers/video/omap2/dss/hdmi.c |   10 ++++++++--
 3 files changed, 26 insertions(+), 5 deletions(-)

-- 
1.7.5.4

