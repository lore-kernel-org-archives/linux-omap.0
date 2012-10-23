From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Tue, 23 Oct 2012 10:12:29 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB48592@DBDE01.ent.ti.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at> <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39172 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab2JWKMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 06:12:39 -0400
In-Reply-To: <20121019061630.GB2983@netboy.at.omicron.at>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 19, 2012 at 11:46:30, Richard Cochran wrote:
> On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> > 
> > Another important point is, this driver is also required and used for
> > Davinci family of devices (arch/mach/mach-davinci/).
> 
> That is really beside the point. If the code isn't ready yet, then
> don't merge it.
> 

With respect to AM33xx the driver may not be ready, but that doesn't mean 
driver itself is not ready. As I mentioned before, driver is used on davinci 
platform and it could be functional there. 

In case of AM33xx, where DT only boot mode is supported, you are forced to 
migrate driver to DT, which is addition to the driver.

Note that, all the patches you have posted recently are AM33xx SoC 
integration specific patches.

> When I asked about the beaglebone, I was given the impression that it
> will be ready for v3.7-rc1.  But, as I know realize, at the current
> rate, it might not even be ready for v3.8.
> 

I understand, and as you mentioned we are not fully there at v3.7-rc1 with 
all the drivers/module support, due to all known reasons. Its good that with 
v3.7-rc2, Beaglebone boots up out of box from mainline. 


Thanks,
Vaibhav
> I don't mind waiting, but please make sure that whatever lands into a
> release is really, truly working.
> 
> Thanks,
> Richard
> 
> 
> 

