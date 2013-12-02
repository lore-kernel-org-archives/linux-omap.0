From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Sun, 1 Dec 2013 16:24:44 -0800
Message-ID: <20131202002444.GA22418@teo>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
 <CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
 <201311242001.23126@pali>
 <CAOf5uw=-cy2QoDxjecxYTYsrQRD=LtN0N7DcYJHZ6HSbexzPRw@mail.gmail.com>
 <20131201223730.GD6271@lizard>
 <CAOf5uwnkQwkS7_fsLtC5nzdXyS1Rzw2SkxaziUuJrO9SKXh3yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:49091 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3LBAYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Dec 2013 19:24:48 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so17719160pbc.34
        for <linux-omap@vger.kernel.org>; Sun, 01 Dec 2013 16:24:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOf5uwnkQwkS7_fsLtC5nzdXyS1Rzw2SkxaziUuJrO9SKXh3yw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz

On Mon, Dec 02, 2013 at 01:02:40AM +0100, Michael Trimarchi wrote:
> On Sun, Dec 1, 2013 at 11:37 PM, Anton Vorontsov <anton@enomsg.org> wrote:
> > On Mon, Nov 25, 2013 at 08:16:34PM +0100, Michael Trimarchi wrote:
> > ...
> >> >> So you can read this value without any type of synchronization
> >> >> with the power_supply_core
> >> >> and sysfs implementation?
> > ...
> >> https://lists.ubuntu.com/archives/kernel-team/2013-January/025206.html
> >>
> >> I found and equivalent scenario that I was trying to said
> >
> > That's a good question, actually. Even though in Pali's case the notifier
> > is atomic (so that we are pretty confident that the object won't be
> > unregistered), there is still a possiblity of a dead lock, for example. So
> 
> So if the get_property is a sleeping function it will be a deadlock. Right?

All kind of bad things might happen, yes. But before that I would expect a
bunch of warnings from might_sleep() stuff.

I would recommend to test the patches using preempt/smp kernels + various
DEBUG_ kernel options set.

Thanks,

Anton
