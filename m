From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 30 Oct 2012 13:17:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com> <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com> <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi> <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com> <20121029200032.GD30152@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com> <20121030123254.GD29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com> <20121030125419.GG29095@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48153 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab2J3NRX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 09:17:23 -0400
In-Reply-To: <20121030125419.GG29095@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Tue, 30 Oct 2012, Felipe Balbi wrote:

> On Tue, Oct 30, 2012 at 12:50:52PM +0000, Paul Walmsley wrote:
> > certainly PM-idle related, given that the problem goes away by reverting 
> > Jean's commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc "ARM: OMAP: convert 
> > I2C driver to PM QoS for MPU latency constraints".
> > 
> > The problem is consistent and easy to reproduce here.
> 
> I don't doubt that :-) What I think, however, is that PM QoS just made
> the problem a bit easier to trigger for whatever reason. Maybe because
> pm qos defers constraint updates, or something similar ?

Based on a very quick look, I'd say the original patch 3db11fe is broken.  
I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is 
honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for 
omap2plus_defconfig.


- Paul
