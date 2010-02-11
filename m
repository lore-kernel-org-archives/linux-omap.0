From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 0/2] Enable DSS on zoom2/3 and 3630 sdp boards
Date: Thu, 11 Feb 2010 15:32:32 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E8B92@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60533 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab0BKKCE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 05:02:04 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

From: Kishore Y <kishore.y@ti.com>

This patch series enables DSS and FB in zoom2, zoom3 and 3630sdp.

Changes from version 1:
  - removed regulator framework calls
  - removed compiler warnings

OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
	- Included display in boards and enabled in defconfig
OMAP: DSS: Add display board file for zoom boards
	- Display board file added common for all boards

 arch/arm/configs/omap_3630sdp_defconfig       |   60 ++++++++-
 arch/arm/configs/omap_zoom2_defconfig         |   60 ++++++++-
 arch/arm/configs/omap_zoom3_defconfig         |   60 ++++++++-
 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  188 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   36 +++++
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
 drivers/video/omap2/dss/dpi.c                 |    2 +-
 11 files changed, 411 insertions(+), 4 deletions(-)

Tested on top of LO kernel on dss2 brnach
commit id: 33b601093c6d5f5b18abcbd2de736d300d837f91
OMAP: DSS2: DSI: remove dsi_vc_print_status()

Regards,
Kishore Y
