From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 00/26] OMAP dma engine rework
Date: Mon, 10 Feb 2014 15:55:31 +0000
Message-ID: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:59983 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751889AbaBJPzi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 10:55:38 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>

This is the current set of patches for the OMAP DMA engine rework,
which should now work correctly on OMAP1 platforms thanks to Tony's
testing.

It would be good to get this validated by others across a range of
OMAP platforms, and queued up for the next merge window, so it can
be built upon.

Acks appreciated, and once sufficient have been added, I'll send a
pull request for this to Vinod.

 arch/arm/mach-omap1/dma.c | 191 ++++++--------
 arch/arm/mach-omap2/dma.c | 183 ++++++-------
 arch/arm/plat-omap/dma.c  |  17 +-
 drivers/dma/omap-dma.c    | 659 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/omap-dma.h  |  25 +-
 5 files changed, 784 insertions(+), 291 deletions(-)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
