From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 0/2] OMAPDSS: DISPC: Peformance improvement of DISPC Scaling
Date: Wed, 14 Dec 2011 10:21:30 +0530
Message-ID: <1323838290-4401-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59378 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab1LNEvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:51:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
the following patch set directs to improve the scaling performance of DISPC
module which consists of two pacthes.

The first patch is based on code of Lajos Molnar <lajos@ti.com> from Android
Kernel, which updates the code with new set of coefficients to improve the
scaling performance.

The second patch is based on some very valuable suggestions by 
Sebastien Fagard <s-fagard@ti.com> and directs to modify the clock 
requirements for scaling to support OMAP4 and avoid clock failure issues.

I have tested these patches on OMAP2, OMAP3 AND OMAP4. To test on 2430SDP
board I have created a patch to enable the display which will follow later.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (2):
  OMAPDSS: DISPC: Update Fir Coefficients
  OMAPDSS: DISPC: Update Scaling Clock Logic

 drivers/video/omap2/dss/Makefile       |    2 +-
 drivers/video/omap2/dss/dispc.c        |  203 +++++++--------------
 drivers/video/omap2/dss/dispc.h        |   11 +
 drivers/video/omap2/dss/dispc_coefs.c  |  327 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.c |    7 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 6 files changed, 412 insertions(+), 139 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dispc_coefs.c

