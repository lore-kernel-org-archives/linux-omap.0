From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 00/29] OMAPDSS: Initial Writeback Capture mode support
Date: Tue, 27 Dec 2011 18:06:43 +0530
Message-ID: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab1L0Mhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:37:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

DSS HW on OMAP4 supports a new pipeline called writeback. Unlike other
pipelines(called overlays in DSS2 SW), writeback takes pixel data from an
overlay output or a overlay manager output and writes it back into a specified
address in memory.

writeback allows us to take benefit of the hardware processing available inside
the DISPC like color space conversion, rescaling, compositing etc and do either
a) perform memory-to-memory transfer with data processing, b) capture a
displayed frame. The former is known as memory to memory mode of the writeback
pipeline, and the latter is known as capture mode. More details about writeback
can be found in the Display Subsystem section of the OMAP4 TRM.

In the current DSS2 design, there are 3 major entities: overlay(represents
pipelines), overlay manager(represents a compositor of pipelines and the output
going to a display) and a omap_dss_device(to represent a display). These
entities can be linked to each other. One or more overlays can connect to a
manager, and a manager connects to a display.

Writeback HW has some properties of an overlay, and some of an overlay manager.
But as far as DSS2 design is concerned, it best fits as a special panel. This
panel connects to a manager and displays/writes the content back to memory after
doing some optional data processing.

The design adopted for writeback support in DSS2 is as follows:
- Writeback exists as an entity of its own, this entity is used to configure and
  represent the actual writeback HW.
- This entity doesn't connect itself directly to a manager, it connects to a
  manager via a dummy writeback panel.
- The dummy writeback panel is just a place holder of the actual writeback
  entity. To do any writeback configuration, we extract the writeback pointer
  through the dummy writeback panel pointer. 
- In capture mode, an overlay manager needs to be connected to 2 outputs at the
  same time. The first output is the display device, and the second is the
  writeback panel. For this requirement, managers don't connect to a dss device,
  they now connect to an entity called output. This entity is just a container
  for 2 omap_dss_devices, one for display and one for writeback.

With the design mentioned above. The three different ways writeback is used is
explained:
- capture mode: A manager is connected to both display and writeback
  dss_devices.
- memory to memory mode(connected to a manager): A manager is connected to only
  the writeback dss_device.
- memory to memory mode(connected to an overlay): A dummy writeback manager is
  connect to the writeback dss_device.

This patch series only enables capture mode support, i.e., allowing us to write
to the memory a processed version of the frame that we display onto a panel
through an overlay manager. The memory to memory mode support will be extended
later.

In order to use writeback, we need a capture device driver of some sort, a v4l2
capture device is currently in the works. The patches are currently tested by
extending writeback panel's sysfs attributes to allow us to configure the
destination addresses and other parameters via sysfs.

This can be tried out here:

git://gitorious.org:~boddob/linux-omap-dss2/archit-dss2-clone.git wb-v1

The patches are based on the following tree:

git://gitorious.org/linux-omap-dss2/linux.git master

Tested on a OMAP4 based blaze tablet. Note that this isn't tested thoroughly for
all possible writeback configurations, the aim is to get comments on the design.

Archit Taneja (29):
  omapdss/omapfb/omap_vout: Introduce manager output struct
  OMAPDSS: Add writeback to omap_dss_mgr_output
  OMAPDSS: Writeback: Add writeback interface and panel driver
  OMAPDSS: APPLY/Writeback: Add writeback_info
  OMAPDSS: APPLY/Writeback: Apply writeback configurations
  OMAPDSS: APPLY: Add writeback enable/disable functions
  OMAPDSS: APPLY: Add extra_info for writeback
  OMAPDSS: APPLY: Modify manager unset device op
  OMAPDSS: APPLY: Allow manager set/unset_device ops to set/unset
    writeback
  OMAPDSS: APPLY: Calculate channel_in for writeback
  OMAPDSS: DISPC: Add writeback as a new plane
  OMAPDSS: Writeback: Add check for color_mode in dss_wb_simple_check()
  OMAPDSS: APPLY: Configure writeback FIFOs
  OMAPDSS: DISPC: Allow both upscaling and downscaling of chroma
  OMAPDSS: DISPC: Pass overlay caps as a parameter to dispc overlay
    related functions
  OMAPDSS: OVERLAY: Add position and replication as overlay caps
  OMAPDSS: DISPC: Make dispc_ovl_setup call dispc_plane_setup
  OMAPDSS: DISPC: Make chroma_upscale an argument to dispc_plane_setup
  OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
  OMAPDSS: Writeback: Add writeback capabilities
  OMAPDSS: DISPC: Configure overlay-like parameters in dispc_wb_setup
  OMAPDSS: DISPC: Setup writeback go, enable and channel_in functions
  OMAPDSS: Writeback: Configure writeback specific parameters
  OMAPDSS: Writeback: Use panel driver ops to configure mirroring
    rotation and buffer size
  OMAPDSS: Writeback: Add sysfs attributes to writeback panel
  OMAPDSS: DISPLAY: Add a manager apply to sysfs store attributes for
    writeback
  OMAPDSS: MANAGER: Split manager_display_store into smaller functions
  OMAPDSS: MANAGER: Add writeback as a sysfs attribute
  OMAPDSS: FEATURES: Allow WB panels to attach to managers

 drivers/media/video/omap/omap_vout.c     |   78 +++--
 drivers/video/omap2/dss/Makefile         |    2 +-
 drivers/video/omap2/dss/apply.c          |  549 +++++++++++++++++++++++++--
 drivers/video/omap2/dss/core.c           |    2 +
 drivers/video/omap2/dss/dispc.c          |  343 ++++++++++++-----
 drivers/video/omap2/dss/dispc.h          |   36 ++
 drivers/video/omap2/dss/display.c        |   23 +-
 drivers/video/omap2/dss/dss.h            |   39 ++-
 drivers/video/omap2/dss/dss_features.c   |   24 +-
 drivers/video/omap2/dss/dss_features.h   |    2 +
 drivers/video/omap2/dss/manager.c        |  125 ++++++-
 drivers/video/omap2/dss/overlay.c        |   27 +-
 drivers/video/omap2/dss/writeback.c      |  615 ++++++++++++++++++++++++++++++
 drivers/video/omap2/omapfb/omapfb-main.c |    7 +-
 drivers/video/omap2/omapfb/omapfb.h      |    5 +-
 include/video/omapdss.h                  |   52 +++-
 16 files changed, 1749 insertions(+), 180 deletions(-)
 create mode 100644 drivers/video/omap2/dss/writeback.c

-- 
1.7.4.1

