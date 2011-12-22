From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] OMAP4: Fix CLKR/FSR mux for port with 6 pin mode
Date: Thu, 22 Dec 2011 19:31:41 +0200
Message-ID: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52029 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753226Ab1LVRbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:31:55 -0500
Received: by lagy4 with SMTP id y4so43604lag.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:31:52 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series will fix the CLKR/FSR signal mux configuration for OMAP4 devices.
McBSP4 has 6 pin configuration on McBSP4 port while OMAP2/3 has the same
capability on McBSP1 port.
The API for mux control will be simplified for the mcbsp users (ASoC).

The series depends on earlier series sent for mcbsp:
OMAP4: McBSP: Fix clock reparenting

I think the ASoC patch can go via linux-omap, since we do not have other changes
for McBSP coming via sound tree.

Regards,
Peter
---
Peter Ujfalusi (5):
  OMAP2/3: mcbsp: Check McBSP port number in CLKR/FSR mux callback
  OMAP: mcbsp: Signle function for CLKR/FSR source mux configuration
  ASoC: omap-mcbsp: Use the new interface for configuring CLKR/FSR mux
  OMAP: mcbsp: Remove old CLKR/FSR mux functions
  OMAP4: mcbsp: Callback function for McBSP4 CLKR/FSR mux selection

 arch/arm/mach-omap2/mcbsp.c             |   47 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h |   15 ++++------
 arch/arm/plat-omap/mcbsp.c              |   49 +++++++++++++++----------------
 sound/soc/omap/omap-mcbsp.c             |   12 +++++--
 4 files changed, 85 insertions(+), 38 deletions(-)

-- 
1.7.8.1

