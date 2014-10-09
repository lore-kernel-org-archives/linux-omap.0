From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH 0/6] ARM: OMAP4+: hwmod: fixing omap4+ DSS hwmods
Date: Thu, 9 Oct 2014 17:03:13 +0300
Message-ID: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42409 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbaJIODa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Oct 2014 10:03:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

This is an RFC to fix the issues with boot time DSS hwmod setup.

There was an earlier series sent by Archit here:

http://www.spinics.net/lists/linux-omap/msg107700.html

This series takes different approach, and just tries to fix the issue at setup
time by making sure the DSS core hwmod is enabled when a DSS submodule hwmod is
being setup.

Quickly tested on OMAP4 Panda and OMAP5 uEVM.

 Tomi

Tomi Valkeinen (6):
  ARM: OMAP2+: hwmod: add parent_hwmod support
  ARM: OMAP5: hwmod: set DSS submodule parent hwmods
  ARM: OMAP4: hwmod: set DSS submodule parent hwmods
  ARM: OMAP4: hwmod: use MODULEMODE properly
  ARM: OMAP4: fix RFBI iclk
  ARM: dts: omap4.dtsi: remove dss_fck

 arch/arm/boot/dts/omap4.dtsi               |  2 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi     |  8 --------
 arch/arm/mach-omap2/omap_hwmod.c           | 22 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h           |  1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 25 ++++++++++++++++---------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  5 +++++
 6 files changed, 45 insertions(+), 18 deletions(-)

-- 
2.1.1

