From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 27 May 2010 11:33:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271121210.3239-100000@iolanthe.rowland.org>
References: <CEE6BB42CAD6E947908279175AF8470A025A8206ED@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A8206ED@EXDCVYMBSTM006.EQ1STM.local>
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

On Thu, 27 May 2010, Linus WALLEIJ wrote:

> OK I understand it will be rather OK to do this. For example I have
> drivers/spi/amba-pl022.c which is quite clearly taking elements
> off a queue and transmitting them.
> 
> Currently, as we do not have suspend blockers, we try to stop the
> queue in suspend() and if that fails we return something negative
> so that the suspend() is blocked by the negative return code.

How can it fail?  Even if the queue can't be stopped immediately, can't
the suspend routine block for a few milliseconds until the queue can be 
stopped?

> Maybe the behaviour for an SPI bus should rather be to return
> -EBUSY as long as there are events in the queue. I don't quite
> know frankly.

No.  It should stop the queue.

Think of it this way: Somebody has just closed the lid of their 
laptop and thrown the computer into a backpack.  You don't want the 
machine to fail to suspend merely because an SPI queue wasn't empty.

> (We haven't added runtime PM yet, it will likely be the same
> thing.)

Runtime PM is very different.  It is supposed to take effect only when 
the device is idle.  So failing if the queue is non-empty makes sense.

> With suspend blockers we take a suspend blocker when we add
> elements to the queue and release it when the queue is empty.
> 
> But with suspend blockers the need for suspend() to check if
> the queue can be stopped or return -EBUSY if there are elements
> in it is not necessary: suspend() simply won't be called
> since a suspend blocker is taken.

No, that's completely wrong.  The user can tell the computer to suspend
at any time, whether or not any suspend blockers are enabled.  Think of
the laptop-in-the-backpack case.

> There is no way for
> suspend() to stop a running queue like we do today if using
> suspend blockers.

I don't know what you mean by this, but it doesn't sound right.

> This means that driver writers only targeting configurations
> where suspend blockers are used will probably not care about
> handling suspend() calls by trying to stop the queue or
> checking if there are things in it, because there will never
> be anything there.

You also have to handle races.  What happens if your suspend routine is 
called, and at that moment an interrupt occurs, causing the driver to 
add an entry to the queue?

You're trying to over-simplify this, probably because you're not 
thinking about it in the right way.  To put it bluntly, suspend 
blockers should not affect with your suspend/resume routines at all.

> So while it is easy for me to have the driver work under both
> suspend blockers and runtime PM or common suspend(), the
> two configurations actually have different semantics of the
> suspend() call: in the suspend blockers case you don't need
> to check anything, just suspend, and in  the runtime PM
> case you have to check that you can actually suspend.

The suspend-blockers case is exactly the same as the normal suspend 
case.  The runtime PM case does require extra checking.

> Is this analysis correct?

No, it's mostly wrong.

Alan Stern
