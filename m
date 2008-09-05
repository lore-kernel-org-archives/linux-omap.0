From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc5-omap1] rtc-twl4030 cleanup
Date: Fri, 5 Sep 2008 01:09:39 -0700
Message-ID: <200809050109.39844.david-b@pacbell.net>
References: <200809041024.18572.david-b@pacbell.net> <200809041048.46177.david-b@pacbell.net> <EAF47CD23C76F840A9E7FCE10091EFAB027DF89BDB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:37675 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752602AbYIEIJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 04:09:50 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB027DF89BDB@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 05 September 2008, Pakaravoor, Jagadeesh wrote:
> RTC generates an extra spurious interrupt for every actual periodic
> interrupt. This is due to a problem with the RTC_IT bit of
> REG_PWR_ISR1. It requires two writes or two reads (when COR is 
> enabled) to clear it. Since COR is enabled and one read of the same
> register is done already (inside twl4030-pwrirq.c do_twl4030_pwrirq()
> function), all we need is one more read.
> 
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Yes, that seems to make the 1/second update IRQs work right.
Thanks!

Were alarm IRQs having the same problem, just not as noticably?

The two other technical issues I know about with this driver
also relate to IRQs:

  - Is it really true that alarm and update IRQs are
    mutually exclusive?  Unusual if so ...

	+ if exclusive, then don't let both be enabled
	  at the same time (the way it now does)!

	+ else, update irq handler so the comment is
	  correct, and so the code stops assuming
	  it's alarm -or- update irqs ... it should
	  be possible to report *both* events at once.

  - Are there any reasons alarm IRQs wouldn't be able
    to wake the system from sleep states (STR etc)?

    If not, then need to update suspend() to leave
    the alarm active (yes?) and do various other stuff
    related to driver model wakeup flags; rtc-omap.c
    can be an example.  (Except for leaving update
    IRQs active...)

The wakeup stuff will let programs like rtcwake work,
and enable the /sys/class/rtc/rtc0/wakealarm file.
It's better to have that stuff work than not, even
if OMAP power management uses states like STR very
differently than most other Linuxes.

- Dave

