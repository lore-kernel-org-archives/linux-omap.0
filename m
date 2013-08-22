From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes against v3.11-rc5
Date: Wed, 21 Aug 2013 22:26:35 -0700
Message-ID: <20130822052635.GF5151@quad.lixom.net>
References: <20130816071958.GB7656@atomide.com>
 <CAOesGMiQBajdyW5AFJx6ASh1pHmdDPrh6Gy3o2HOBtFc9-g_Ag@mail.gmail.com>
 <20130820123232.GN7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61153 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab3HVF1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 01:27:17 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1300947pbc.7
        for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 22:27:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130820123232.GN7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "arm@kernel.org" <arm@kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Aug 20, 2013 at 05:32:32AM -0700, Tony Lindgren wrote:
> * Olof Johansson <olof@lixom.net> [130816 15:05]:
> > 
> > Our current fixes branch is based on -rc4, and I didn't see any of
> > these commits in linux-next, so I took the liberty to rebase them back
> > onto our current branch.
> > 
> > I.e. pulled, but rebased.
> 
> Thanks no problem at my end. But to avoid future confusion, what's
> the reasoning for rebasing? AFAIK, pulling this in would have just
> automatically updated your branch to -rc5, no?
> 
> The only time where pulling in a branch based on a later mainline
> commit would cause problems is if your branch is based on another
> series of patches you want to send separately as then you'd get
> all the commits between -rc4 and -rc5 when doing the pull request.
> 
> Probably nothing new in this for your, but FYI, you can use pulling
> or merging branches as a way of updating your publick branches without
> rebasing or adding extra merge commits while keeping the branch
> pullable.
> 
> Let's assume you have arm-soc/fixes based on -rc4, and -rc5
> comes out:
> 
> $ git checkout -b my-fixes-of-the-week v3.11-rc5
> # apply pending patches
> ...
> $ git checkout arm-soc/fixes
> $ git merge my-fixes-of-the-week
> 
> And then you have essentially fast forwarded your arm-soc/fixes to
> -rc5 and it stays pullable ;)

Yeah, it's not that we _can't_ pull it in, it's just that we either need to
merge in -rc5 manually first, or otherwise manually verify diffstat since
it'd otherwise cover the full delta.

My request for people to not always eagerly pick up latest -rc as base for
their branches is new for this release cycle, mostly to see how well it works
out. It would keep the history of our arm-soc changes somewhat cleaner than if
we have new -rcs "anchor in" on the graph in multiple locations like we
sometimes do now. But it might just be annoying for everyone to deal with
complying too, so we'll see how it goes.


-Olof
