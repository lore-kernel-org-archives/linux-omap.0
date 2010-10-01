From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2]  OMAP2/3: DMA: FIFO drain errata fixes
Date: Fri,  1 Oct 2010 09:39:04 +0300
Message-ID: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:30902 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab0JAGjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 02:39:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Hello,

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

PS: the same errata might exist for OMAP4, but we are not able to verify it.

---
Jarkko Nikula (1):
  omap: dma: Fix buffering disable bit setting for omap24xx

Peter Ujfalusi (1):
  OMAP3: DMA: Errata: sDMA FIFO draining does not finish

 arch/arm/plat-omap/dma.c              |   37 ++++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/dma.h |    4 +++
 2 files changed, 38 insertions(+), 3 deletions(-)

--
1.7.3

