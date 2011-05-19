From: Amber Jain <amber@ti.com>
Subject: [PATCH 0/5] OMAP: DSS2: Add suppport for new color format
Date: Thu, 19 May 2011 11:01:25 +0530
Message-ID: <1305783090-21214-1-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44546 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab1ESFbf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 01:31:35 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4J5VZr5005007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 00:31:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, molnar@ti.com, Amber Jain <amber@ti.com>

This patch-set adds support for NV12 color format:
- Adds support for various new color formats supported by OMAP4.
- Corrects the fir_hinc and fir_vinc to have a non-zero value 
  as per TRM.
- Adds the support for NV12 along with the extra registers that needs to be
  configured for the same.
- Adds basic scaling support for the UV-plane in case of NV12 format.
- Contains chroma scaling (_dispc_set_scaling_uv) design and implemented by
  Lajos Molnar <molnar@ti.com>.

Applies over:
http://gitorious.org/~amber/linux-omap-dss2/amber-omap-dss2/commits/master

Can be tested using v4l2 streaming over:
http://gitorious.org/~amber/linux-omap-dss2/amber-omap-dss2/commits/dss2-color-formats
This branch contains few private patches which enables v4l2 on OMAP4.

Amber Jain (5):
  OMAP: DSS2: Add new color formats
  OMAP: DSS2: configuring non-zero values for fir_hinc/fir_vinc
  OMAP: DSS2: Use for loop where ever possible in SR(), RR(), DUMPREG()
  OMAP: DSS2: Adds new registers for NV12 support
  OMAP: DSS2: Add support for NV12 format

 drivers/video/omap2/dss/dispc.c        |  740 +++++++++++++++++++++-----------
 drivers/video/omap2/dss/dispc.h        |  147 +++++++
 drivers/video/omap2/dss/dss.h          |    3 +-
 drivers/video/omap2/dss/dss_features.c |   36 ++-
 drivers/video/omap2/dss/dss_features.h |    2 +
 drivers/video/omap2/dss/manager.c      |   12 +-
 include/video/omapdss.h                |    6 +
 7 files changed, 681 insertions(+), 265 deletions(-)

