From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v3.2-rc2
Date: Wed, 23 Nov 2011 16:42:02 -0800
Message-ID: <20111124004202.GM31337@atomide.com>
References: <20111119194408.GD31337@atomide.com>
 <201111232115.41035.arnd@arndb.de>
 <20111123220358.GI31337@atomide.com>
 <21329850.CZjvquqxJn@wuerfel>
 <20111123231127.GJ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40027 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab1KXAmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 19:42:08 -0500
Content-Disposition: inline
In-Reply-To: <20111123231127.GJ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

* Tony Lindgren <tony@atomide.com> [111123 14:36]:
> * Arnd Bergmann <arnd@arndb.de> [111123 13:47]:
> > On Wednesday 23 November 2011 14:03:58 Tony Lindgren wrote:
> > > 
> > > The earlier patches are based on the earlier fixes (while waiting
> > > for them to get merged). So that's certainly not a random commit.
> > > Or at least was not at that time  I can rebase those too anyways
> > > now that the earlier fixes are merged.
> > 
> > No need to do that unless you are rebasing them anyway. IMHO
> > it's fine if you have all your bug fixes in one branch based
> > on the previous bug fixes you sent, but it's of course also
> > fine to start a fresh branch for each pull request.
> > 
> > In general, I would recommend not rebasing when you have the
> > choice, because that means your patches are not as well tested.
> 
> Well I can keep only four of them because of the pull on a random
> commit. Looks like four of them apply to v3.1, will send them
> off to stable@vger.kernel.org and send you two new pull requests.

FYI, forgot to mention that I verified that merging in the two pull
requests produces the same end result as the original pull request.

Tony
