From: Tony Lindgren <tony@atomide.com>
Subject: Re: power states transitions
Date: Wed, 25 Nov 2015 13:11:33 -0800
Message-ID: <20151125211132.GU2517@atomide.com>
References: <CAJ2oMhLmViYf=27nVh_=DBFyQLCcBT+985RTkMiwJZyav7Uiyg@mail.gmail.com>
 <20151125185014.GN2517@atomide.com>
 <CAJ2oMhKayCodLD_M+K07A3EvaGb=rAmcNWNcmYUeq=eRbcP-vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ2oMhKayCodLD_M+K07A3EvaGb=rAmcNWNcmYUeq=eRbcP-vQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [151125 11:49]:
> On Wed, Nov 25, 2015 at 8:50 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> We actually want the deeper state, but not in the price of performance...
> So I thought of these possibilities:
> 1. configure the sleep state to check activity for a longer time than
> micro seconds (several seconds). If there is non activity in that long
> period, only than will move to retention. I am not sure if there is
> such configuration parameter . Maybe one of the following parameters
> can be configured for this option ?
> 
> 46 struct cpuidle_params {
>  47         u32 exit_latency;       /* exit_latency = sleep + wake-up
> latencies */
>  48         u32 target_residency;
>  49         u8 valid;               /* validates the C-state */
>  50 };
> 
> 2. Another option can be to write a kernel module which check if there
> is ethernet activity for X seconds, if there is none - it will enable
> power management , otherwise - it will disable the power management.

It really should be implemented with the standard pm_runtime calls in the
Ethernet driver. Maybe you can clk_get some parent clock from the Ethernet
driver that will block the idle state?

> These maybe can solve the ethernet issue, but I still not sure why
> there is constantly incrementation in the retention state, as if it
> enter and leave the state all periodically. Is it becuase some
> task/thread/process in the system (I guess it can be a kernel process
> actually) ?

I think what you're seeing is the kernel idle code incrementing it
every time the SoC hits idle.

Regards,

Tony
