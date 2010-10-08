From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v6 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
Date: Fri,  8 Oct 2010 12:14:30 +0530
Message-ID: <1286520273-4892-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50228 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab0JHGom (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 02:44:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

The changelog till v6 are:
	- Address Multi-omap build issue
	- Added a check to warn the wrong usage of vrfb 
	in non-vrfb omap devices.
	- The patch subject is as per the naming conventions
	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
	instead of omap2/Kconfig.  The functional effect remains
	the same, and the place of implementation is more appropriate.
	- Provide details of non-vrfb devices in commit description in patch 3/3
	- Removed extra paranthesis in cpu checks


Senthilvadivu Guruswamy (3):
  OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
  OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
  OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only for omap2,3

 arch/arm/plat-omap/include/plat/vrfb.h   |   16 ++++++++++++++++
 drivers/video/omap2/omapfb/Kconfig       |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
 3 files changed, 27 insertions(+), 1 deletions(-)

