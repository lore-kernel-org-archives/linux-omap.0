From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 0/7] OMAP: DSS2: Overlay Manager LCD2 support in DISPC
Date: Mon,  8 Nov 2010 17:54:18 +0530
Message-ID: <1289219065-1362-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50603 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab0KHMX1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:23:27 -0500
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

This will apply over current lo-dss2 branch and the following:

Premultiplied alpha support:
https://patchwork.kernel.org/patch/301872/
https://patchwork.kernel.org/patch/301882/
and,
DSS2: Fix: Read correct bit in dispc_enable_alpha_blending():
https://patchwork.kernel.org/patch/308152/

Archit Taneja (2):
  OMAP: DSS2: Add dss_features for omap4 and overlay manager related
    features
  OMAP: DSS2: Use dss_features to handle DISPC bits removed on OMAP4

Sumit Semwal (5):
  OMAP: DSS2: Represent DISPC register defines with channel as
    parameter
  OMAP: DSS2: Introduce omap_channel as a omap_dss_device parameter
  OMAP: DSS2: Change remaining Dispc functions for new 'channel'
    argument
  OMAP: DSS2: LCD2 Channel Changes for DISPC
  OMAP: DSS2: Add new Overlay Manager

 arch/arm/plat-omap/include/plat/display.h |    7 +
 drivers/video/omap2/dss/dispc.c           |  573 +++++++++++++++++++----------
 drivers/video/omap2/dss/dpi.c             |   33 +-
 drivers/video/omap2/dss/dsi.c             |   21 +-
 drivers/video/omap2/dss/dss.h             |   36 +-
 drivers/video/omap2/dss/dss_features.c    |   43 ++-
 drivers/video/omap2/dss/dss_features.h    |    7 +-
 drivers/video/omap2/dss/manager.c         |   73 +++--
 drivers/video/omap2/dss/overlay.c         |   14 +-
 drivers/video/omap2/dss/rfbi.c            |   19 +-
 drivers/video/omap2/dss/sdi.c             |   22 +-
 11 files changed, 559 insertions(+), 289 deletions(-)
--
 Version 4:
- Broken into smaller patches in order to build in between patches.
- Some basic cleanup
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
  Version 1:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31458.html
