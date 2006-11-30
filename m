From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 13:30:03 -0800
Message-ID: <200611301330.04176.david-b@pacbell.net>
References: <EA12F909C0431D458B9D18A176BEE4A508CE02C7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A508CE02C7@dlee02.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 30 November 2006 11:57 am, Woodruff, Richard wrote:

> That code uses two timers to account for isr latency and to provide
> accurate timestamps.  One timer is periodic and the other is free
> running. The 2nd is used as a relative reference.  Along with being used
> as a reference the 2nd free runner uses its current value and its roll
> over interrupt to sum/calculate the number of ns the system has been up.
> This enables sched_clock to be enabled with accuracy (vs. just
> multiplying times jiffies).
> 
> The single timer method does not do either of these.  The code was
> reasonably clear, I also sent in a path long ago to enable this.  Is
> there some aspect of this which I mis-understood?

If you did, I had the same mis-understanding.  Ergo the patch(es) I've
sent.

I don't think the roll-over IRQ is significant in the new clock framework,
but I do think that the second MPU timer is important if there's a chance
of lost timer IRQs ... probably negligible at HZ=100, less so when the option
of HZ=1000 is configured.

Plus, ISTR that the upcoming generic dyntick support will need to reprogram
the periodic IRQ, just like the current OMAP-specific code using timer32k.

- Dave
