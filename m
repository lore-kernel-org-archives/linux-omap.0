From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] reboot: Backup orderly_poweroff
Date: Thu, 14 Jan 2016 12:23:54 +0100
Message-ID: <20160114112354.GA17869@gmail.com>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com>
 <569767EC.2010704@ti.com>
 <20160114100913.GB15857@gmail.com>
 <56977BA7.702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56977BA7.702@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, edubezval@gmail.com, grygorii.strashko@ti.com, nm@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, joel@jms.id.au, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, dyoung@redhat.com, josh@joshtriplett.org, mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org


* Keerthy <a0393675@ti.com> wrote:

> I tried to simulate the issue.
> 
> In the probe function of drivers/thermal/ti-soc-thermal/ti-bandgap.c
> ti_bandgap_probe i call
> 
> orderly_poweroff(true);
> 
> This is while driver probes are still on going. I observe that
> ret = run_cmd(poweroff_cmd);
> 
> ret is a non-zero value and we enter the if condition:
> 
> Even after the
> 
> emergency_sync();
> kernel_power_off();
> 
> calls
> 
> the console remained active in weird state.

Now _that_ is clearly an architecture bug that should not be papered over ...

If kernel_power_off() is called then the system should power off. No ifs and 
whens.

Thanks,

	Ingo
