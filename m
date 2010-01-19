From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 0/2] Enable DSS on zoom2/3 and 3630 sdp boards
Date: Tue, 19 Jan 2010 18:42:09 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DC23B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37643 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118Ab0ASNMF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:12:05 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Kishore Y <kishore.y@ti.com>

This patch series enables DSS and FB in zoom2, zoom3 and 3630sdp.

OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
	- Included display in boards and enabled in defconfig
OMAP: DSS: Add display board file for zoom boards
	- Display board file added common for all boards

 arch/arm/configs/omap_3630sdp_defconfig       |   60 +++++++-
 arch/arm/configs/omap_zoom2_defconfig         |   60 +++++++-
 arch/arm/configs/omap_zoom3_defconfig         |   60 +++++++-
 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  232 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   36 ++++
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
 10 files changed, 454 insertions(+), 3 deletions(-)

Tested on top of LO kernel commit id a468c9100977c3f163bfa9de7af1bbcb5dc5e260

Regards,
Kishore Y
