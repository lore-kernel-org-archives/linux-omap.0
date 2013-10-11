From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Run make savedefconfig on
 omap2plus_defconfig to shrink it
Date: Thu, 10 Oct 2013 17:44:11 -0700
Message-ID: <20131011004411.GL29913@atomide.com>
References: <20131010230325.8152.27727.stgit@localhost>
 <20131010230440.8152.29871.stgit@localhost>
 <5257415A.7090600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63506 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab3JKAoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 20:44:16 -0400
Content-Disposition: inline
In-Reply-To: <5257415A.7090600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm@ti.com> [131010 17:15]:
> On Thursday 10 October 2013 06:04 PM, Tony Lindgren wrote:
> > -CONFIG_TI_DAVINCI_MDIO=y
> > -CONFIG_TI_DAVINCI_CPDMA=y
> > -CONFIG_TI_CPSW=y
> > -CONFIG_AT803X_PHY=y
> Can you keep the above defines as AM335x EVM, Beagle bone, Beagle bone
> black can use ethernet with omap2plus_defconfig

I think they should get automatically selected by
default with make omap2plus_defconfig, I don't think make
savedefconfig removes any selected features.

Maybe check it though with this patch?

Regards,

Tony
