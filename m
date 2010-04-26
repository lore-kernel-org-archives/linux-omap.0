From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 0/2 V6] Enable DSS on zoom2/3 and 3630 sdp boards
Date: Mon, 26 Apr 2010 18:36:06 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E3049@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45031 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab0DZNEu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 09:04:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Kishore Y <kishore.y@ti.com>

This patch series enables DSS and FB in zoom2, zoom3 and 3630sdp.

Changes from version 5:
  - incorporated changes suggested by Vaibhav

OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
	- Included display in boards and enabled in defconfig
OMAP: DSS: Add display board file for zoom boards
	- Display board file added common for all boards

 arch/arm/configs/omap_3630sdp_defconfig       |   60 +++++++++-
 arch/arm/configs/omap_zoom2_defconfig         |   60 +++++++++-
 arch/arm/configs/omap_zoom3_defconfig         |   60 +++++++++-
 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  158 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   48 ++++++++-
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
 10 files changed, 391 insertions(+), 4 deletions(-)

Tested on top of LO kernel on master branch
commit id: 7df1702e6cc94c3b3a3ebb69b6462bfaad9050da
Linux-omap rebuilt: Merged in updated omap-fixes

Regards,
Kishore Y
