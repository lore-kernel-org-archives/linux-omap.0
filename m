From: Amber Jain <amber@ti.com>
Subject: [PATCH v2 0/5] OMAP: DSS2: Add suppport for new color format
Date: Thu, 19 May 2011 19:47:49 +0530
Message-ID: <1305814674-21589-1-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933357Ab1ESOR6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 10:17:58 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4JEHw7n009550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:17:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, molnar@ti.com, Amber Jain <amber@ti.com>

This patch-set adds support for NV12 color format:
- Add support for various new color formats supported by OMAP4.
- Corrects the fir_hinc and fir_vinc to have a non-zero value 
  as per TRM.
- Add the support for NV12 along with the extra registers that needs to be
  configured for the same.
- Add basic scaling support for the UV-plane in case of NV12 format.
- Change the way chroma scaling is handled for YUV formats on OMAP4.
- Contains chroma scaling (_dispc_set_scaling_uv) design and implemented by
  Lajos Molnar <molnar@ti.com>.

Can be tested using v4l2 streaming over:
http://gitorious.org/~amber/linux-omap-dss2/amber-omap-dss2/commits/dss2-color-formats
This branch contains few private patches which enables v4l2 on OMAP4.

Changes from v1:
- rebased to Tomi's master.
- updated the commit messages to make them more descriptive.
- corrected few typos.
Amber Jain (5):
  OMAP: DSS2: Add new color formats to OMAP4
  OMAP: DSS2: Ensure non-zero FIR values are configured
  OMAP: DSS2: Use for loop where ever possible in SR(), RR()
  OMAP: DSS2: Adds new registers for NV12 support
  OMAP: DSS2: Add support for NV12 format

 drivers/video/omap2/dss/dispc.c        |  706 +++++++++++++++++++++++---------
 drivers/video/omap2/dss/dispc.h        |  147 +++++++
 drivers/video/omap2/dss/dss.h          |    3 +-
 drivers/video/omap2/dss/dss_features.c |   40 ++-
 drivers/video/omap2/dss/dss_features.h |    2 +
 drivers/video/omap2/dss/manager.c      |   12 +-
 include/video/omapdss.h                |    6 +
 7 files changed, 708 insertions(+), 208 deletions(-)

