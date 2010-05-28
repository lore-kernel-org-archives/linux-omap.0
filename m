From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 10:35:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005281029500.1939-100000@iolanthe.rowland.org>
References: <20100528132138.2d802d77@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42891 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751037Ab0E1Ofu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 10:35:50 -0400
In-Reply-To: <20100528132138.2d802d77@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arve =?ISO-8859-14?B?SGr4bm5lduVn?= <arve@android.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>

On Fri, 28 May 2010, Alan Cox wrote:

> If I push the button we get an IRQ
> We come out of power save
> The app gets poked
> The app may be unimportant but the IRQ means we have a new timeout of
>     some form to run down to idle
> The app marks itself important
> The app stays awake for 60 seconds rsyncing your email
> The app marks itself unimportant
> Time elapses
> We return to suspend
> 
> 
> If you are absolutely utterly paranoid about it you need the button
> driver to mark the task it wakes back as important rather than rely on
> time for response like everyone else. That specific bit is uggglly but
> worst case its just a google private patch to a few drivers. I understand
> why Android wants it. The narrower the gap between 'we are doing nothing,
> sit in lowest CPU on state' and 'we are off' the better the battery life
> and the more hittable the condition.

That "private patch to a few drivers" is almost exactly what suspend
blockers are.  Given that much of this discussion has revolved around 
whether suspend blockers are accptable in the kernel, I don't think you 
should shrug them off quite so easily.

Also, you have forgotten about the case where there is no app waiting 
to get poked:

	The app is busy doing something else unimportant
	We do into power save
	Push a button, generate an IRQ
	Come out of power save
	No app to poke
	* System goes back to sleep and eventually wakes up again
	The app finishes what it was doing
	The app sees there is a keystroke and marks itself important
	...

The * step is where trouble can occur.

Alan Stern

