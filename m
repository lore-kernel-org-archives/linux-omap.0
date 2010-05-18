From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 00/14] Multiple fixes for Devkit8000
Date: Tue, 18 May 2010 14:05:21 +0200
Message-ID: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54916 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757414Ab0ERMGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Some of these patches were submitted earlier but got no comments
so I am sending them one more time. 

These patches correct errors that were done while using the board code
from beagle board for Devkit8000. 

The Devkit8000 uses the TPS65930, an reduced version of the TWL4030. 
So not all power supplies from the TWL4030 are available.
There were also a wrong comment about the pins supported by the vmmc1. 
The DSS2 do not need a VDVI any longer so it is removed. 
The definition of the supplies are changed to use the new REGULATOR_SUPPLY macro.
The pins for lcd and dvi powerdown are corrected.


Kan-Ru Chen (1):
  OMAP2: Devkit8000: Setup LCD reset

Thomas Weber (13):
  OMAP2: Devkit8000: Cleanup for supplies
  OMAP2: Devkit8000: change lcd panel to generic
  OMAP2: Devkit8000: Enable DVI-D output
  OMAP2: Devkit8000: Remove unneeded VDVI
  OMAP2: Devkit8000: Remove nonexisting vsim
  OMAP2: Devkit8000: Remove en-/disable for tv panel
  OMAP2: Devkit8000: Use the REGULATOR_SUPPLY macro
  OMAP2: Devkit8000: Fixing comment about pins used
  OMAP2: Devkit8000: Fix whitespace with tab
  OMAP2: Devkit8000: Fix comment
  OMAP2: Devkit8000: Using gpio_is_valid
  OMAP2: Devkit8000: Remove unused omap_board_config
  OMAP2: Devkit8000: Correct regulator

 arch/arm/mach-omap2/board-devkit8000.c |  125 +++++++++++++++-----------------
 1 files changed, 58 insertions(+), 67 deletions(-)

