From: Samreen <samreen@ti.com>
Subject: [PATCH v2 0/2] OMAP3: DSS2: Pre-Multiplied Alpha support
Date: Thu,  4 Nov 2010 16:58:40 +0530
Message-ID: <1288870122-22836-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59417 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0KDLd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 07:33:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ville.syrjala@nokia.com, Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>

Enable Pre multiplied alpha support on OMAP3630

The first patch splits the omap3 dss has features for omap3430
and omap3630 separately
The second patch adds the support for pre multiplied alpha

Version2:
   - Split the patch into dss has feature patch and pre multiplied
   alpha support
   - Remove the BUG_ON in functions setting pre multiplied alpha
   and global alpha 
   - Uniformly use "pre_mult_alpha" naming convention

Rajkumar N (1):
  OMAP3630: DSS2: Enable Pre-Multiplied Alpha Support

Samreen (1):
  OMAP3: DSS2: Split OMAP3 has feature for 3430 & 3630

 arch/arm/plat-omap/include/plat/display.h |    1 +
 drivers/video/omap2/dss/dispc.c           |   30 ++++++++++++++++-----
 drivers/video/omap2/dss/dss.h             |    3 +-
 drivers/video/omap2/dss/dss_features.c    |   20 ++++++++++++--
 drivers/video/omap2/dss/dss_features.h    |    1 +
 drivers/video/omap2/dss/manager.c         |    5 +++-
 drivers/video/omap2/dss/overlay.c         |   41 +++++++++++++++++++++++++++++
 7 files changed, 89 insertions(+), 12 deletions(-)

