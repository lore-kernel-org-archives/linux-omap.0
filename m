From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 0/6] Devkit8000: Fixes for power regulator
Date: Sat,  8 May 2010 06:31:17 +0200
Message-ID: <1273293083-24063-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53463 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0EHEb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 May 2010 00:31:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

These patches fixes some errors in the usage of the 
power regulator.

The Devkit8000 uses the TPS65930, an reduced version of the TWL4030. 
So not all power supplies from the TWL4030 are available.
There were also a wrong comment about the pins supported by the vmmc1. 
The DSS2 do not need a VDVI any longer so it is removed. 
The definition of the supplies are changed to use the new REGULATOR_SUPPLY macro.

Thomas Weber (6):
  Devkit8000: Fix the power supply for ads7846
  Devkit8000: Remove unneeded VDVI
  Devkit8000: Remove nonexisting vsim
  Devkit8000: Using the REGULATOR_SUPPLY macro
  Devkit8000: Fix comment
  Devkit8000: Change twl4030 to tps65930

 arch/arm/mach-omap2/board-devkit8000.c |   73 +++++++++++++-------------------
 1 files changed, 30 insertions(+), 43 deletions(-)

