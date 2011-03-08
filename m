From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/2] OMAP2PLUS: DSS2: Clock Source Changes
Date: Tue,  8 Mar 2011 17:20:33 +0530
Message-ID: <1299585035-26931-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42149 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab1CHLqv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 06:46:51 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28Bkp4X005419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 05:46:51 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

There are clocks on OMAP4 within DSS2 which can have multiple clock sources.
This cleans up the existing way of selecting/getting the clock sources and add
some of the new clock sources for OMAP4.

Applies over:
http://gitorious.org/linux-omap-dss2/linux/commits/master

Archit Taneja (2):
  OMAP2PLUS: DSS2: Cleanup clock source related code
  OMAP4: DSS2: Clock source changes for OMAP4

 drivers/video/omap2/dss/dispc.c        |   46 +++++++++++++++-----
 drivers/video/omap2/dss/dss.c          |   76 ++++++++++++++++++++++++++------
 drivers/video/omap2/dss/dss.h          |   31 +++++++++----
 drivers/video/omap2/dss/dss_features.c |   13 +++++-
 drivers/video/omap2/dss/dss_features.h |    3 +
 5 files changed, 133 insertions(+), 36 deletions(-)
--
v2:
-Split cleanup and OMAP4 changes into 2 patches
-Don't use CONFIG_OMAP2_DSS_DSI macro
-Let LCDx_CLK clock source be used for OMAP2/3, but keep it always as
DSS_CLK_SRC_FCK
