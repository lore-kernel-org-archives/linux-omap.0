From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: In many cases softlockup can not be reported after disabling
	IRQ for long time
Date: Sat, 4 Feb 2012 12:22:46 +0000
Message-ID: <20120204122246.GG1275@n2100.arm.linux.org.uk>
References: <CAOwKts8zS1rYA+Y4k-vb8YAaR=aFd1BwryhhWWnWLQyrYrNqyA@mail.gmail.com> <20120131154748.GA5650@redhat.com> <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com> <20120201145802.GF5650@redhat.com> <CAOwKts8S0EkUGcP3rYqZe+HdvyXD0+SR1f_3xWpu5FprKWuGhQ@mail.gmail.com> <20120202084350.GB1275@n2100.arm.linux.org.uk> <CAOwKts--CDpmiMunfYKrYsnWovmQhAC7Vp0P-9MeNVy6vx-Wvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50444 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2BDMXL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 07:23:11 -0500
Content-Disposition: inline
In-Reply-To: <CAOwKts--CDpmiMunfYKrYsnWovmQhAC7Vp0P-9MeNVy6vx-Wvw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 02, 2012 at 10:05:22PM +0800, TAO HU wrote:
> I don't know it's already been discussed.
> Appreciate if you could point out existing discussion thread.
> 
> I agree it is impossible to detect "timeout" when using jiffies which
> relies on timer.
> 
> For timestamp, softlockup (watchdog) use cpu_clock() whcih eventually calls
> sched_clock().
> And sched_clock() is implemented to read out the value of a 32K
> timer/counter on OMAP4430.
> That means the timestamp will be still updated while the IRQ is disabled.

Yes, and it'll take 131072 seconds to wrap.

> So when IRQ is re-enabled, softlockup code will be able to read a "fresh"
> timestamp which can be used to
> detect the timeout.
> 
> 
> static unsigned long get_timestamp(int this_cpu)
> {
> return cpu_clock(this_cpu) >> 30LL; /* 2^30 ~= 10^9 */
> }
> 
> unsigned long long __attribute__((weak)) sched_clock(void)
> {
> return (unsigned long long)(jiffies - INITIAL_JIFFIES)
> * (NSEC_PER_SEC / HZ);
> }
> 
> #ifndef CONFIG_OMAP_MPU_TIMER
> unsigned long long notrace sched_clock(void)
> {
> return _omap_32k_sched_clock();
> }
> #else
> unsigned long long notrace omap_32k_sched_clock(void)
> {
> return _omap_32k_sched_clock();
> }
> #endif

I guess someone needs to do some tracing to see what's going on, and
get a feel for the order in which things happen.  (Or add some printks.)

Is there a ready-prepared bit of code I can try?
