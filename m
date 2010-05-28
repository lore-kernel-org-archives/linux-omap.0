From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 11:14:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005281110340.1939-100000@iolanthe.rowland.org>
References: <1275058794.27810.9571.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275058794.27810.9571.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 28 May 2010, Peter Zijlstra wrote:

> It seems most of the problems the suspend-blockers are trying to solve
> are due to the fact of not running runnable tasks.

That is only partially correct.

If Android were using idle-time PM and not forced suspend, then yes -- 
not running runnable tasks would be a big problem.

But as it stands, with forced suspend the problem is to avoid delays in
processing wakeup events.  That's what suspend blockers are meant to
solve.  The same problem would occur with idle-time PM if you don't run
all runnable tasks, and it would need a similar solution.

Alan Stern
