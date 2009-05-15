From: Mikkel Christensen <mlc@ti.com>
Subject: [PATCH v3 0/3] Support for OMAP3 Zoom2 board
Date: Fri, 15 May 2009 16:20:48 -0500
Message-ID: <1242422451-21551-1-git-send-email-mlc@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbZEOVQs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 May 2009 17:16:48 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4FLGj8W024343
	for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 16:16:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mikkel Christensen <mlc@ti.com>

The following patch series adds support for Zoom2 board.
This is a new version made after comments from Kevin Hilman.

An external debug board is included for console and LAN.

For details refer to this site:
http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap34x-ii-mdp

Future work:
 - SMSC911x NFS mount problem
 - Low level debug uart need to use debug board

TI wiki with FAQs on getting this board booting:
https://omapzoom.org/gf/project/omapzoom/wiki/?pagename=GettingStartedWithZoomII_AKA_OMAP34XII_MDP

Diffstat:
 configs/omap3_zoom2_defconfig       | 1211 ++++++++++++++++++++++++++++++++++++
 mach-omap2/Kconfig                  |    5 
 mach-omap2/Makefile                 |    4 
 mach-omap2/board-zoom2-debugboard.c |  161 ++++
 mach-omap2/board-zoom2.c            |  107 +++
 5 files changed, 1487 insertions(+), 1 deletion(-)
