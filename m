From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Thu, 2 Feb 2012 22:45:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120203150708.386951d2@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Neil.

On Fri, 3 Feb 2012, NeilBrown wrote:

> Can I comment??...  They are good but ....
> 
> I've tried two approaches to getting serial behaviour that I am happy with.
> They are with and without runtime pm.
> 
> If I enable runtime pm by setting power/autosuspend_delay_ms (e.g. to 5000)

Runtime PM should be enabled even with power/autosuspend_delay_ms = 0.  
I think you are simply enabling the autosuspend timer.  There was a 
significant behavior change here from 3.2, I believe.

> then CPUIDLE enters lower states and I think it uses less power but I
> sometimes lose the first char I type (that is known) but also I sometimes get
> corruption on output.

I don't see any output corruption on 35xx BeagleBoard, either with or 
without these patches.  So this is presumably a 37xx-centric problem, and 
unrelated to these patches, I would guess.

> The problem seems to be that we turn off the clocks when the kernel's ring
> buffer is empty rather than waiting for the UART's fifo to be empty.

pm_runtime_put*() calls will write to the CM_*CLKEN registers if the 
usecount goes to zero.  But the PRCM should not actually turn off the 
clocks if the UART isn't idle.  So I would suggest that you first try some 
hwmod CLOCKACTIVITY changes to fix this (described briefly below).

> I can remove this effect with:
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index f809041..c7ef760 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
>  	spin_lock_irqsave(&up->port.lock, flags);
>  	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
>  	spin_unlock_irqrestore(&up->port.lock, flags);
> -	pm_runtime_put(&up->pdev->dev);
> +	pm_runtime_mark_last_busy(&up->pdev->dev);
> +	pm_runtime_put_autosuspend(&up->pdev->dev);
>  	return ret;
>  }

Well this change probably makes sense anyway, just to keep the autosuspend 
behavior consistent when an autosuspend timeout is set.  But the effect of 
this patch may be a little different than what you think; see below.

> i.e. when the tx buffer is empty, so turn the clocks off immediately, 
> but wait a while for the fifo to empty.  Hopefully the auto-suspend time 
> is enough.

Hmm, this statement is a little unclear to me.  The clocks won't be turned 
off immediately - the request to disable the clocks only happens when the 
autosuspend timer expires.  And even then, as mentioned above, it's just a 
request.  The hardware should not actually disable the functional clock 
until the UART FIFO is drained...

Anyway, consider trying a different CLOCKACTIVITY setting for the UARTs.  
There are fields and flags for this in the hwmod code; see for example the 
I2C SYSCONFIG settings in mach-omap2/omap_hwmod_3xxx_data.c.  It's 
possible that the UART is currently assuming that its functional clock 
will stay on when it idle-acks.  That might cause the corruption that you 
are seeing.

> But I decided not to pursue this further as turning off the clocks seems 
> like the wrong thing to be doing.

The clocks should be getting disabled when the autosuspend timer is 0 
also.  It's just that the UART driver will request to disable the clocks 
immediately, rather than waiting.

> The OMAP UARTs have auto-suspend/auto-wake so I would rather depend on 
> that.  And turning off the clocks loses that first character at 115200 
> and above (not below).

If you make a change that causes the kernel to keep the UART clocks on, 
the enclosing clockdomain and any associated clockdomains (probably 
CORE_L3, CORE_L4 & PER) will be prevented from going to sleep.  So just be 
aware that the strategy you are considering will incur an energy 
consumption cost.  The lowest C-state you should manage to reach should be 
C4, at least in mainline terms.

Incidentally, it's unclear to me how you are keeping the clocks on?  Are 
you disabling runtime PM for the driver in some way?

> So I explored leaving the runtime_pm setting as it was.  This set a maximum
> latency of 4444 usec (which should be 5555 as there are 10 bits per char) 
> so it didn't get very low down the CPUIDLE levels.
>
> So I disabled the latency setting with hardware handshaking is used (as you
> suggested once):

[snip]

> and now CPUIDLE uses lower states (especially if I enable_off_mode).

That's good.  One important note is that the CPUIdle statistics don't keep 
track of what C-state was actually entered -- it simply tracks what 
C-state that CPUIdle intended to enter.  So you'll want to check 
/debug/pm_debug/count to be sure.  Also, the PM debug counts are 
approximate.

Incidentally, I have some patches to fix the latency calculation here that 
are in the works, similar to the ones you describe.  The current 
calculation in the driver is pretty broken, but since the changes to fix 
the calculation are rather involved, Kevin and I thought it would be best 
to defer most of them to the v3.4 merge window.  The calculation fix in 
the 3.3-rc series is simply intended to deal with a very basic power 
management regression, as you know - not to make it ideal, which is more 
complicated.  Anyway, the patches are at git://git.pwsan.com/linux-2.6 in 
the branch 'omap_serial_fix_pm_qos_formula_devel_3.4'.  Keep in mind that 
at least one patch in that branch is broken, but perhaps you might get an 
idea of where they are trying to go.  Comments welcome.

> However I am using a lot more power than in 3.2.  

Is this without disabling the UART clocks?  If the driver is keeping the 
UART clocks enabled, then increased power consumption is definitely 
expected.

> That probably isn't all UART-related, but there is one interesting 
> observation.
> 
> If I watch /sys/kernel/debug/pm_debug/time and see where the time is spent
> over a 30second period when the systems is mostly idle:
> 
> With runtime_pm disabled for UARTs, both PER and CORE are permanently ON,
> and MPU is OFF nearly all the time. (This is with off_mode enabled).

How are you disabling runtime PM?  Is this just with the autosuspend 
timeout set to 0?

> If I then enabled runtime_pm with a 5 second autosuspend delay:
>   CORE is still permanently ON (I think the USB might be doing that).
>   PER  is OFF (7 seconds) RET (15 seconds) and ON (8 seconds).
> but more surprising
>   MPU  is OFF (8 sec) RET (8 sec) INA (9 sec) ON (4 secs).
> 
> So we get to turn PER off at the cost of turning the MPU on a lot.
> (the periods in each state are only repeatable to a precision of 20%-50%).
> 
> I understand that PER won't go OFF without runtime PM, but I would expect
> it to at least go to INA as the UART is in smart-idle mode

You are using UART3?  That is in PER and its functional clock comes via 
the PER clockdomain.  If the UART functional clock is prevented from being 
turned off, how can PER go inactive when the UART3 functional clock is 
still enabled?

> The net result is that with runtime_pm enabled I'm seeing an extra 7mA (at
> 4V). That might not be very precise, but it is in the opposite direction to
> my expectations.
> 
> So there is something odd here...  ideas?
> 
> NeilBrown
> 
> p.s. who should I formally submit OMAP-UART patches to?  I have a couple of
> others such as the below that I should submit somewhere.

Would suggest sending them to linux-serial@vger.kernel.org, 
linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, and Alan 
Cox since he is the serial maintainer?  And you should probably also cc 
me, since I seem to be stuck with fixing this driver so I can test my 
other patches; and cc Govindraj as well.


- Paul
