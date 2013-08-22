From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v3.11-rc5
Date: Thu, 22 Aug 2013 00:10:58 -0700
Message-ID: <20130822071058.GP7656@atomide.com>
References: <20130816071958.GB7656@atomide.com>
 <CAOesGMiQBajdyW5AFJx6ASh1pHmdDPrh6Gy3o2HOBtFc9-g_Ag@mail.gmail.com>
 <20130820123232.GN7656@atomide.com>
 <20130822052635.GF5151@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42081 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab3HVHLE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 03:11:04 -0400
Content-Disposition: inline
In-Reply-To: <20130822052635.GF5151@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "arm@kernel.org" <arm@kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

* Olof Johansson <olof@lixom.net> [130821 22:34]:
> On Tue, Aug 20, 2013 at 05:32:32AM -0700, Tony Lindgren wrote:
> > * Olof Johansson <olof@lixom.net> [130816 15:05]:
> > > 
> > > Our current fixes branch is based on -rc4, and I didn't see any of
> > > these commits in linux-next, so I took the liberty to rebase them back
> > > onto our current branch.
> > > 
> > > I.e. pulled, but rebased.
> > 
> > Thanks no problem at my end. But to avoid future confusion, what's
> > the reasoning for rebasing? AFAIK, pulling this in would have just
> > automatically updated your branch to -rc5, no?
> > 
> > The only time where pulling in a branch based on a later mainline
> > commit would cause problems is if your branch is based on another
> > series of patches you want to send separately as then you'd get
> > all the commits between -rc4 and -rc5 when doing the pull request.
> > 
> > Probably nothing new in this for your, but FYI, you can use pulling
> > or merging branches as a way of updating your publick branches without
> > rebasing or adding extra merge commits while keeping the branch
> > pullable.
> > 
> > Let's assume you have arm-soc/fixes based on -rc4, and -rc5
> > comes out:
> > 
> > $ git checkout -b my-fixes-of-the-week v3.11-rc5
> > # apply pending patches
> > ...
> > $ git checkout arm-soc/fixes
> > $ git merge my-fixes-of-the-week
> > 
> > And then you have essentially fast forwarded your arm-soc/fixes to
> > -rc5 and it stays pullable ;)
> 
> Yeah, it's not that we _can't_ pull it in, it's just that we either need to
> merge in -rc5 manually first, or otherwise manually verify diffstat since
> it'd otherwise cover the full delta.

Hmm sounds like something's not right then, at least for the fixes
branch. If you do the pull request for Linus against -rc5, it should
only show the patches you merged, not the delta from -rc4 to -rc5.

If you mean that you need to be able to diff between the earlier pull
request against -rc4 and the new pull request against -rc5, then that
should work too without showing the full delta of non-arm-soc patches.

For your branches, it should not be necessary to manually merge
any upstream tags, you can just let the branches automatically
get updated when merging in branches and pulling in branches.

Especially for the fixes branch as that should not have dependencies
to other external branches :)

> My request for people to not always eagerly pick up latest -rc as base for
> their branches is new for this release cycle, mostly to see how well it works
> out. It would keep the history of our arm-soc changes somewhat cleaner than if
> we have new -rcs "anchor in" on the graph in multiple locations like we
> sometimes do now. But it might just be annoying for everyone to deal with
> complying too, so we'll see how it goes.

Yes.. I think that's against natural way of developing things as that
requires testing against multiple trees and rebasing patches that
can often introduce new issues.

The issue of generating pull requests when there are dependencies
to earlier branches not yet merged still remains though.

Regards,

Tony
