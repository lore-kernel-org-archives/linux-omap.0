From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/6] omapdss: hdmi: Add support for hdmi on OMAP5 and DRA7x SoCs
Date: Thu, 17 Oct 2013 16:56:36 +0530
Message-ID: <1382009202-18984-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab3JQL1e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Oct 2013 07:27:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The HDMI IP on OMAP5/DRA7xx has very similar wrapper, PLL and PHY sub blocks
found in OMAP4 DSS. However, the HDMI core IP(which implements the HDMI
protocol) is completely new.

Create a library for configuring the new HDMI core IP, make minor modifications
in PLL and PHY. And finally, add a hdmi5 driver. This driver can eventually be
merged with the hdmi4 driver such that both of them use the same driver, we
would need to create core IP ops for that, we've left that for later.

Archit Taneja (6):
  omapdss: hdmi: support larger register offsets for OMAP5 HDMI core
  omapdss: hdmi: Add initial OMAP5/DRA7x HDMI core IP library
  omapdss: hdmi phy: Incorporate changes for OMAP5/DRA7x
  omapdss: hdmi pll: Incorporate changes for OMAP5/DRA7x
  omapdss: hdmi: add OMAP5/DRA7x hdmi driver
  omapdss: hdmi4/hdmi5: set regulator voltage to required level

 drivers/video/omap2/dss/Kconfig      |  10 +
 drivers/video/omap2/dss/Makefile     |   2 +
 drivers/video/omap2/dss/core.c       |   6 +
 drivers/video/omap2/dss/dss.h        |   3 +
 drivers/video/omap2/dss/hdmi.h       |   7 +-
 drivers/video/omap2/dss/hdmi4.c      |   5 +
 drivers/video/omap2/dss/hdmi5.c      | 704 ++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi5_core.c | 812 +++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi5_core.h | 298 +++++++++++++
 drivers/video/omap2/dss/hdmi_phy.c   |  94 +++-
 drivers/video/omap2/dss/hdmi_pll.c   |  74 +++-
 drivers/video/omap2/dss/hdmi_wp.c    |   2 +-
 12 files changed, 2008 insertions(+), 9 deletions(-)
 create mode 100644 drivers/video/omap2/dss/hdmi5.c
 create mode 100644 drivers/video/omap2/dss/hdmi5_core.c
 create mode 100644 drivers/video/omap2/dss/hdmi5_core.h

-- 
1.8.1.2

