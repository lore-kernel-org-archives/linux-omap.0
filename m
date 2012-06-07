From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [CFT] DMA engine patches
Date: Thu, 7 Jun 2012 11:34:34 +0100
Message-ID: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54094 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2FGKeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:34:46 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

I am intending to post the _entire_ set of DMA patches I have so far.
I'm going to be doing this in a slightly different way to normal,
because of the way the branches are structured.

What will come first is a set of three common patches to all the
branches.  Following on from that will be the individual sets for
sa11x0, pl08x and OMAP.

These are for testing, and are based on v3.5-rc1.

 drivers/dma/Kconfig      |    4 +
 drivers/dma/Makefile     |    1 +
 drivers/dma/sa11x0-dma.c |  249 ++++++++++++++-------------------------------
 drivers/dma/virt-dma.c   |  123 +++++++++++++++++++++++
 drivers/dma/virt-dma.h   |  152 ++++++++++++++++++++++++++++
 5 files changed, 358 insertions(+), 171 deletions(-)

