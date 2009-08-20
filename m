From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 20 Aug 2009 16:22:03 +0300
Message-ID: <1250774523-7950-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48501 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbZHTNgW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 09:36:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>, Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hello guys,

I've updated this series after some previous confusion from my side.

Now that all dependencies are merged (Janusz's patches and Jarkko's patch),
I've based this series on Takashi's tree (master branch).

I've also talked with Tony and he agrees to have this changes merged
by alsa tree. And as pointed by Jarkko, the mcbsp code is currently
used only by Audio inside OMAP code. So, that should be safe.

It is the same series. It now includes patch description for
every patch. And also, as I already said, it is based on master
branch of sound-2.6.

Tested with beagle and rx51. Compiled tested for n770.

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
  ASoC: OMAP: Enable DMA burst mode
  ASoC: OMAP: Make DMA 64 aligned
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

