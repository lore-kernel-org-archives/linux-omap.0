From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: power states transitions
Date: Wed, 25 Nov 2015 21:48:30 +0200
Message-ID: <CAJ2oMhKayCodLD_M+K07A3EvaGb=rAmcNWNcmYUeq=eRbcP-vQ@mail.gmail.com>
References: <CAJ2oMhLmViYf=27nVh_=DBFyQLCcBT+985RTkMiwJZyav7Uiyg@mail.gmail.com>
	<20151125185014.GN2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20151125185014.GN2517@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 25, 2015 at 8:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ran Shalit <ranshalit@gmail.com> [151122 07:59]:
>> Hello,
>>
>> I have stranhe behaviour in which even when there is no activity in
>> serial port, the retention counter is keep incremented all these time,
>> as if the cpu gets in and out of retention periodically.
>> I would expect the cpu to get into retention mode, when there is no
>> activity and stay in that state.
>> What can cause such behaviour ? Is it because some background process ?
>
> Sounds like your device is hitting deper idle states during idle. If
> you want to disable that, set the UART autosuspend_delay_ms to -1:
>
> #/bin/bash
> uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
> for uart in $uarts; do
>         echo -1 > $uart/autosuspend_delay_ms 2>&1
> done
>
> The above will keep the UARTs active blocking any deeper idle
> states. I believe the value has to be -1 instead of 0 to disable
> autoidle.. but please verify yourself.
>
>> My original problem is that the ethernet performance is very low with
>> small windows. I thought that I can control this value by changing
>> sleep_latency parameter in
>> the following array. Yet, it did not help me. I don't know why.
>
> Maybe test if the above script helps with the Ethernet too. If the
> Ethernet controller is on GPMC, it's not blocking deeper idle states
> automatically in hardware. Adding DMA support to the Ethernet driver
> would be a good way to block deeper idle states automatically by
> the Ethernet hardware.
>

Hi Tony,

We actually want the deeper state, but not in the price of performance...
So I thought of these possibilities:
1. configure the sleep state to check activity for a longer time than
micro seconds (several seconds). If there is non activity in that long
period, only than will move to retention. I am not sure if there is
such configuration parameter . Maybe one of the following parameters
can be configured for this option ?

46 struct cpuidle_params {
 47         u32 exit_latency;       /* exit_latency = sleep + wake-up
latencies */
 48         u32 target_residency;
 49         u8 valid;               /* validates the C-state */
 50 };

2. Another option can be to write a kernel module which check if there
is ethernet activity for X seconds, if there is none - it will enable
power management , otherwise - it will disable the power management.

These maybe can solve the ethernet issue, but I still not sure why
there is constantly incrementation in the retention state, as if it
enter and leave the state all periodically. Is it becuase some
task/thread/process in the system (I guess it can be a kernel process
actually) ?

Regards,
Ran
