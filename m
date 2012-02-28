From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/10] OMAP/ASoC: Move and merge McBSP driver under ASoC
Date: Tue, 28 Feb 2012 09:40:10 +0200
Message-ID: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:41539 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753004Ab2B1Hkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:40:35 -0500
Received: by lagw12 with SMTP id w12so2264698lag.34
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:40:32 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

Hello,

Changes since v1 (RFC series):
- removed pm_runtime_get/put_sync calls since core takes care of this.
  Fixes the initial issue with OMAP3 Pandora setup reported by Grazvydas Ignotas
- Dropped my version of snd_soc_add_dai_controls from the series since Liam
  implementation adds the same functionality.
- Added Tested-by tags from Janusz (OMAP1), and Grazvydas (OMAP3 pandora)
- Added Ack from Tony for the arch/arm/ patches
- I have not added Ack from Mark, and Jarkko although they said it looks OK, but
  not given explicit ack for the series.

NOTE: this series has been generated agains Takashi's topic/asoc branch merged
with Mark's for-next branch since this series depends on changes in Marks'
branch, but not yet pulled by Takashi (snd_soc_add_dai_controls implementation
from Liam).

Intro mail from thre RFC series:

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

Regards,
Peter
---

Peter Ujfalusi (10):
  ARM: OMAP: mcbsp: Convert core driver to proper platform driver
  OMAP: mcbsp: Move core driver under sound/soc/omap
  ASoC: OMAP: McBSP: Consolidate plat/mcbsp.h content
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
 sound/soc/omap/Kconfig                         |    4 +
 sound/soc/omap/Makefile                        |    1 +
 sound/soc/omap/am3517evm.c                     |    2 +-
 sound/soc/omap/ams-delta.c                     |    2 +-
 sound/soc/omap/igep0020.c                      |    2 +-
 {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c |  470 ++++--------------------
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
 26 files changed, 598 insertions(+), 921 deletions(-)
 rename {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c (68%)
 create mode 100644 sound/soc/omap/mcbsp.h

-- 
1.7.8.4

