From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 26 May 2010 12:01:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005261156130.1328-100000@iolanthe.rowland.org>
References: <CEE6BB42CAD6E947908279175AF8470A025A7D7DC4@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A7D7DC4@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus WALLEIJ <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.>
List-Id: linux-omap@vger.kernel.org

On Wed, 26 May 2010, Linus WALLEIJ wrote:

> Overall as a driver writer I'm quite confused at this point, if
> I have a driver X, how is that code going to look if it is going
> to support both runtime PM *and* suspend blockers? I don't say
> it has to support both mechanisms in parallell, I'm even fine
> with putting it in #ifdef:s, but how will the source code look?
> A real-world example on a simple driver out of the Motorola Droid
> git or so would help a lot.
> 
> It's quite relevant since e.g. all OMAP drivers will need this
> modification to be used with Android-like systems, and at
> ST-Ericsson we will need both runtime PM and suspend blockers for
> our drivers as well. It will as a consequence affect the drivers
> for all ARM reference boards since we use the drivers for ARM
> PrimeCells. etc...
> 
> Now if this mechanism is going in, my main interest is that there
> is some clearly cut way and design pattern for supporting both
> runtime PM and suspend blocks.

It's not difficult.  You just have to decide what situations should 
block opportunistic suspend.  For example, let's say that opportunistic 
suspend should be blocked when your event queue is non-empty.

Then in the routine that adds new events to the queue, while still
holding the spinlock that protects your queue, you enable your suspend
blocker.  Likewise, in the routine that takes events off the queue and
sends them to userspace, while holding the spinlock you test whether
the queue has become empty; if it has you disable your suspend blocker.

That's all.  No other changes are needed (except to create and destroy 
the suspend blocker, of course).  No other interaction with suspend, 
resume, or runtime PM.

Alan Stern
