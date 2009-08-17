From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 00/20] OMAP ASoC changes in DMA utilization
Date: Mon, 17 Aug 2009 14:50:59 +0300
Message-ID: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23239 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901AbZHQMFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hello again guys,

Here is version 4 of these changes. No real changes from previous versions.
The only thing is that now I've rebased on top of Takashi's tree:
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=summary

as there are pending things there which Jarkko has pointed on previous series.

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
 sound/soc/omap/omap-mcbsp.c             |   78 ++++++-
 sound/soc/omap/omap-pcm.c               |   14 +-
 sound/soc/omap/omap-pcm.h               |    2 +
 6 files changed, 511 insertions(+), 14 deletions(-)

