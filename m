From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
Date: Tue,  5 Oct 2010 09:45:38 +0300
Message-ID: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:20674 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584Ab0JEGp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:45:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

Hello,

This v5 series is based on the v3.
The first two patch is the actual fix for the original problems without any
major change in the code (only handling the corresponding erratas in the legacy
way).
The third patch in the series is optional, and it is implementing (in one patch)
the errata handling via flags. This patch converts all errata cases to use the
introduced dma_errata variable via macros.

Tony: the first two patch need to go for 2.6.36, and if it is possible it shall
be backported to .33, .34, and .35 as well.
The final patch in this series is optional, if you feel like you can take it
(or drop it). AFAIK the upcoming hwmod changes to dma code will also have
similar feature to handle the erratas.
I'm not sure what is the schedule for the hwmod conversion of dma...

Changes since v4:
- OMAP2 Errata comment replaced with better description from
  G, Manjunath Kondaiah <manjugk@ti.com>.
- Fixed Jarkko Nikula's name in the first patch
- Based on v3 series (with suggested changes applied on top)
Changes since v3:
- OMAP2 errata is applicaple only to OMAP2420 and ES1.0 of OMAP2430
  noticed by G, Manjunath Kondaiah <manjugk@ti.com>
- use flags for errata handling
 - OMAP2 buffering disable converted to use flags
 - OMAP3 i541 is using the dma_errata flag
- Spelling fix in OMAP3 drain timeout message
Changes since v2:
- remove multiple assignment
Changes since v1:
- Errata ID added to the comment (i541)

Intro mail from v1:

The following series fixes the sDMA FIFO drain issue present for OMAP2 and
OMAP3, and covered by an errata.
For OMAP2 the omap_start_dma had a comment about this errata, but the workaround
configured wrong bit (CCR_EN instead of the correct BUFFERING_DISABLE bit).
The first patch from Jarkko Nikula <jhnikula@gmail.com> fixes this.
For OMAP3 the suggestion is to set sDMA to NoStandby before disabling
the channel, and wait for the drain to finish, than configure sDMA to
SmartStandby again. The second patch implements this workaround for OMAP3.

The FIFO drain problem can be reproduced on both OMAP2 and OMAP3 while using
audio (capture case):
Either introduce load to the CPU:
nice -19 arecord -D hw:0 -M -B 10000 -F 5000 -f dat > /dev/null & \
dd if=/dev/urandom of=/dev/null

or suspending the arecord, and resuming it:
arecord -D hw:0 -M -B 10000 -F 5000 -f dat > /dev/null
CTRL+Z; fg; CTRL+Z; fg; ...

On OMAP2 we can not recover from this problem. The board has to be rebooted,
while OMAP3 can be recovered by reseting the sDMA channel, or introducing
unrelated sDMA activity (which takes sDMA out from Standby - but this is not
working all the time).

---
Jarkko Nikula (1):
  omap: dma: Fix buffering disable bit setting for omap24xx

Peter Ujfalusi (2):
  OMAP3: DMA: Errata i541: sDMA FIFO draining does not finish
  OMAP: DMA: Use flags for errata handling

 arch/arm/plat-omap/dma.c              |   88 +++++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/dma.h |    4 ++
 2 files changed, 82 insertions(+), 10 deletions(-)

--
1.7.3.1

