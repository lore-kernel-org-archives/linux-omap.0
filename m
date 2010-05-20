From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 10:40:17 -0700 (PDT)
Message-ID: <15003.23611.qm@web180316.mail.gq1.yahoo.com>
References: <4BF51C9D.8050406@nt.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n6-vm0.bullet.mail.gq1.yahoo.com ([98.137.26.79]:47064 "HELO
	n6-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752613Ab0ETRkS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 13:40:18 -0400
In-Reply-To: <4BF51C9D.8050406@nt.tu-darmstadt.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Cc: Matthew Garrett <mjg@redhat.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>


> > during development on MeeGo devices we try to tackle
> down as much as
> > possible the use_time offenders and start by filing
> bugs to those apps,
> > instead of fixing their issues in kernel space.

Some apps do abuse kernel mechanisms, and whether the bug is in the
app or that kernel mechanism can be a judgement call.  I'd expect to
see some fixes be appropriately in-kernel; maybe not many though.

When reading about this suspend block stuff, does anyone else hear
eachoes of APM?  It's been ages since that was used, but ISTR it also
leveraged handshaking between kernel and userspace.  Are there lessons
to be applied from there to this discussion?

On first principles, I don't see anything wrong with acknowledging that
the kernel doesn't have a "whole system PM view" and thus its PM knowledge could usefully be augmented by information from userspace (applications), possibly on request.

Just what that broad PM view consists of gets kind of system-specific.  For OMAP hardware, with smart device-level power reduction active almost
all the time, it may look different from an ACPI laptop where the BIOS
is biased towards saving device power primarily in some suspend state(s) ... or some other hardware platform without much hardware or BIOS assist, where the main PM mechanisms involve software detection/instigation of hardware idleness (and potentially "off-ness").




> And you will continue doing that once the Meego app store
> has 100k apps?

I may have overlooked it, in one of the 100K messsages in my
mailbox about versions of suspend block/etc patches ...

But surely NOBODY is actually contending that broken aps NOT get fixed??

It's clear to me that tools are needed to identify power hogs; powertop can't be the extent of such tools.  (ISTR it doesn't monitor display power usage, for one thing; maybe newer versions do so.)  Once such hogs get identified they will need to get fixed.  Any other proposal seems broken to me...

