From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 07:15:42 +0200
Message-ID: <1275023742.27810.7782.camel@twins>
References: <Pine.LNX.4.44L0.1005271517170.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271517170.3239-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-27 at 15:19 -0400, Alan Stern wrote:
> On Thu, 27 May 2010, Peter Zijlstra wrote:
> 
> > I still don't see how blocking applications will cause missed wakeups in
> > anything but a buggy application at worst, and even those will
> > eventually get the event when they unblock.
> > 
> > What seems to be the confusion?
> 
> During forced suspend, applications are block because they are frozen.
> 
> When an event occurs, the application is notified somehow.  But it 
> can't respond because it is frozen.  Hence the event remains sitting in 
> a kernel queue and the system goes ahead and suspends anyway.  The 
> application doesn't get thawed until the system wakes up at some 
> indefinite time in the future.

If the kernel is awake to put things in queues, we're clearly not
suspended and userspace is running ?!
