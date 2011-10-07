From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for -rc series and merge window
Date: Fri, 7 Oct 2011 12:20:41 -0700
Message-ID: <20111007192041.GN6324@atomide.com>
References: <20111003185237.GI6324@atomide.com>
 <201110072111.35418.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47674 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab1JGTUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 15:20:45 -0400
Content-Disposition: inline
In-Reply-To: <201110072111.35418.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [111007 11:37]:
> On Monday 03 October 2011, Tony Lindgren wrote:
> > Please pull omap fixes from:
> > 
> > git://github.com/tmlind/linux.git fixes
> > 
> > Out of these the first three commits would be nice to get
> > into the -rc series with the first two causing boot issues
> > and the musb fixing an ugly warning.
> > 
> > Note however the recent commit message update on the third patch.
> > I added Bjarne's SOB to the third patch because of the earlier
> > reference.
> > 
> > The last two are mostly cosmetic and not so urgent.
> 
> Hi Tony,
> 
> I've pulled them all into the fixes branch for now, but I'm not sure
> if I still want to send another pull request. If I do, I'll have to
> rebase that branch and put some into the next/fixes branch instead
> as I already have patches that I don't want to send for 3.1 any
> more. Are the patches all fixes against 3.1 only or do some of them
> also apply to older releases?

Thanks. Well we can certainly manage if the first three commits did
not make it in during the -rc cycle. But assuming that we had valid
fixes, you could just do something like this too:

$ git checkout -b omap/fixes-for-rc
$ git reset --hard b8e111a74d281b70e88bd67fec48cfda4f9bdce2
...

Then merge all the -rc fixes for various ARM platforms with:

$ git checkout fixes-for-rc
$ git reset --hard v3.1-rc9
$ git merge omap/fixes-for-rc soc foo/fixes-for-rc bar/fixes-for-rc

And then no rebasing is needed. Of course I could also set up
a separate fixes-for-rc for that if you prefrer that :)

Regards,

Tony
