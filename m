From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 30 Oct 2012 14:04:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301400100.12697@utopia.booyaka.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com> <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com> <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi> <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com> <20121029200032.GD30152@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com> <20121030123254.GD29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com> <20121030125419.GG29095@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2J3OE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 10:04:26 -0400
In-Reply-To: <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>
Cc: aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Tue, 30 Oct 2012, Paul Walmsley wrote:

> Based on a very quick look, I'd say the original patch 3db11fe is broken.  
> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is 
> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for 
> omap2plus_defconfig.

So in fact to follow up on this, looks like one of two changes are needed:

1. Revert 3db11fe

or 

2. If CONFIG_CPU_IDLE=n, the driver needs to call disable_hlt() in place 
of the pm_qos constraint add, and call enable_hlt() in place of the pm_qos 
constraint remove.

Jean, could you please pick a solution and send a patch for the 3.7-rc 
timeframe, to fix the bug in 3db11fe?
?

- Paul
