From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
Date: Wed, 10 Oct 2012 10:36:53 -0400
Message-ID: <20121010143653.GD13724@beef>
References: <1349879449-22657-1-git-send-email-mporter@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB3B5BD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36534 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642Ab2JJOgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 10:36:03 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB3B5BD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Oct 10, 2012 at 02:33:54PM +0000, Vaibhav Hiremath wrote:
> On Wed, Oct 10, 2012 at 20:00:49, Porter, Matt wrote:
> > 6ea74cb ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage
> > exposes a bug in the AM33XX clock data for mcasp. After moving to
> > clk_get() usage, the _init() of all registered hwmods fails on mcasp0
> > due to incorrect clock data causing clk_get() to fail. This causes all
> > successive hwmods to fail to _init() leaving them in a bad state.
> > 
> > This patch updates the mcasp clock entries so clk_get() will succeed.
> > It is tested on BeagleBone and is needed for 3.7-rc1 to fix AM33xx
> > boot.
> > 
> 
> Matt,
> 
> I have already submitted patch for this and it is accepted and merged in 
> Tony's pull request.
> 
> https://patchwork.kernel.org/patch/1499271/

Heh, ok. My search skills failed badly when I ran into this.

Thanks :)

-Matt
