From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:59:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005272057500.31050-100000@netrider.rowland.org>
References: <201005280124.25347.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005280124.25347.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, 28 May 2010, Rafael J. Wysocki wrote:

> > And the forced-suspend design relies on the fact that processes remain 
> > frozen throughout.  If we leave some processes unfrozen and one of them 
> > somehow becomes runnable, that means we have to abort the forced 
> > suspend before the process is allowed to run.
> 
> We could avoid that if drivers could block tasks, but there are questions to
> answer.  First off, how a driver is supposed to know when to block the task
> using it and when to do its power management transparently for the task?
> Second, how to intercept and block all possible interfaces that user space
> can use to talk to drivers (how to intercept a task using mmapped device, for
> example)?

We talked about this a few years ago and decided it was not feasible.  
It would require substantial changes to every device driver.

Alan Stern
