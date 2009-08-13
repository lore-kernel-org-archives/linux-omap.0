From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 13 Aug 2009 17:35:13 +0300
Message-ID: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57816 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbZHMOsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 10:48:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hello again guys,

Here is version 3 of these changes. I've changed just 2
things:
- all mcbsp instances are in element mode by default
- moved all mcbsp related code to omap-mcbsp.c
(although a single callback is still needed)

Jarkko, I think we can add your patch for reading strings
for dma op mode later on.

BR,

Eduardo Valentin (11):
  OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1
    registers.
  OMAP: McBSP: Use appropriate value for startup delay
  OMAP: McBSP: Add transmit/receive threshold handler
  OMAP: McBSP: Create and export max_(r|t)x_thres property
  OMAP: McBSP: Rename thres sysfs symbols
  OMAP: McBSP: Change wakeup signals
  OMAP: McBSP: Configure NO IDLE mode for DMA mode different of
    threshold
  ASoC: OMAP: Make DMA 64 aligned
  ASoC: OMAP: Enable DMA burst mode
  ASoC: OMAP: Use McBSP threshold to playback and capture
  ASoC: OMAP: Use DMA operating mode of McBSP

Eero Nurkkala (7):
  OMAP: McBSP: Provide functions for ASoC frame syncronization
  OMAP: McBSP: Wakeups utilized
  OMAP: McBSP: Retain McBSP FCLK clockactivity
  OMAP: McBSP: Do not enable wakeups for no-idle mode
  OMAP: McBSP: Let element DMA mode hit retention also
  ASoC: Add runtime check for RFIG and XFIG
  ASoC: Always syncronize audio transfers on frames

Peter Ujfalusi (2):
  OMAP3: McBSP: Lower the maximum buffersize for McBSP1,3,4,5
  OMAP: McBSP: Add link DMA mode selection

 arch/arm/mach-omap2/mcbsp.c             |    5 +
 arch/arm/plat-omap/include/mach/mcbsp.h |   49 ++++
 arch/arm/plat-omap/mcbsp.c              |  377 ++++++++++++++++++++++++++++++-
 sound/soc/omap/omap-mcbsp.c             |   77 ++++++-
 sound/soc/omap/omap-pcm.c               |   14 +-
 sound/soc/omap/omap-pcm.h               |    2 +
 6 files changed, 511 insertions(+), 13 deletions(-)

