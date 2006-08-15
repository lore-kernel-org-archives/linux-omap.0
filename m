From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
Date: Tue, 15 Aug 2006 15:17:15 -0700
Message-ID: <200608151517.16378.david-b@pacbell.net>
References: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231F5B@dlee08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231F5B@dlee08.ent.ti.com>
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
To: "Johnson, Steve-OMAP" <stevej@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 15 August 2006 3:03 pm, Johnson, Steve-OMAP wrote:
> David,
> 
> Thanks.  I'll let marketing know and ask them to fix the graphic.

Good, so issue #2 is resolved ... this _is_ OMAP1-only, the Kconfig is right.

How about #1?  Likely it's too late to resolve that doc ambiguity, but it'd
be good to know the answer anyway. :)

- Dave


> > > > Could someone confirm that this RTC can't actually do 
> > > > system wakeups 
> > > > without external hardware support?  My documentation isn't at all 
> > > > clear on that issue.  There's certainly an external wakeup signal 
> > > > available, but text also says that the alarm irq should work the 
> > > > normal way ... but I don't see that happening.  It could 
> > > > easily be just a bug in
> > > > enable_irq_wakeup(INT_RTC_ALARM) handling, which ISTR 
> > > > looked like a 
> > > > big NOP last I checked (for almost all IRQs).
