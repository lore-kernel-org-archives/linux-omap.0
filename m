From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [CFT] SA11x0 patches
Date: Thu, 7 Jun 2012 11:42:06 +0100
Message-ID: <20120607104206.GA10488@n2100.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54131 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab2FGKmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:42:11 -0400
Content-Disposition: inline
In-Reply-To: <E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Updates to the SA11x0 DMA engine driver.  This fixes the residue
calculation, and implements cyclic transfers.

 drivers/dma/sa11x0-dma.c |  153 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 121 insertions(+), 32 deletions(-)

