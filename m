From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Suggestion for a new kernel version
Date: Wed, 12 Nov 2008 04:07:45 +0200
Message-ID: <20081112020728.GB7840@frodo>
References: <deb0f030811101627s2f5093c0nf79d14bf6e03ca3c@mail.gmail.com> <94a0d4530811111631y2f454147o866c40985cb4de69@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45702 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYKLCHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 21:07:54 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530811111631y2f454147o866c40985cb4de69@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Suresh Rajashekara <suresh@mistralsolutions.com>, linux-omap@vger.kernel.org, linux@mistralsolutions.com

On Wed, Nov 12, 2008 at 02:31:45AM +0200, Felipe Contreras wrote:
> On Tue, Nov 11, 2008 at 2:27 AM, Suresh Rajashekara
> <suresh@mistralsolutions.com> wrote:
> > Hi List,
> >
> > We have been using 2.6.16-rc3-omap1 on one of our OMAP1 based product
> > which had quite a few bugs. We had been taking some fixes from the
> > later kernels and port it back, but at some point it becomes difficult
> > to do it when the basic data structures changes (because any such big
> > changes are frowned upon if proposed for a working product), but now,
> > finally we have decided to change the kernel itself to some later
> > version. I would appreciate if the list can suggest us some kernel
> > version to which we can switch to. Requirements are;
> >
> > 1. Kernel should be pretty stable (very less bugs)
> > 2. Even if there are any bugs, it should be easy to port the fixes
> > back. This is important because I don't get a chance to convince the
> > decision makers to change the kernel again because its something which
> > is very basic and they are afraid to change a working system for a
> > small bug fix.
> >
> > Some of the components for which we depend heavily on the kernel are
> > MTD/JFFS2 (with which we have faced lot of issues in
> > 2.6.16-rc3-omap1), DSP Gateway functionality and power management.
> >
> > Thanks in advance for your help.
> 
> You should avoid rc* releases, those are release candidates, only for
> testing purposes.
> 
> You should stick with plain -omap* releases, like 2.6.27-omap1, or
> 2.6.26-omap2, unless you want to be on the bleeding edge.

I'd actually suggest trying to push everything you have to linux-omap or
(case a driver) the proper subsystem tree, that way you can be sure
(most of the times) you can generate a product out of virtually any
kernel release. Of course, that would mean you guys would have to change
a bit your development process and work more with the community.

Meaning that instead of keeping a kernel tree below several layers of
encryptions and firewalls, you'd have to send patches to the open source
mailing lists.

Generally, even the -rc (release candidates) are stable enough for
usage, besides a few regressions that might happen.

Since you need, mostly as you said, MTD and JFFS2 working on your
board(s), your team could keep an eye on it and contribute to the mtd
mailing list.

About PM, I'd say the most current kernel, the better as it's still
changing a lot (take a look at linux-omap/pm-* branches) and about DSP
gateway, it looks like it's pretty much frozen, so you could put some
effort there as well.

-- 
balbi
