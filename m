From: Archit Taneja <archit@ti.com>
Subject: [RFC v2][PATCH 0/7] OMAP: DSS2: Overlay Manager LCD2 support in DISPC
Date: Wed, 14 Jul 2010 12:02:40 +0530
Message-ID: <1279089167-14057-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42079 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab0GNGc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jul 2010 02:32:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, "Semwal, Sumit" <sumit.semwal@ti.com>

From: Semwal, Sumit <sumit.semwal@ti.com>

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

Sumit Semwal (6):
  OMAP: DSS2: Overlay Manager LCD2 changes in dispay.h
  OMAP: DSS2: Add new Overlay Manager
  OMAP: DSS2: Modify dss_recheck_connections
  OMAP: DSS2: Incorporate Secondary LCD Channel DISPC Registers
  OMAP: DSS2: Secondary LCD Channel DISPC IRQs
  OMAP: DSS2: Interface driver changes for Secondary LCD Channel

Mayuresh Janorkar (1)
  OMAP: DSS2: Context Save and Restore of DISPC registers for Secondary LCD

 arch/arm/plat-omap/include/plat/display.h |    7 +
 drivers/video/omap2/dss/core.c            |    2 +-
 drivers/video/omap2/dss/dispc.c           |  626 +++++++++++++++++++----------
 drivers/video/omap2/dss/dpi.c             |   38 +-
 drivers/video/omap2/dss/dsi.c             |   24 +-
 drivers/video/omap2/dss/dss.h             |   39 ++-
 drivers/video/omap2/dss/manager.c         |   89 +++--
 drivers/video/omap2/dss/overlay.c         |   14 +-
 drivers/video/omap2/dss/rfbi.c            |   21 +-
 drivers/video/omap2/dss/sdi.c             |   22 +-
 10 files changed, 571 insertions(+), 311 deletions(-)
--
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

