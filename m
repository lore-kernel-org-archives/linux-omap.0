From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 0/2 V3] Enable DSS on zoom2/3 and 3630 sdp boards
Date: Thu, 25 Feb 2010 21:14:51 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026ECD464E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38942 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759369Ab0BYPow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 10:44:52 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Kishore Y <kishore.y@ti.com>

This patch series enables DSS and FB in zoom2, zoom3 and 3630sdp.

Changes from version 2:
  - incorporated cosmetic changes

OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
	- Included display in boards and enabled in defconfig
OMAP: DSS: Add display board file for zoom boards
	- Display board file added common for all boards

arch/arm/configs/omap_3630sdp_defconfig       |   60 ++++++++-
 arch/arm/configs/omap_zoom2_defconfig         |   60 ++++++++-
 arch/arm/configs/omap_zoom3_defconfig         |   60 ++++++++-
 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  185 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   36 +++++
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
 10 files changed, 407 insertions(+), 3 deletions(-)

Tested on top of LO kernel on dss2 brnach
commit id: 98d31bf6566be9e716f6dfdce8eb39d1c1097b7c 
OMAP: AM3517: Enable DSS2 for AM3517EVM board

Regards,
Kishore Y
