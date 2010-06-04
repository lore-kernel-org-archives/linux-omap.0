From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 10:50:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006041042410.1794-100000@iolanthe.rowland.org>
References: <20100604003934.GA5221@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57003 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756119Ab0FDOu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 10:50:27 -0400
In-Reply-To: <20100604003934.GA5221@elte.hu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>

On Fri, 4 Jun 2010, Ingo Molnar wrote:

> Note that this does not necessarily have to be implemented as 'execute suspend 
> from the idle task' code: scheduling from the idle task, while can certainly 
> be made to work, is a somewhat recursive concept that we might want to avoid 
> for robustness reasons.
> 
> Instead, the 'deepest idle' (suspend) method could consist of a wakeup of a 
> kernel thread (or of any of the existing kernel threads such as the migration 
> thread) - which kernel thread then does a race-free suspend: it offlines all 
> but one CPU [on platforms that need that] and then initiates the suspend - but 
> aborts the attempt if there's any sign of wakeup activity.

Out of morbid curiosity...  A typical sign of wakeup activity is a
thread becoming runnable because of expiration of a kernel timer or an
I/O completion interrupt.  How would the "race-free suspend" thread
detect this sort of thing?  Indeed, isn't the inability to detect these 
part of what makes the existing suspend implementation (the freezer in 
particular) not race-free?

Alan Stern

