From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 0/2] OMAPDSS: DISPC: Peformance improvement of DISPC Scaling
Date: Mon, 19 Dec 2011 14:03:22 +0530
Message-ID: <1324283602-6383-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36868 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab1LSIda (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 03:33:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
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
 drivers/video/omap2/dss/dispc_coefs.c  |  326 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.c |    7 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 6 files changed, 411 insertions(+), 139 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dispc_coefs.c

