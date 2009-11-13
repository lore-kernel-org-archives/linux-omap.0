From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Some patches need reposting, inbox cleared, patchwork cleared
Date: Fri, 13 Nov 2009 10:14:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C860A@dbde02.ent.ti.com>
References: <20091113003851.GN24837@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8605@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34178 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755635AbZKMEoC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 23:44:02 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8605@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gadiyar, Anand wrote:
> Tony Lindgren wrote:
> > Hi all,
> > 
> > I'm finally done sorting through the patchwork patches to add to
> > the omap for-next queue. So I've nuked my linux-omap inbox, and
> > cleared the patches that I'm supposed to deal with in patchwork.
> > 
> > Please check that you patch is applied (or merged into some existing
> > patch) in the omap for-next branch.
> > 
> > If you don't see your patch in the omap for-next branch, and you
> > don't see the patch in the patchwork list, please repost your
> > patch. When reposting, please send the whole series again.
> > 
> > The patchwork pending patches are at:
> > 
> > http://patchwork.kernel.org/project/linux-omap/list/
> > 
> > I have not touched the patches in patchwork that are tagged for
> > felipebalbi, khilman or pwsan, so this message only concerns the
> > ones I'm supposed to deal with.
> > 
> > If you have lots of patches, you can also post a git branch that's
> > rebased on commit 8171d88089ad63fc442b2bf32af7c18653adc5cb.
> > Don't use the omap for-next for rebasing, as it's still changing.
> > 
> > I've dropped all the patches that did not apply to for-next,
> > or that have dependency to some other subsystem. I've commented
> > on few of the patches that don't apply, but not all of them.
> > Then some fix patches I've merged to the earlier patches,
> > and for those there's no APPLIED email message.
> > 
> > I've probably also accidentally trashed some perfectly valid
> > patches too.. So please check and repost as needed!
> > 
> 
> Tony,
> 
> What happened to the 3630 support stuff that had been merged to
> your master branch as of yesterday?
> 
> - Anand

I meant, I see these patches in for-next, but they're not present
in the l-o master branch. Is this deliberate?

- Anand
