From: Archit Taneja <archit@ti.com>
Subject: [PATCH 00/10] OMAP: DSS2: DSI: Initial DSI video mode support
Date: Tue, 30 Aug 2011 16:21:25 +0530
Message-ID: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37601 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898Ab1H3KxH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 06:53:07 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UAr6cv009661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:06 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7UAr5ZV004741
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:05 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UAr575024919
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:05 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This provided initial support for DSI Video Mode. The first 6 patches are
not directly related to video mode, but they add required features and cleanup
for supporting video mode cleanly.

Support for a panel driver supporting video mode is not added yet since no
OMAP platfrom support in mainline has a video mode panel.

The Blaze tablet with the toshiba bridge chip "TC358765" is used as an example
to validate video mode support. The patches to enable blaze tablet and the
bridge chip are provided in the following tree along with the DSI video mode
patches:

https://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone/commits/video-mode-4

Archit Taneja (10):
  OMAP: DSS2: Use MIPI DSI transacition types and commands from
    include/video/mipi_display.h
  OMAP: DSS2: DSI: Represent L4 and VP as sources of VC instead of
    modes
  OMAP: DSS2: Create enum for DSI operation modes
  OMAP: DSS2: DSI: Introduce generic write functions
  OMAP: DSS2: DSI: Remove functions dsi_vc_dcs_read_1() and
    dsi_vc_dcs_read_2()
  OMAP: DSS2: DSI: Split dsi_vc_dcs_read() into 2 functions
  OMAP: DSS2: DSI: Introduce generic read functions
  OMAP: DSS2: Clean up stallmode and io pad mode selection
  OMAP: DSS2: Create an enum for DSI pixel formats
  OMAP: DSS2: DSI Video mode support

 drivers/video/omap2/displays/panel-taal.c |   47 +--
 drivers/video/omap2/dss/dispc.c           |   47 +--
 drivers/video/omap2/dss/dpi.c             |    5 +-
 drivers/video/omap2/dss/dsi.c             |  675 ++++++++++++++++++++++-------
 drivers/video/omap2/dss/dss.h             |   17 +-
 drivers/video/omap2/dss/rfbi.c            |    4 +-
 drivers/video/omap2/dss/sdi.c             |    4 +-
 include/video/omapdss.h                   |   69 +++-
 8 files changed, 636 insertions(+), 232 deletions(-)

