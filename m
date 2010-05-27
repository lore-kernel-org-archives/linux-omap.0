From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 11:06:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271053420.3239-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.1005271545190.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005271545190.3032@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

If people don't mind, here is a greatly simplified summary of the 
comments and objections I have seen so far on this thread:

	The in-kernel suspend blocker implementation is okay, even
	beneficial.

	Opportunistic suspends are okay.

	The proposed userspace API is too Android-specific.

	More kernel mechanisms are needed for expressing processes'
	latency requirements.

The last one is obviously a longer-term issue, so let's ignore it for
now.  That leaves as the only point of contention the userspace
suspend-blocker API.

The proposal I made a couple of days ago removes this API and leaves
the other things (i.e., the in-kernel suspend blockers and
opportunistic suspend) intact.  In place of the userspace
kernel-blocker API, Android would have to implement a power manager
process that would essentially juggle all the latency requirements in
userspace.

Communication between the power manager process and the kernel would be 
limited to adding a new "opportunistic" entry to /sys/power/state -- 
something which could well be useful in its own right.  Even if this 
API turns out not to be good, it's simple enough that it could be 
removed pretty easily.

This answers Alan Cox's (and other's) desire not to implement a 
questionable or special-purpose API.  And it also answers Thomas's 
desire to make scheduling decisions based on latency requirements 
(although the answer is simply to punt all these decisions out of the 
kernel and into userspace -- which is reasonable for now since the 
alternative would require a long-term kernel development effort).

Indeed, having a power manager thread may well turn out to be a useful
thing -- but even if it doesn't, this scheme minimizes the damage while
still allowing the Android platform to use a vanilla kernel with only
limited modifications to their userspace.

Alan Stern
