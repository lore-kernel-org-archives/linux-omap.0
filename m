From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 0/2] MUSB: tracking down locking bugs
Date: Thu, 30 Aug 2007 23:04:13 -0700
Message-ID: <46D7AF5D.2020204@mvista.com>
References: <20070831025359.663866890@mvista.com>
	<20070831054830.13B7B21D977@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070831054830.13B7B21D977@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
>> With the help of the lock debugging features of the -rt patch, I'm
>> trying to track down locking issues in the MUSB driver.
> 
> It was last done about 18 months ago, so it's clearly Time to
> check those locks again.  :)

Agreed.

In the short term, I'll have a couple more "band-aid" style patches for
you to sanity check.  They fix a couple deadlocks uncovered by my
'BUG_ON' patch, but since I don't know this driver all that well, there
may be better ways to do things.

For the long term, more lock granularity should probably be used.  For
example, currently the entire interrupt handler wrapped with a
spin_lock_irqsave().  When moving to the threaded interrupts of
PREEMPT_RT, this effictively negates the benefit of having threaded
handlers in the first place.

Kevin
