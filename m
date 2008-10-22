From: David Brownell <david-b@pacbell.net>
Subject: Re: 32 kHz timer granularity when CONFIG_NO_HZ is enabled
Date: Wed, 22 Oct 2008 12:06:19 -0700
Message-ID: <200810221206.19642.david-b@pacbell.net>
References: <48FF26DE.4060107@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:48772 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751654AbYJVTG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 15:06:29 -0400
In-Reply-To: <48FF26DE.4060107@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 22 October 2008, Sakari Ailus wrote:
> Hi,
> 
> I have OMAP 3 and I'm using the 32 kHz timer, CONFIG_OMAP_32K_TIMER_HZ 
> is set to 128 and CONFIG_NO_HZ is enabled. Many OMAP-based boards in 
> arch/arm/config seem to have this kind of default configuration.
> 
> This has the effect that for example msleep(1) sleeps much longer than 
> intended, between 7,8 and 15,6 ms, for no apparent good reason.

1000 ms/sec / 128 HZ/sec == 7.8 ms/HZ

The "good reason" is that msleep() takes at least one HZ,
since it's based on the scheduler's use of jiffies.


> I'm just wondering whether all this is intentional. :-)

A patch to make msleep() use hrtimers didn't fly; the
change in semantics could make trouble, despite the
acknowledged problems of using jiffies instead of wall
clock time.

I can think of several semantic variants of msleep that
might be wanted:

  msleep_deferrable() ... still HZ based, but ok to defer
	the tick for IRQ reduction
  msleep_exact() ... uses hrtimers, almost certainly
	costs an IRQ (unless HIGH_RES_TIMERS is off)
  msleep_fuzzy() ... current semantics, units of jiffies
	but not deferrable

Folk seem mostly content with fuzzy() for now, although
there are certainly folk who'd rather have exact().  And
the slowdown of an msleep(1) is probably the canonical
example of why exact() would collect users.

- Dave
