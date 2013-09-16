From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/4] arm: omap: display: Ensure DRM/FB/V4L devices are created if DSS is available
Date: Mon, 16 Sep 2013 12:48:27 +0530
Message-ID: <1379315911-24634-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab3IPHT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 03:19:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, omapdrm, omapfb and omap_vout platform devices are created and
registered through omap_arch_initcalls. In a multiplatform config. It's
possible that all the corresponding configs for the above drivers along with
omapdss config are selected even if the hardware doesn't have a DSS IP.

If the image is booted on a AM33xx platform, the above drm, fb and v4l devices
would be registered throuth the omap_arch_initcalls even if omapdss itself isn't
registered. These platform devices don't cause any harm, but are unnecessary.

Move the registration of these devices into omap_display_init(), which registers
omapdss devices and is called only if the platform has DSS hardware.

Also, the first patch prevents creation of a DMM device when omapdrm device is
registered. With the removal of address and irq data from the omap4 hwmods, the
probe of DMM driver fails and omapdrm isn't able to utilize the DMM hardware.
This will be fixed when DMM DT nodes are added for omap4, omap5 and dra7x.

Changes in v2:
- Move device creation for omapfb and omap_vout to omap_display_init too.
- Keep the DMM DT conversion as a separate patch series since this series does
  something different now.

Archit Taneja (4):
  arm: omap: drm: Don't build device for DMM
  arm: omap: display: Create omapdrm device inside omap_display_init
  arm: omap: display: Create omapvrfb and omapfb devices inside
    omap_display_init
  arm: omap: display: Create omap_vout device inside omap_display_init

 arch/arm/mach-omap2/Makefile  |  6 +-----
 arch/arm/mach-omap2/devices.c | 10 +++++-----
 arch/arm/mach-omap2/display.c | 28 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/display.h |  4 ++++
 arch/arm/mach-omap2/drm.c     | 24 +++++-------------------
 arch/arm/mach-omap2/fb.c      | 14 +++++++-------
 6 files changed, 50 insertions(+), 36 deletions(-)

-- 
1.8.1.2

