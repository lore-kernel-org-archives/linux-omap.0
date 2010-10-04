From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v4 0/4] OMAP2/3: DMA: FIFO drain errata fixes
Date: Mon,  4 Oct 2010 11:18:10 +0300
Message-ID: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:58258 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0JDISZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 04:18:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello,

Changes since v3:
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
Peter Ujfalusi (3):
  OMAP: DMA: Introduce errata handling variable, and macro
  OMAP2: DMA: Use errata flag for disabling buffering
  OMAP3: DMA: Errata i541: sDMA FIFO draining does not finish

ext Jarkko Nikula (1):
  omap: dma: Fix buffering disable bit setting for omap24xx

 arch/arm/plat-omap/dma.c              |   60 ++++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/dma.h |    4 ++
 2 files changed, 60 insertions(+), 4 deletions(-)

--
1.7.3

