From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 30 Jul 2009 15:49:23 +0300
Message-ID: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25891 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZG3NA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:00:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hellos guys,


This series provides a way to allow DMA go to idle while performing
playback/capture in OMAP3 devices using ASoC driver.

The idea behind it is to do not use DMA element mode, but frame mode.
In addition to that, it also configures McBSP threshold accordingly to
alsa period. Also, McBSP wakeup signals are configured to generate
wakeups for threshold events.

Besides that, this series also include a way to allow choosing between
element mode or the frame mode added here.

Patches 1-15 are McBSP changes and, for this reason, are intended to
be include in linux-omap tree.
Patches 16-20 are OMAP ASoC driver changes, so, they are for alsa-devel.

BR,

Eduardo Valentin (11):
  OMAP: McBSP: Change wakeup signals
  OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1
    registers.
  OMAP: McBSP: Use appropriate value for startup delay
  OMAP: McBSP: Add transmit/receive threshold handler
  OMAP: McBSP: Create and export max_(r|t)x_thres property
  OMAP: McBSP: Rename thres sysfs symbols
  OMAP: McBSP: Configure NO IDLE mode for DMA mode different of
    threshold
  ASoC: OMAP: Use McBSP threshold again
  ASoC: OMAP: Make DMA 64 aligned
  ASoC: OMAP: Enable DMA burst mode
  ASoC: OMAP: Use DMA operating mode of McBSP

Eero Nurkkala (7):
  OMAP: McBSP: Provide functions for ASoC frame syncronization
  OMAP: McBSP: Wakeups utilized
  OMAP: McBSP: Retain McBSP FCLK clockactivity
  OMAP: McBSP: Do not enable wakeups for no-idle mode
  OMAP: McBSP: Disable all wakeups upon exit
  OMAP: McBSP: Let element DMA mode hit retention also
  ASoC: Always syncronize audio transfers on frames

Peter Ujfalusi (2):
  OMAP3: McBSP: Lower the maximum buffersize for McBSP1,3,4,5
  OMAP: McBSP: Add link DMA mode selection

 arch/arm/mach-omap2/mcbsp.c             |    5 +
 arch/arm/plat-omap/include/mach/mcbsp.h |   54 +++++
 arch/arm/plat-omap/mcbsp.c              |  343 ++++++++++++++++++++++++++++++-
 sound/soc/omap/omap-mcbsp.c             |   16 ++-
 sound/soc/omap/omap-pcm.c               |   57 +++++-
 5 files changed, 468 insertions(+), 7 deletions(-)

