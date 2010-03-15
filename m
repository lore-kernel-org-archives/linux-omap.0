From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] omap3: serial code for 3630 and zoom2/3 fixes
Date: Mon, 15 Mar 2010 15:48:43 -0700
Message-ID: <20100315224842.GH2900@atomide.com>
References: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
 <A24693684029E5489D1D202277BE89445405400C@dlee02.ent.ti.com>
 <20100315211525.GF2900@atomide.com>
 <A24693684029E5489D1D202277BE894454054155@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55272 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937010Ab0COWrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 18:47:18 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894454054155@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>

* Aguirre, Sergio <saaguirre@ti.com> [100315 14:47]:
> 
> 
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, March 15, 2010 4:15 PM
> > * Aguirre, Sergio <saaguirre@ti.com> [100315 13:33]:
> > > Tony,
> > >
> > > Please find attached pull request for your convenience.
> > 
> > <snip>
> > 
> > > The following changes since commit
> > a842b5f9ce70e1b738eabb4d719860070180ed1c:
> > >   Tony Lindgren (1):
> > >         Revert "omap: Add DSI regulator supply to OMAP3EVM board file"
> > >
> > > are available in the git repository at:
> > >
> > >   git://dev.omapzoom.org/pub/scm/saaguirre/linux-omap-camera.git omap-
> > fixes
> > 
> > Please base all the branches against the recent tag in Linus' tree,
> > in this case against v2.6.34-rc1. What we have in the linux-omap master
> > branch is a merge of various development branches, and we don't want
> > to merge that history to the mainline tree.
> > 
> > If the recent mainline tag won't work as the base, then please
> > rebase it on omap-fixes-for-linus or omap-for-linus. In this case,
> > omap-fixes-for-linus at commit 29b2ee5af5f3a02846bd38a1e2121d62ee5f6aca.
> > The omap-for-linus branch will contain things going into the next
> > merge window, currently it's empty.
> > 
> > In general, the commits ins omap-fixes-for-linus and omap-for-linus
> > should stay around unless something goes wrong. But please use
> > the recent mainline tag where possible, that's the most flexible
> > option for merging.
> 
> Understood,
> 
> Please find updated pull request, rebased on omap-fixes-for-linux.
> 
> I tried it on master, but they don't apply clean, since "OMAP2: serial.c: Fix number of uarts in early_init" is not upstream, and there's a small cleanup change in it, which makes patch 0002 don't apply (printk to dev_* patch).

OK, thanks. One more thing: Please repost your fixes one more
time with LAKML Cc'd for review. Then assuming no more comments, I'll
merge them into omap-fixes-for-linus.

Meanwhile, I'll merge it into l-o master branch for testing.

Tony
