From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v5 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
Date: Thu,  7 Oct 2010 16:45:52 +0530
Message-ID: <1286450155-1460-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53251 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760307Ab0JGLQ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 07:16:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

The changelog till v5 are:
	- Address Multi-omap build issue
	- Added a check to warn the wrong usage of vrfb 
	in non-vrfb omap devices.
	- The patch subject is as per the naming conventions
	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
	instead of omap2/Kconfig.  The functional effect remains
	the same, and the place of implementation is more appropriate.
	- Provide details of non-vrfb devices in commit description in patch 3/3


Senthilvadivu Guruswamy (3):
  OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
  OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
  OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only for omap2,3

 arch/arm/plat-omap/include/plat/vrfb.h   |   16 ++++++++++++++++
 drivers/video/omap2/omapfb/Kconfig       |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
 3 files changed, 27 insertions(+), 1 deletions(-)

