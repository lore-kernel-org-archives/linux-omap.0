From: Archit Taneja <archit@ti.com>
Subject: [RFC v3][PATCH 0/4] OMAP: DSS2: Overlay Manager LCD2 support in DISPC
Date: Tue,  5 Oct 2010 17:25:20 +0530
Message-ID: <1286279724-11692-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38741 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab0JELyw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 07:54:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This patch series which incorporates changes in DSS2 to enable
omap_dss_device instances to use the new Overlay Manager LCD2 in
DISPC.

On OMAP4, we have a new DISPC channel for Overlay Manager LCD2. This
channel's video port is a source port for RFBI, DSI2 and DPI. The
Primary channel's video port is connected to RFBI and DSI1.

There is a set of regsiters for LCD2 channel similar to the existing
LCD channel, like DISPC_CONTROL2, DISPC_DIVISOR2, DISPC_CONFIG2 and so
on.

In order to decide which LCD Overlay Manager to configure(LCD/LCD2),
there is a need for the omap_dss_device instances to tell the interface
drivers(DSI, DPI, RFBI etc) which LCD channel they want to connect to, so
that the corresponding registers get configured. Therefore, a new
enum omap_channel member is introduced to omap_dss_device.

This design was made keeping in mind the possible addition of more
Overlay Managers in future OMAPs, this code is also backward compatible
with OMAP3 as omap_dss_device instances in OMAP3 will stick only with
OMAP_DSS_CHANNEL_LCD.

This will apply over the set of dss_feature framework patches:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34768.html

Archit Taneja (1):
  OMAP: DSS2: Add dss_features for omap4 and new overlay manager level
    features

Sumit Semwal (3):
  OMAP: DSS2: Incorporate Secondary LCD Channel DISPC Registers
  OMAP: DSS2: Interface driver changes for Secondary LCD Channel
  OMAP: DSS2: Add new Overlay Manager

 arch/arm/plat-omap/include/plat/display.h |    7 +
 drivers/video/omap2/dss/core.c            |    2 +-
 drivers/video/omap2/dss/dispc.c           |  627 +++++++++++++++++++----------
 drivers/video/omap2/dss/dpi.c             |   38 +-
 drivers/video/omap2/dss/dsi.c             |   24 +-
 drivers/video/omap2/dss/dss.h             |   39 ++-
 drivers/video/omap2/dss/dss_features.c    |   39 ++-
 drivers/video/omap2/dss/dss_features.h    |    7 +-
 drivers/video/omap2/dss/manager.c         |   73 +++--
 drivers/video/omap2/dss/overlay.c         |   14 +-
 drivers/video/omap2/dss/rfbi.c            |   21 +-
 drivers/video/omap2/dss/sdi.c             |   22 +-
 12 files changed, 604 insertions(+), 309 deletions(-)
--
 Version 3:
- Patches are reworked over dss2 features framework. Number of patches
  are reduced.
Version 2:
- The DISPC_BASE macro now isn't changed for OMAP4, a future
  hwmod patch will take care of this dynamically.
- Supported_displays member of manager is now assigned correctly
  for OMAP2.
- DISPC Registers common to LCD and LCD2 channels are not defined
  separately, now there is a parameter which differentiates between
  the 2 channels.
- Secondary LCD manager is now named as lcd2 instead of 2lcd, the
  patch given in the link below allows DSS2 interpret this correctly.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31714.html

Version 1:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31458.html
