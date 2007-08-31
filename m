From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] ARM: OMAP: MUSB: BUG on potential deadlocks
Date: Thu, 30 Aug 2007 23:05:26 -0700
Message-ID: <20070831060525.6B49D23744C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20070831025359.663866890@mvista.com>
	<20070831025811.887406517@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070831025811.887406517@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, khilman@mvista.com
List-Id: linux-omap@vger.kernel.org

> There are several places where locks are assumed to be held and are
> unlocked.  BUG-out when the lock is not actually held.

This isn't a good patch.  *ADDING* a BUG() is wrong, and that's
especially true for things like spin_is_locked() ... which has
historically lied, and in any case doesn't reflect the requirement
that the lock holder be the current execution context instead of
some other context.  And if it

And unfortunately all of these use spin_is_locked()...

Also:


> --- dev.orig/drivers/usb/musb/musb_gadget.c
> +++ dev/drivers/usb/musb/musb_gadget.c
> @@ -118,6 +118,7 @@ __acquires(ep->musb->lock)
                     ^^^^^^^^^^^
Functions with "sparse" annotations get static checking from that
tool.  I'm not sure how much I trust it, but it *has* reported a
few locking bugs.  Currently, "-Wcontext" is the default, and this
whole driver passes "sparse" fine (other than a few warnings bout
not understanding CPP).

Several a few of these are in functions with the "sparse" annotations,
since they need to do things like temporarily dropping the spinlock so
a callback could reenter the driver.


It'd be much better to actually submit fixes for any locking bugs
than to add BUG_ON() statements.

- Dave
