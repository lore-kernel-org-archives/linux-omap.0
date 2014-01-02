From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Thu, 2 Jan 2014 15:08:36 +0000
Message-ID: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54033 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751136AbaABPJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:09:19 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>

The following patch series moves code to setup the DMA hardware and
service interrupts from the hardware to the DMA engine driver.  This
reduces the dependency on the legacy DMA implementation.

This series does not remove the channel allocation/freeing hooks which
are used to manage the allocation of physical channels - this is the
next step in the evolution.

The patches which move the interrupt handling are currently less than
perfect since they're writing to ENABLE_L0 under a different spinlock,
and hence RFC only at the moment.

 arch/arm/mach-omap1/dma.c |  183 +++++--------
 arch/arm/mach-omap2/dma.c |  183 ++++++--------
 arch/arm/plat-omap/dma.c  |   17 +-
 drivers/dma/omap-dma.c    |  653 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/omap-dma.h  |   25 ++-
 5 files changed, 774 insertions(+), 287 deletions(-)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
