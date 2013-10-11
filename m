From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Run make savedefconfig on
 omap2plus_defconfig to shrink it
Date: Fri, 11 Oct 2013 08:59:49 -0700
Message-ID: <20131011155949.GQ29913@atomide.com>
References: <20131010230325.8152.27727.stgit@localhost>
 <20131010230440.8152.29871.stgit@localhost>
 <5257415A.7090600@ti.com>
 <20131011004411.GL29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59968 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110Ab3JKP7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 11:59:52 -0400
Content-Disposition: inline
In-Reply-To: <20131011004411.GL29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131010 17:52]:
> * Mugunthan V N <mugunthanvnm@ti.com> [131010 17:15]:
> > On Thursday 10 October 2013 06:04 PM, Tony Lindgren wrote:
> > > -CONFIG_TI_DAVINCI_MDIO=y
> > > -CONFIG_TI_DAVINCI_CPDMA=y
> > > -CONFIG_TI_CPSW=y
> > > -CONFIG_AT803X_PHY=y
> > Can you keep the above defines as AM335x EVM, Beagle bone, Beagle bone
> > black can use ethernet with omap2plus_defconfig
> 
> I think they should get automatically selected by
> default with make omap2plus_defconfig, I don't think make
> savedefconfig removes any selected features.
> 
> Maybe check it though with this patch?

I've confirmed these are automatically selected after
doing make omap2plus_defconfig. They seem to be selected by
CONFIG_TI_CPSW=y that stays in the omap2plus_defconfig after
doing make save_defconfig, looks like it just moves around a
bit after doing make save_defconfig.

BTW, why do we get edma warnings during boot on systems with no 
edma like on omap4:

edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver

That's just confusing.

Regards,

Tony
