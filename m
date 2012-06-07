From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [CFT] PL08x patches
Date: Thu, 7 Jun 2012 11:45:27 +0100
Message-ID: <20120607104527.GA15973@n2100.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54148 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab2FGKpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:45:33 -0400
Content-Disposition: inline
In-Reply-To: <E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Here's the PL08x patches.

 drivers/dma/Kconfig        |    1 +
 drivers/dma/amba-pl08x.c   |  941 ++++++++++++++++++++++----------------------
 include/linux/amba/pl08x.h |  156 +-------
 3 files changed, 482 insertions(+), 616 deletions(-)

