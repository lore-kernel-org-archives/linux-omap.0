From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] - race-free suspend.  Was: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 00:15:32 +0200
Message-ID: <201006030015.32313.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org> <201006022241.14152.rjw@sisk.pl> <20100603080556.46d2d671@notabene.brown>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43930 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932937Ab0FBWOY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jun 2010 18:14:24 -0400
In-Reply-To: <20100603080556.46d2d671@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>

On Thursday 03 June 2010, Neil Brown wrote:
> On Wed, 2 Jun 2010 22:41:14 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Wednesday 02 June 2010, Neil Brown wrote:
> > > - Would this fix the "bug"??
> > > - and address the issues that suspend-blockers was created to address?
> > > - or are the requirements on user-space too onerous?
> > 
> > In theory wakeup events can also happen after  wait_for_blockers() has returned
> > 0 and I guess we should rollback the suspend in such cases.
> > 
> 
> I naively assumed this was already the case, but on a slightly closer look at
> the code it seems not.
> 
> Presumably there is some point deep in the suspend code, probably after the
> call to sysdev_suspend, where interrupts are disabled and we are about to
> actually suspend.  At that point a simple "is a roll-back required" test
> could abort the suspend.

Yes.

> Then any driver that handles wake-up events, if it gets and event that (would
> normally cause a wakeup) PM_SUSPEND_PREPARE and PM_POST_SUSPEND, could set
> the "roll-back is required" flag.

That's my idea, but instead of setting a flag, I'd use a counter increased
every time there is a wakeup event.  Then, the core suspend core code
would store a pre-suspend value of the counter and compare it with
the current value after all wakeup event sources had been set.  If they
were different, the suspend would be aborted.

Rafael
