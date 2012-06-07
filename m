From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT 06/11] ARM: omap: remove mmc platform data dma_mask and
 initialization
Date: Thu, 7 Jun 2012 10:06:32 -0700
Message-ID: <20120607170631.GI12766@atomide.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaZa-0003tu-OD@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18413 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759982Ab2FGRGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 13:06:36 -0400
Content-Disposition: inline
In-Reply-To: <E1ScaZa-0003tu-OD@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:12]:
> DMAengine uses the DMA engine device structure when mapping/unmapping
> memory for DMA, so the MMC devices do not need their DMA masks
> initialized (this reflects hardware: the MMC device is not the device
> doing DMA.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Tony Lindgren <tony@atomide.com>
