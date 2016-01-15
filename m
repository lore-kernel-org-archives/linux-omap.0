From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] reboot: Backup orderly_poweroff
Date: Fri, 15 Jan 2016 11:13:12 +0100
Message-ID: <20160115101312.GA23349@gmail.com>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com>
 <569767EC.2010704@ti.com>
 <20160114100913.GB15857@gmail.com>
 <56977BA7.702@ti.com>
 <20160114112354.GA17869@gmail.com>
 <20160114142227.GB5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160114142227.GB5783@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Keerthy <a0393675@ti.com>, nm@ti.com, grygorii.strashko@ti.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org, peterz@infradead.org, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, josh@joshtriplett.org, edubezval@gmail.com, joel@jms.id.au, mpe@ellerman.id.au, akpm@linux-foundation.org, linux-omap@vger.kernel.org, dyoung@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


* Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Jan 14, 2016 at 12:23:54PM +0100, Ingo Molnar wrote:
> > * Keerthy <a0393675@ti.com> wrote:
> > > I tried to simulate the issue.
> > > 
> > > In the probe function of drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > > ti_bandgap_probe i call
> > > 
> > > orderly_poweroff(true);
> > > 
> > > This is while driver probes are still on going. I observe that
> > > ret = run_cmd(poweroff_cmd);
> > > 
> > > ret is a non-zero value and we enter the if condition:
> > > 
> > > Even after the
> > > 
> > > emergency_sync();
> > > kernel_power_off();
> > > 
> > > calls
> > > 
> > > the console remained active in weird state.
> > 
> > Now _that_ is clearly an architecture bug that should not be papered over ...
> 
> No, it's not an architecture bug - it's a platform bug. [...]

It's an 'architecture bug' in Linux kernel speak: all stuff that is traditionally 
under arch/*. The 'arch' in that directory name derives from 'architecture'.

kernel_power_off() is a traditionally architecture level (not core kernel level 
and not driver level) code.

> [...] The ARM architecture has no standard way to control CPU reset or system 
> power, all that is up to the platform.

... and platform code is typically part of arch/ as well.

FYI, you are making an unnecessarily obtuse argument by insisting on the 
architecture != platform triviality and you also injected an uncalled for 
patronizing tone into this discussion by pretending that I don't know that 
distinction. It's sad.

> > If kernel_power_off() is called then the system should power off. No ifs and 
> > whens.
> 
> There definitely are ifs and whens.  Only if the platform has support, and when 
> that support works.

And that is precisely what I meant: in a correctly working kernel, with correctly 
working hardware, in a correctly working universe, the core kernel expects 
kernel_power_off() to never 'fail'.

As the name suggests.

Yes, bugs in user-space, kernel-space, hardware and designed buggy hardware might 
prevent a reboot - as usual.

I.e. I NAK this patch from a core kernel perspective, we don't add such 
workarounds without a lot more information about why it's the right thing to do.

Thanks,

	Ingo
