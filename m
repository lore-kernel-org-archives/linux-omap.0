From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.21-rc1 merge status
Date: Mon, 19 Feb 2007 10:39:19 -0800
Message-ID: <200702191039.19560.david-b@pacbell.net>
References: <45D892A1.9040006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45D892A1.9040006@googlemail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sunday 18 February 2007 9:53 am, Dirk Behme wrote:

> Dave: Can you give us an update about I2C status in 
> 2.6.21-rc1, what went in and what not? What's about the idea 
> of "embedded I2C stack"? Many thanks!

If you recall, the patches I did in November were eventually split
into "Phase I" and "Phase II".

 - One of the "Phase I" patches is in RC1 ... adding new methods
   for I2C drivers to suspend()/resume()/shutdown().  Ditto several
   semi-related patches making I2C adapter drivers link up to their
   adapter hardware device.  All are what I'd call minor updates,
   most of which barely missed the 2.6.20 merge window.

 - The other "Phase I" issues are still pending, fixed I think in
   in recent MM patch sets but expected to stay there unti 2.6.22
   merge window opens.  The strategy to remove i2c_adapter_driver
   mistake has done a 180-degree turn because of this new "remove
   class_device" jihad (which you can NOT read about in the feature
   removal schedule) ... much wasted time, without which I think
   all that phase I stuff would have been in 2.6.21 (sigh).

 - Accordingly I see no way the "Phase II" stuff (most interesting
   for OMAP, because it means the I2C stack can behave with adapters
   that can't support SMBUS_QUICK) to merge before 2.6.22 starts.

I recently refreshed the core "Phase II" patches, and Jean hopes to
re-review those phase II patches this week.  With any luck that means
they will then enter his patch queue (for 2.6.22).

And then it'd be worth refreshing the patches which _use_ those
new APIs ... e.g. the OSK patches I sent at some point.

I don't see a rewrite of I2C coming any time soon, or teaching it
how to do async messaging.  But the "Phase II" stuff should help
resolve the main technical issues I recall motivating folk to think
about wanting a whole new "embedded" I2C stack:  the requirement
for SMBUS_QUICK, the inability to pass board-specific platform_data
to drivers, the odd belief that I2C chips don't need to issue IRQs.

- Dave
