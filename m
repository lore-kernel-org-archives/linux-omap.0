From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: MUSB: BUG on potential deadlocks
Date: Fri, 31 Aug 2007 09:18:10 -0700
Message-ID: <46D83F42.5090004@mvista.com>
References: <20070831025359.663866890@mvista.com>
	<20070831025811.887406517@mvista.com>
	<20070831060525.6B49D23744C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070831060525.6B49D23744C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
>> There are several places where locks are assumed to be held and are
>> unlocked.  BUG-out when the lock is not actually held.
> 
> This isn't a good patch.  *ADDING* a BUG() is wrong, and that's
> especially true for things like spin_is_locked() 

I probably should've made this an RFC instead of a patch.  I meant for
this to be a debug aid, not to actually go into the tree.  I'm using
this to try to track down some deadlocks and thought it may be useful to
others.  It has already turned up a couple problems (see below.)

>> --- dev.orig/drivers/usb/musb/musb_gadget.c
>> +++ dev/drivers/usb/musb/musb_gadget.c
>> @@ -118,6 +118,7 @@ __acquires(ep->musb->lock)
>                      ^^^^^^^^^^^
> Functions with "sparse" annotations get static checking from that
> tool.  I'm not sure how much I trust it, but it *has* reported a
> few locking bugs.  Currently, "-Wcontext" is the default, and this
> whole driver passes "sparse" fine (other than a few warnings bout
> not understanding CPP).
>
> Several a few of these are in functions with the "sparse" annotations,
> since they need to do things like temporarily dropping the spinlock so
> a callback could reenter the driver.

OK, I was wondering what those annotations were used for.  I hadn't used
sparse for this before.  Several of the functions which drop and re-take
the lock are not annotated.  I'll add annotations and see if sparse
turns up any more problems.

> It'd be much better to actually submit fixes for any locking bugs
> than to add BUG_ON() statements.

I agree, and I'm working on the fixes.  Just not sure I have the right
fix yet.

For exaple, I've found a couple paths where the BUG_ON() has definitely
turned up a problem:

dma_controller_irq
 musb_dma_completion
  musb_g_rx  (or musb_host_rx in host mode)
   musb_g_giveback (musb_advance_schedule --> musb_giveback)

In both host and gadget cases, the giveback function is entered without
the lock being held and tries to unlock the lock.  The comment in
musb_dma_completion says that the lock is held, but it's not when called
from the DMA IRQ ( but is when called from davinci_irq via
cppi_completion.)

I've tried putting a lock around this in a few ways, and can get gadget
to work without a deadlock, but doing so causes host mode to stop
detecting devices.  I'm still trying to figure out why.

Kevin
