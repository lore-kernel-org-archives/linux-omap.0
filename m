From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v3.4-rc6
Date: Wed, 9 May 2012 08:15:11 -0700
Message-ID: <20120509151510.GG5088@atomide.com>
References: <20120507223632.GP5088@atomide.com>
 <CAOesGMjHEy0Rz+ow7J3BuUtt3h3SjU+6gG=PPGTu3tMNZXy6nQ@mail.gmail.com>
 <1673508.aX9Ao89479@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43411 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab2EIPPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 11:15:17 -0400
Content-Disposition: inline
In-Reply-To: <1673508.aX9Ao89479@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ebutera@users.berlios.de

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [120509 04:09]:
> Hi Olof,
> 
> On Tuesday 08 May 2012 23:48:06 Olof Johansson wrote:
> > Hi,
> > 
> > On Mon, May 7, 2012 at 3:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > The following changes since commit 
> 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:
> > [..]
> > 
> > > Enrico Butera (1):
> > >      ARM: OMAP: igep0020: fix smsc911x dummy regulator id
> > 
> > Hmm. Picking 40 without any kind of comment in the code isn't doing
> > any favors for future readers. Seems like 1 would be free on this
> > board, from the rest of the board file to judge (one other
> > reg-fixed-regulator platform device)?
> > 
> > Please either comment why you picked 40 (i.e. it's a random number),
> > or change it to something a little less random like 1. :)

I'll use the update patch from Enrico.

> > > Laurent Pinchart (1):
> > >      ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally
> > 
> > Is this a regression? I don't see any recent changes regarding this,
> > so it's hard to tell. If not then I'd rather hold off for the merge
> > window given that we're at -rc6.
> 
> It's not a regression, I'm fine with holding off until the v3.5 merge window.

And will move this one into fixes-non-critical.

Will send a new pull request shortly.

Tony
