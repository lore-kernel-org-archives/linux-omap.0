From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/3] ARM/ASoC: OMAP McBSP: Correct CLKR/FSR source selection
Date: Thu,  8 Mar 2012 11:22:14 +0200
Message-ID: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:52145 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755252Ab2CHJW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 04:22:28 -0500
Received: by mail-lpp01m010-f45.google.com with SMTP id e6so292244lah.4
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 01:22:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Changes since v1:
- Adapted to the moved mcbsp code which helped to reduce the number of patches
  from 5 to 3.
- Clock selection related defines moved from arch to ASoC header.

No change in functionality otherwise.

This series fixes the CLKR/FSR mux selection (on McBSP ports with 6 pin setup).
OMAP2/3 has 6 pin setup on McBSP1 port while OMAP4 has the 6 pin setup on McBSP4
port.
Add support for OMAP4 CLKR/FSR source selection, and simplify the ASoC part of
CLK mux configuration.

This series should go via ASoC with the rest of McBSP changes.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: OMAP2+: McBSP: Correct CLKR/FSR clock source mux configuration
  ARM/ASoC: OMAP McBSP: Move remainig defines from arch to ASoC header
  ASoC: omap-mcbsp: Single function CLKR/FSR source mux configuration

 arch/arm/mach-omap2/mcbsp.c             |   46 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/mcbsp.h |   12 --------
 sound/soc/omap/mcbsp.c                  |   48 ++++++++++++++----------------
 sound/soc/omap/mcbsp.h                  |   13 +++++++-
 sound/soc/omap/omap-mcbsp.c             |    8 ++--
 5 files changed, 81 insertions(+), 46 deletions(-)

-- 
1.7.8.5

