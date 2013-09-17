From: Archit Taneja <archit@ti.com>
Subject: [PATCH 00/11] omapdss: HDMI: Refactor driver for easier addition of OMAP5/DRA7 hdmi IP
Date: Tue, 17 Sep 2013 12:36:26 +0530
Message-ID: <1379401597-27222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49146 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab3IQHHc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Sep 2013 03:07:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The HDMI IP in OMAP4 DSS is present in a few other TI SoCs which don't have a
Display Subsystem similar to what's in OMAP. The original driver was designed
to provide ops such that it could be plugged into a different display subsytem
in some other SoC. These other SoCs, however, never got their baseport code
upstreamed, and the HDMI IP remains exclusive to OMAP DSS.

Refactor the code such that HDMI sub blocks(wrapper, PLL, PHY) are made into
libraries. The HDMI core IP(the encoder) is the only block which varies between
OMAP4 and OMAP5/DRA7 IPs. The rest can be shared by the 2 HDMI drivers.

This will allow more code reuse between the 2 HDMI drivers, and allow easier
addition of the OMAP5/DRA7 HDMI driver. The driver is also simplified now as it
doesn't need to provide ops to different display subsystems.

The new driver needs an address space split according to the HDMI sub blocks.
This requires us to change the OMAP4 hwmod data, or ensure that we add a split
address space when we add support for DSS in DT.

The last patch in the series splits the address space in omap4 hwmod data. If
hwmod changes are disregarded. The driver can temporarily be hacked to contain
the base addresses.

Archit Taneja (11):
  omapdss: HDMI: create a hdmi wrapper library
  omapdss: HDMI: create a HDMI PLL library
  omapdss: HDMI: create a PHY library
  omapdss: HDMI: Use OMAP4 HDMI core functions directly and remove
    hdmi_ip_ops
  omapdss: HDMI: remove hdmi_ip_data struct
  omapdss: HDMI: Clean up the header files
  omapdss: HDMI: add HDMI wrapper IRQ flags
  omapdss: HDMI: Rename hdmi driver files to nicer names
  omapdss: OMAP4: HDMI: remove unnecessary edid macros
  omapdss: HDMI: move common functions to a separate file
  [experimental] arm: omap: omap4 hwmod data: Split hdmi address space

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   19 +
 drivers/video/omap2/dss/Makefile           |    3 +-
 drivers/video/omap2/dss/core.c             |    4 +-
 drivers/video/omap2/dss/dss.h              |    4 +-
 drivers/video/omap2/dss/dss_features.c     |   44 -
 drivers/video/omap2/dss/dss_features.h     |    8 -
 drivers/video/omap2/dss/hdmi.c             | 1184 ----------------------
 drivers/video/omap2/dss/hdmi4.c            |  696 +++++++++++++
 drivers/video/omap2/dss/hdmi4_core.c       | 1016 +++++++++++++++++++
 drivers/video/omap2/dss/hdmi4_core.h       |  278 ++++++
 drivers/video/omap2/dss/hdmi_common.c      |  423 ++++++++
 drivers/video/omap2/dss/hdmi_phy.c         |  142 +++
 drivers/video/omap2/dss/hdmi_pll.c         |  212 ++++
 drivers/video/omap2/dss/hdmi_wp.c          |  254 +++++
 drivers/video/omap2/dss/ti_hdmi.h          |  403 ++++++--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c  | 1477 ----------------------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h  |  488 ---------
 17 files changed, 3377 insertions(+), 3278 deletions(-)
 delete mode 100644 drivers/video/omap2/dss/hdmi.c
 create mode 100644 drivers/video/omap2/dss/hdmi4.c
 create mode 100644 drivers/video/omap2/dss/hdmi4_core.c
 create mode 100644 drivers/video/omap2/dss/hdmi4_core.h
 create mode 100644 drivers/video/omap2/dss/hdmi_common.c
 create mode 100644 drivers/video/omap2/dss/hdmi_phy.c
 create mode 100644 drivers/video/omap2/dss/hdmi_pll.c
 create mode 100644 drivers/video/omap2/dss/hdmi_wp.c
 delete mode 100644 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
 delete mode 100644 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h

-- 
1.8.1.2

