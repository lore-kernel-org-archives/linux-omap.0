From: Tony Lindgren <tony@atomide.com>
Subject: Re: Some patches need reposting, inbox cleared, patchwork cleared
Date: Fri, 13 Nov 2009 10:15:50 -0800
Message-ID: <20091113181550.GD3684@atomide.com>
References: <20091113003851.GN24837@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8605@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C860A@dbde02.ent.ti.com>
 <20091113180323.GC3684@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA689287@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52122 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbZKMSPr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 13:15:47 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA689287@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [091113 10:05]:
> 
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> >Lindgren
> >Sent: Friday, November 13, 2009 12:03 PM
> >To: Gadiyar, Anand
> >Cc: linux-omap@vger.kernel.org
> >Subject: Re: Some patches need reposting, inbox cleared, patchwork cleared
> >
> >> > Tony,
> >> >
> >> > What happened to the 3630 support stuff that had been merged to
> >> > your master branch as of yesterday?
> >> >
> >> > - Anand
> >>
> >> I meant, I see these patches in for-next, but they're not present
> >> in the l-o master branch. Is this deliberate?
> >
> >Hmm, it should be all merged into master branch also:
> >
> >$ git log --pretty=oneline --grep=3630 -n100 master arch/arm/mach-omap2
> >1739bbc268aeffc8d3d040cf6493ef4399a1a181 omap: 3630sdp: introduce 3630 sdp board support
> >13ac7e77f407e4c529eb1cb058031f896fd3e80c omap: zoom3: introduce zoom3 board support
> >79c6fce9daa80936eba830c49b6c559f5ca6295d omap: zoom: drop i2c-1 speed to 2400
> >3efbe15e7755108268b9ed72d3b6c6539f671ebe omap: zoom: rename zoom2 name to generic zoom
> >97bd76cf5e5c18ddcc8d38f997ae7aec4db3bb01 omap: zoom2: split board file for software reuse
> >2c8681ac36b4247c26c5789f63de9f522436c1c5 omap3630: Set omap3630 MMC1 I/O speed to 52Mhz
> >9283cf8a9d21889fb838634e7017e84acf69e79f omap3630: Configure HSMMC1 to 4-bit
> >1a309b7370e5aa6d703eded1afc53218a205a71f omap3630: Add HSMMC related checks
> >1e9e0b997c30b81b2165fa68cad4411e6136a8d2 omap3: 3630: update is_chip variable
> >6fb081fb525c05aed6fee28bf73fe4ee1fe2d5bd omap3: Introduce OMAP3630
> >
> >Can you check and let me know if something is missing?
> 
> I just verified booting zoom3 on l-o master, and its working fine.

OK good. Can you also try booting this patch from Felipe on 3630:

http://patchwork.kernel.org/patch/59540/
 
> Only extra patch that I have to add is the 8250 patch, that needs posting separately.

OK

Regards,

Tony
