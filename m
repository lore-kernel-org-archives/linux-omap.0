From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git pull request for omap patches for post 2.6.26
Date: Wed, 16 Jul 2008 17:34:55 +0300
Message-ID: <20080716143451.GA8278@atomide.com>
References: <20080703101139.GE14276@atomide.com> <20080707200537.GP29191@flint.arm.linux.org.uk> <20080708074005.GA17594@atomide.com> <20080716071835.GB30135@atomide.com> <20080716080121.GA31248@atomide.com> <20080716084552.GA23468@flint.arm.linux.org.uk> <20080716085734.GB31248@atomide.com> <20080716093732.GB23468@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56366 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbYGPOda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 10:33:30 -0400
Content-Disposition: inline
In-Reply-To: <20080716093732.GB23468@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080716 12:37]:
> On Wed, Jul 16, 2008 at 11:57:37AM +0300, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [080716 11:46]:
> > > On Wed, Jul 16, 2008 at 11:01:24AM +0300, Tony Lindgren wrote:
> > > > Well looks like all omap-upstream and few omap2-clock patches have been
> > > > merged. I've rebased the remaining omap2-clock and omap2-upstream
> > > > patches. Will repost those two series.
> > > 
> > > Don't bother rebasing them - I obviously already have them.
> > 
> > Well I already rebased them, but you can you the ones you already have
> > as there are no changes.
> 
> I would have preferred you to have fixed those two _crap_ commits at the
> beginning of your entire OMAP series - the two which contained no patch
> whatsoever.

I did remove the two empty commits:

http://lists.arm.linux.org.uk/lurker/message/20080708.074007.cc2d62c0.en.html

> Commits that are just words describing an non-existent change are utterly
> useless.

True, and they were promptly removed.

> I did point this out at the time but you ignored me.

Not true. Sounds like you had an earlier pull in your tree that you used
instead.

Regards,

Tony
