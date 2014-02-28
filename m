From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] OMAP2+: hwmod: Add support to parse clock info
 from DT
Date: Fri, 28 Feb 2014 13:56:16 -0800
Message-ID: <20140228215615.GD13624@atomide.com>
References: <1386848309-14076-1-git-send-email-rnayak@ti.com>
 <20131213173110.GF28184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65067 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaB1V42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 16:56:28 -0500
Content-Disposition: inline
In-Reply-To: <20131213173110.GF28184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, mark.rutland@arm.com, mturquette@linaro.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131213 09:32]:
> * Rajendra Nayak <rnayak@ti.com> [131212 03:40]:
> > v1 of this series was posted a while back [1] but there wasn't much that
> > was concluded if the approach used in the series was acceptable or if there
> > are better alternatives. So I am just doing a repost of these to see if we
> > can conclude this time around.
> > 
> > Needless to say, patches are based off Teros omap-clocks-to-dt v10 series [2]
> > and I also pulled in Tonys fix to handle DT nodes with multiple 'ti,hwmod'
> > values [3]. The approach taken in the series *does not* work for cases with
> > multiple 'ti,hwmod' values and hence [3] helps me skip those instances
> > for now. But based on some of the recent discussions on multiple 'ti-hwmod'
> > values [4] it looks like its generally agreed upon that having DT nodes with
> > multiple 'ti-hwmod' property is wrong and that those instances need to be
> > fixed up anyway.
> 
> Yeah we need to have 1-to-1 mapping of device entries in the .dtsi files
> to the device entries in the omap_hwmod_*_data.c files. And then we can
> just deprecate "ti,hwmods" property and start parsing the standard compatible
> flag instead.

FYI seems like this series needs some dependencies solved first, so assuming
you'll be resposting this.

Regards,

Tony

  
> > [1] http://www.spinics.net/lists/linux-omap/msg95746.html
> > [2] http://www.spinics.net/lists/devicetree/msg13455.html
> > [3] http://www.spinics.net/lists/arm-kernel/msg288036.html
> > [4] http://www.spinics.net/lists/arm-kernel/msg288023.html
> > 
> > Rajendra Nayak (3):
> >   ARM: OMAP2+: Add support to parse 'main_clk' info from DT
> >   ARM: OMAP2+: Add support to parse optional clk info from DT
> >   ARM: OMAP4: dts: Add main and optional clock data into DT
> > 
> >  arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod.c           |   88 ++++++++++++++++++--
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  122 ----------------------------
> >  3 files changed, 180 insertions(+), 130 deletions(-)
> > 
> > -- 
> > 1.7.9.5
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
