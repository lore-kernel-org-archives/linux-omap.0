From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 10:39:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006101037470.1702-100000@iolanthe.rowland.org>
References: <alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36955 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753226Ab0FJOjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 10:39:52 -0400
In-Reply-To: <alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david@lang.hm
Cc: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>

On Wed, 9 Jun 2010 david@lang.hm wrote:

> why could the suspend blocker process see all events, but the power 
> manager process not see the events?
> 
> have the userspace talk to the power manager the way it does to the 
> suspend blocker now and what's the difference?
> 
> effectivly think s/suspend blocker/power manager/ (with the power manager 
> doing all the other things that are proposed instead of grabbing the 
> wakelock), the difference should be hidden to the rest of userspace.
> 
> what am I missing here?

The main difference is that with a userspace power manager, programs
have to tell the power manager whenever they open or close a
wakeup-capable device file (and send it a copy of the file descriptor).  
With an in-kernel implementation these extra steps aren't needed,
because of course kernel drivers already know when their device files
are opened or closed.

Alan Stern

