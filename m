From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH] OMAP3: clock3xxx_data: change EMAC clocks aliases
Date: Thu, 9 Feb 2012 16:03:54 -0500
Message-ID: <20120209210354.GC30410@h56-17.vpn.ti.com>
References: <1324423634-32581-1-git-send-email-yanok@emcraft.com>
 <4F2F8EE3.1050305@visionsystems.de>
 <20120209190957.GA30410@h56-17.vpn.ti.com>
 <alpine.DEB.2.00.1202091245210.4469@utopia.booyaka.com>
 <20120209201100.GB30410@h56-17.vpn.ti.com>
 <alpine.DEB.2.00.1202091314320.6698@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42145 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab2BIVEI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 16:04:08 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202091314320.6698@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Tony Lindgren <tony@atomide.com>, Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, sasha_d@emcraft.com

On Thu, Feb 09, 2012 at 01:20:50PM -0700, Paul Walmsley wrote:
> Hi Matt
> 
> On Thu, 9 Feb 2012, Matt Porter wrote:
> 
> > Thanks Paul.
> > 
> > Any chance we can see it in 3.3 fixes? It's the only thing preventing 
> > the emac and thus nfsroot from working in 3.3 for these systems.
> 
> Did EMAC work on previous versions of Linux for those systems? i.e., does 
> this patch fix a regression?

It's been broken since at least 2.6.37 (predating my time working with
these parts) when the MDIO driver was split out from the EMAC driver. As
it was so long ago, I won't try to classify this as fixing a regression
since most likely something else was broken in that timeframe. :) Thanks
for the clarification.

-Matt
