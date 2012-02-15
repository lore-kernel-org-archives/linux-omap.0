From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
Date: Wed, 15 Feb 2012 17:37:49 +0200
Message-ID: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59534 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179Ab2BOPiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:00 -0500
Received: by mail-lpp01m010-f42.google.com with SMTP id k11so2520022lag.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:37:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

Hello,

The aim of this series is to move the plat-omap/mcbsp.c driver out to
sound/soc/omap/
By doing this we can combine the two levels of McBSP driver stack into a single
one.
Formally we had omap-mcbsp.[1-X] drivers (plat-omap/mcbsp.c), and
omap-mcbsp-dai.[0-(X-1) drivers (sound/soc/omap/omap-mcbsp.c).
We had global, shared structures, variables, pointers. The API between the two
driver was a set of exported function calls where one of the parameter was the
McBSP port id.

With this series we will have one driver for McBSP (omap-mcbsp.[1-X]) which is
basically the ASoC dai driver. All exported/shared global structures are gone
since we can use driver data for all ports in this way.

With the code in one place we can do further clean up in the McBSP driver, and
adding new features will be much easier in the future. Also the DT support for
McBSP will be significantly easier if we have one set of driver.

McBSP is only used by audio, there are no known other users of the OMAP McBSP
(well, Nokia n700 has the WLAN connected through McBSP but we do not have
driver for that anyway).

The series was created against Takashi's topic/asoc branch. I have tested it on
Beagle xM, and compile tested it for OMAP1, OMAP2, and OMAP4 as well.

I'm going to do more work on the cleanup, and the plan is to merge the two files
into one (mcbsp.c -> omap-mcbsp.c) eventually.

Comments, testers are welcome...

CC-ing Samuel as well since he is the original author of the plat-omap/mcbsp.c
driver.

Regards,
Peter
---
Peter Ujfalusi (11):
  ARM: OMAP: mcbsp: Convert core driver to proper platform driver
  OMAP: mcbsp: Move core driver under sound/soc/omap
  ASoC: OMAP: McBSP: Consolidate plat/mcbsp.h content
  ASoC: core - Add API call to register dai kcontrols.
  ASoC: omap-mcbsp: Create a single driver for McBSP
  ARM: OMAP: Do not register omap-mcbsp-dai device
  ASoC: OMAP: mcbsp.h: Clean up bit definitions
  ASoC: OMAP McBSP: Remove redundant accessors
  ASoC: omap-mcbsp: Cleanup of module probe/remove code
  ASoC: omap-mcbsp: Merge the omap_mcbsp_data into omap_mcbsp structure
  ASoC: omap-mcbsp: Simplify DMA configuration

 arch/arm/mach-omap1/devices.c                  |    9 -
 arch/arm/mach-omap1/mcbsp.c                    |   14 +-
 arch/arm/mach-omap2/devices.c                  |   22 --
 arch/arm/mach-omap2/mcbsp.c                    |    8 +-
 arch/arm/plat-omap/Kconfig                     |    8 -
 arch/arm/plat-omap/Makefile                    |    2 -
 arch/arm/plat-omap/include/plat/mcbsp.h        |  321 ----------------
 include/sound/soc.h                            |    2 +
 sound/soc/omap/Kconfig                         |    4 +
 sound/soc/omap/Makefile                        |    1 +
 sound/soc/omap/am3517evm.c                     |    2 +-
 sound/soc/omap/ams-delta.c                     |    2 +-
 sound/soc/omap/igep0020.c                      |    2 +-
 {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c |  463 ++++--------------------
 sound/soc/omap/mcbsp.h                         |  337 +++++++++++++++++
 sound/soc/omap/n810.c                          |    2 +-
 sound/soc/omap/omap-mcbsp.c                    |  287 ++++++++-------
 sound/soc/omap/omap-mcbsp.h                    |    2 +-
 sound/soc/omap/omap-pcm.h                      |    2 +
 sound/soc/omap/omap3beagle.c                   |    2 +-
 sound/soc/omap/omap3evm.c                      |    2 +-
 sound/soc/omap/omap3pandora.c                  |    4 +-
 sound/soc/omap/osk5912.c                       |    2 +-
 sound/soc/omap/overo.c                         |    2 +-
 sound/soc/omap/rx51.c                          |    4 +-
 sound/soc/omap/sdp3430.c                       |    4 +-
 sound/soc/omap/zoom2.c                         |    4 +-
 sound/soc/soc-core.c                           |   31 ++
 28 files changed, 631 insertions(+), 914 deletions(-)
 rename {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c (69%)
 create mode 100644 sound/soc/omap/mcbsp.h

-- 
1.7.8.4

