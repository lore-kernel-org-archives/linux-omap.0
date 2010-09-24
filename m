From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Fri, 24 Sep 2010 22:04:11 +0200
Message-ID: <201009242204.11801.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009241104540.1744-100000@iolanthe.rowland.org> <87ocbnas5v.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39412 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab0IXUFF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 16:05:05 -0400
In-Reply-To: <87ocbnas5v.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Friday, September 24, 2010, Kevin Hilman wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Thu, 23 Sep 2010, Kevin Hilman wrote:
...
> >
> > You're trying to fight the runtime-PM design instead of using it as it 
> > was intended.  We already have an API for starting a resume from 
> > interrupt context, and that's what you should use.
> 
> It may seem like I'm trying to fight the design, but I'm actually trying
> to find ways to use it.  I want to use the API (and we're using it
> successfully in most of our drivers now.)  The problem is only in a few
> of these corner cases where using it introduces significant changes from
> previous behavior like introducing long, unbounded windows for missed
> interrupts.

This really sounds to me like you need _noirq() runtime PM callbacks
and some framework around them.

I'm not fundamentally against that, but it will require some time to introduce,
if we decide that it's really necessary.

I need to think a bit more about that, thanks for the example.

Rafael
