From: Tony Lindgren <tony@atomide.com>
Subject: Re: Some patches need reposting, inbox cleared, patchwork cleared
Date: Fri, 13 Nov 2009 10:03:23 -0800
Message-ID: <20091113180323.GC3684@atomide.com>
References: <20091113003851.GN24837@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8605@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C860A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52913 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbZKMSDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 13:03:19 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C860A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [091112 20:43]:
> Gadiyar, Anand wrote:
> > Tony Lindgren wrote:
> > > Hi all,
> > > 
> > > I'm finally done sorting through the patchwork patches to add to
> > > the omap for-next queue. So I've nuked my linux-omap inbox, and
> > > cleared the patches that I'm supposed to deal with in patchwork.
> > > 
> > > Please check that you patch is applied (or merged into some existing
> > > patch) in the omap for-next branch.
> > > 
> > > If you don't see your patch in the omap for-next branch, and you
> > > don't see the patch in the patchwork list, please repost your
> > > patch. When reposting, please send the whole series again.
> > > 
> > > The patchwork pending patches are at:
> > > 
> > > http://patchwork.kernel.org/project/linux-omap/list/
> > > 
> > > I have not touched the patches in patchwork that are tagged for
> > > felipebalbi, khilman or pwsan, so this message only concerns the
> > > ones I'm supposed to deal with.
> > > 
> > > If you have lots of patches, you can also post a git branch that's
> > > rebased on commit 8171d88089ad63fc442b2bf32af7c18653adc5cb.
> > > Don't use the omap for-next for rebasing, as it's still changing.
> > > 
> > > I've dropped all the patches that did not apply to for-next,
> > > or that have dependency to some other subsystem. I've commented
> > > on few of the patches that don't apply, but not all of them.
> > > Then some fix patches I've merged to the earlier patches,
> > > and for those there's no APPLIED email message.
> > > 
> > > I've probably also accidentally trashed some perfectly valid
> > > patches too.. So please check and repost as needed!
> > > 
> > 
> > Tony,
> > 
> > What happened to the 3630 support stuff that had been merged to
> > your master branch as of yesterday?
> > 
> > - Anand
> 
> I meant, I see these patches in for-next, but they're not present
> in the l-o master branch. Is this deliberate?

Hmm, it should be all merged into master branch also:

$ git log --pretty=oneline --grep=3630 -n100 master arch/arm/mach-omap2
1739bbc268aeffc8d3d040cf6493ef4399a1a181 omap: 3630sdp: introduce 3630 sdp board support
13ac7e77f407e4c529eb1cb058031f896fd3e80c omap: zoom3: introduce zoom3 board support
79c6fce9daa80936eba830c49b6c559f5ca6295d omap: zoom: drop i2c-1 speed to 2400
3efbe15e7755108268b9ed72d3b6c6539f671ebe omap: zoom: rename zoom2 name to generic zoom
97bd76cf5e5c18ddcc8d38f997ae7aec4db3bb01 omap: zoom2: split board file for software reuse
2c8681ac36b4247c26c5789f63de9f522436c1c5 omap3630: Set omap3630 MMC1 I/O speed to 52Mhz
9283cf8a9d21889fb838634e7017e84acf69e79f omap3630: Configure HSMMC1 to 4-bit
1a309b7370e5aa6d703eded1afc53218a205a71f omap3630: Add HSMMC related checks
1e9e0b997c30b81b2165fa68cad4411e6136a8d2 omap3: 3630: update is_chip variable
6fb081fb525c05aed6fee28bf73fe4ee1fe2d5bd omap3: Introduce OMAP3630

Can you check and let me know if something is missing?

Regards,

Tony
