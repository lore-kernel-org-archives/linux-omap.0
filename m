From: Tony Lindgren <tony@atomide.com>
Subject: Re: power states transitions
Date: Wed, 25 Nov 2015 10:50:15 -0800
Message-ID: <20151125185014.GN2517@atomide.com>
References: <CAJ2oMhLmViYf=27nVh_=DBFyQLCcBT+985RTkMiwJZyav7Uiyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ2oMhLmViYf=27nVh_=DBFyQLCcBT+985RTkMiwJZyav7Uiyg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [151122 07:59]:
> Hello,
> 
> I have stranhe behaviour in which even when there is no activity in
> serial port, the retention counter is keep incremented all these time,
> as if the cpu gets in and out of retention periodically.
> I would expect the cpu to get into retention mode, when there is no
> activity and stay in that state.
> What can cause such behaviour ? Is it because some background process ?

Sounds like your device is hitting deper idle states during idle. If
you want to disable that, set the UART autosuspend_delay_ms to -1:

#/bin/bash
uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
for uart in $uarts; do
        echo -1 > $uart/autosuspend_delay_ms 2>&1
done

The above will keep the UARTs active blocking any deeper idle
states. I believe the value has to be -1 instead of 0 to disable
autoidle.. but please verify yourself.

> My original problem is that the ethernet performance is very low with
> small windows. I thought that I can control this value by changing
> sleep_latency parameter in
> the following array. Yet, it did not help me. I don't know why.

Maybe test if the above script helps with the Ethernet too. If the
Ethernet controller is on GPMC, it's not blocking deeper idle states
automatically in hardware. Adding DMA support to the Ethernet driver
would be a good way to block deeper idle states automatically by
the Ethernet hardware.

Regards,

Tony
