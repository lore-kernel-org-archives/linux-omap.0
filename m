From: Archit Taneja <archit@ti.com>
Subject: [RFC 00/17] OMAPDSS: Change way of passing timings from panel driver to interface
Date: Wed, 1 Aug 2012 16:01:11 +0530
Message-ID: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47970 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab2HAKcx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:32:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

This series tries to make interface drivers less dependent on omap_dss_device
which represents a panel/device connected to that interface. The current way of
configuring an interface is to populate the panel's omap_dss_device instance
with parameters common to the panel and the interface, they are either populated
in the board file, or in the panel driver. Panel timings, number of lanes
connected to interface, and pixel format are examples of such parameters, these
are then extracted by the interface driver to configure itself.

This approach has some disadvantages:

- The omap_dss_device contains fields which could be handled independently by
  the panel driver. For example, we have an enum field in omap_dss_device to
  tell what mode the panel operates in. This information could be handled by the
  panel driver itself. But it's a part of omap_dss_device since we need to pass
  this down to the interface driver.

- An interface can't exist by itself. That is, it needs a panel to be connected
  to it to configure itself. It's not practical to configure an interface
  without a panel, but it's theoretically possible, and we may need it if we
  expose the interface as an entity to a user of OMAPDSS. It's also useful if we
  represent writeback as an interface, writeback isn't connected to a panel.

- There is a lack of clarity in how the interface configures itself. Since the
  interface driver extracts info from omap_dss_device, it's unclear from a panel
  driver point of view about what information in omap_dss_device the interface
  is using and what it's not using.

- There are issues with checking the correctness of the parameters in
  omap_dss_device. We currently fill up the omap_dss_device completely, and then
  try to enable the interface, this results in catching a wrong parameter at a
  much later point, rather than catching it immediately.

The alternative approach is for the interface drivers to expose functions/api to
the panel drivers to configure such parameters. This way, the panel driver can
pass the parameters to the interface itself, rather than filling up
omap_dss_device. This would need the panel driver to keep a copy of the
parameters so that it can use to configure it later. This resolves all the
issues mentioned above, and also gives us a chance to make a generic set of
function ops for interfaces, this can make a panel driver independent of
the underlying platform.

The current series starts of this work by creating a set_timings function for
all interfaces passing omap_video_timings, this prevents dssdev->panel.timings
references. The first few patches are some minor cleanups which are useful for
the patches which come later.

There are some points on which I need suggestions/clarifications:
- How do we make sure that these functions are called by the panel driver at the
  right time? For example, when setting timings for DSI video mode, we would
  need to call omapdss_dsi_set_timings() before we call
  omapdss_dsi_display_enable(), otherwise the copy of timings contained in DSI
  driver data would be invalid. Also, what should the behaviour of such a
  set_timings operation if the interface is already enabled. It is clear for
  DPI and HDMI, but I'm not clear about what to do about other interfaces. Do we
  add checks for the state of the interface/panel?

- A specific issue about DSI/RFBI getting the resolution via
  device->driver->get_resolution(), does this provide a result based on panel
  rotation? Can this somehow be replaced by timings?

- For SDI, the set_timings operation is simplified, instead of disabling and
  then enabling the panel with a new set of timings, only the new timings are
  configured. This is similar to what is done in DPI. I am not clear if this
  will work for SDI or not.

- There is no set_timings() function for RFBI yet, this needs to be though of
  and fixed. 

The reference tree and branch:

This is based on Tomi's for-florian-merged branch, and has 2 of his patches which
got missed the last merge window.

This hasn't been tested thoroughly with all interfaces yet. I was interested in
getting some comments.

Archit Taneja (17):
  OMAPDSS: APPLY: Constify timings argument in dss_mgr_set_timings
  OMAPDSS: DPI: Remove omap_dss_device arguments in
    dpi_set_dsi_clk/dpi_set_dispc_clk
  OMAPDSS: HDMI: Remove omap_dss_device argument from hdmi_compute_pll
  OMAPDSS: DPI: Add locking for DPI interface
  OMAPDSS: DPI: Maintain our own timings field in driver data
  OMAPDSS: DPI displays: Take care of panel timings in the driver
    itself
  OMAPDSS: Displays: Add locking in generic DPI panel driver
  OMAPDSS: DSI: Maintain own copy of timings in driver data
  OMAPDSS: HDMI: Use our own omap_video_timings field when setting
    interface timings
  OMAPDSS: HDMI: Add a get_timing function for HDMI interface
  OMAPDSS: HDMI: Add locking for hdmi interface get/set timing
    functions
  OMAPDSS: SDI: Create a separate function for timing/clock
    configurations
  OMAPDSS: SDI: Create a function to set timings
  OMAPDSS: SDI: Maintain our own timings field in driver data
  OMAPDSS: VENC: Split VENC into interface and panel driver
  OMAPDSS: VENC: Maintain our own timings field in driver data
  OMAPDSS: VENC: Add a get_timing function for VENC interface

 drivers/video/omap2/displays/panel-acx565akm.c     |   13 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |   75 ++++++-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    2 +
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    2 +
 drivers/video/omap2/displays/panel-picodlp.c       |    3 +
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    2 +
 drivers/video/omap2/displays/panel-taal.c          |    2 +
 drivers/video/omap2/displays/panel-tfp410.c        |    5 +-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    6 +-
 drivers/video/omap2/dss/Makefile                   |    2 +-
 drivers/video/omap2/dss/apply.c                    |    4 +-
 drivers/video/omap2/dss/dpi.c                      |   52 +++--
 drivers/video/omap2/dss/dsi.c                      |   27 ++-
 drivers/video/omap2/dss/dss.h                      |   19 +-
 drivers/video/omap2/dss/hdmi.c                     |   60 +++--
 drivers/video/omap2/dss/hdmi_panel.c               |   12 +-
 drivers/video/omap2/dss/sdi.c                      |   87 +++++---
 drivers/video/omap2/dss/venc.c                     |  233 ++++++--------------
 drivers/video/omap2/dss/venc_panel.c               |  231 +++++++++++++++++++
 include/video/omapdss.h                            |    8 +-
 20 files changed, 579 insertions(+), 266 deletions(-)
 create mode 100644 drivers/video/omap2/dss/venc_panel.c

-- 
1.7.9.5

