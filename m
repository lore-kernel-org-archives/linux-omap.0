From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 10:29:10 -0800
Message-ID: <20120205182910.GK1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120205175809.GF17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61203 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab2BES3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 13:29:14 -0500
Content-Disposition: inline
In-Reply-To: <20120205175809.GF17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 09:27]:
> On Sun, Feb 05, 2012 at 09:29:25AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 04:28]:
> > > In any case, here's my current (tested) patch unbreaking OMAP as a whole,
> > > not only for all these section mismatches but the more fundamental issues
> > > like the broken serial ports on OMAP3 and the irq domain buggeration too.
> > > 
> > > This leaves one section mismatch for me in the OMAP hotplug code.
> > 
> > OK great all the section mismatch warning fixes look correct to me
> > except one. The ones that make things __init should be a separate
> > clean-up patch for the next merge window.
> 
> Err.  This stuff _really_ isn't merge window stuff.  It's -rc stuff.  Why?
> 
> If there's the possibility that stuff in the .init sections could be
> called after it has been discarded (which is basically what the
> section mismatch warnings are telling you) there is the potential for
> OOPSing the kernel.
> 
> They are _bug_ fixes.

Of course if that's the case.
 
> So, we have a non-__init function calling an __init function which will
> be discarded at runtime and the memory associated with omap2_hsmmc_init()
> poisoned.
> 
> Now, the question is, can this function be called at runtime?  Well,
> this is platform data for the TWL4030 GPIO platform device, and the
> TWL4030 GPIO platform driver is a loadable module:
> 
> config GPIO_TWL4030
>         tristate "TWL4030, TWL5030, and TPS659x0 GPIOs"
> 
> So, it can be built as a loadable module, and then loaded into the
> kernel _after_ the __init code has been discarded.  When that happens
> on the 3430SDP, the .setup function will be called, and therefore the
> discarded omap2_hsmmc_init() will also be called.
> 
> Therefore omap2_hsmmc_init() and its called functions _must_ _not_ be
> marked __init - or 3430SDP needs to be fixed so that HSMMC is not
> dependent on TWL4030.
> 
> But, as long as the code is structured in this way, the HSMMC code
> _must_ lose its __init attributes.
> 
> What I suggest is that these changes get applied as is for -rc, fixing
> the OOPS potential of the current situation.  Then, for the merge window,
> a proper solution to the 'omap2_hsmmc_init() might be called after init
> time' problem gets merged and then these functions can go back to being
> __init marked.
> 
> > Does making sdp3430_twl_gpio_setup() into __init fix those warnings
> > for you? That should be safe as omap3430_i2c_init() is __init.
> 
> See above why that's a very very wrong solution.

Argh. Yes you're right, the card change detect GPIOs on I2C cause the
nasty issue here if twl is a module. How horrible.
 
> > All the omap_mux_init_* functions should also __init. Again, there's
> > something wrong with the calling function if the caller is not __init.
> 
> I disagree.
> 
> Unfortunately, you have code which is not __init only which calls them.
> As I've already proven above, for example, hsmmc stuff must not be marked
> __init given the current structure of OMAP code.  Because hsmmc calls
> into the OMAP mux stuff (specifically omap_mux_init_signal()) it too
> can't be marked __init.
> 
> So, for now the __init stuff must go, until the bigger problem of
> why omap2_hsmmc_init() can get called from non-init contexts.

Argh. Yes right you are. We need to fix this properly too though, this
is only a short term solution.

> > > --- a/arch/arm/mach-omap2/pm34xx.c
> > > +++ b/arch/arm/mach-omap2/pm34xx.c
> > > @@ -420,7 +420,7 @@ static void omap3_pm_idle(void)
> > >  {
> > >  	local_fiq_disable();
> > >  
> > > -	if (omap_irq_pending())
> > > +	if (omap_irq_pending() || 1)
> > >  		goto out;
> > >  
> > >  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> > 
> > This does not look right to me. I thought reverting of the serial
> > patches should have already solved the issue you're seeing with
> > slow serial port?
> > 
> > Those are the reverting commits drivers/tty/serial/serial-omap.c:
> > 
> > 8a74e9ffd97dc9de063de8c02ae32db79dd60436 (Revert "tty: serial: OMAP: ensure
> > FIFO levels are set correctly in non-DMA mode")
> > 
> > af681cad3f79ad8f7bd6cb170b70990aeef74233 (Revert "tty: serial: OMAP: transmit
> > FIFO threshold interrupts don't wake the chip")
> 
> These commits have absolutely nothing to do with it.  I pointed out the
> bad commit in one of my emails:
> 
> commit 2fd149645eb46d26130d7070c6de037dddf34880
> Author: Govindraj.R <govindraj.raja@ti.com>
> Date:   Wed Nov 9 17:41:21 2011 +0530
> 
>     ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
>     
>     Omap_uart_can_sleep function blocks system wide low power state until
>     uart is active remove this func and add qos requests to prevent
>     MPU from transitioning.
>     
>     Keep qos request to default value which will allow MPU to transition
>     and while uart baud rate is available calculate the latency value
>     from the baudrate and use the same to hold constraint while uart clocks
>     are enabled, and if uart is auto-idled the constraint is updated with
>     default constraint value allowing MPU to transition.
>     
>     Qos requests are blocking notifier calls so put these requests to
>     work queue, also the driver uses irq_safe version of runtime API's
>     and callbacks can be called in interrupt disabled context.
>     So to avoid warn on slow path warning while using qos update
>     API's from runtime callbacks use the qos_work_queue.
>     
>     During bootup the runtime_resume call backs might not be called and runtime
>     callback gets called only after uart is idled by setting the autosuspend
>     timeout. So qos_request from runtime resume callback might not activated during
>     boot if uart baudrate is calculated during bootup for console uart, so schedule
>     the qos_work queue once we calc_latency while configuring the uart port.
>     
>     Flush and complete any pending qos jobs in work queue while suspending.
>     
>     Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>     Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for drivers/tty changes)
>     Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> Basically, it looks like the OMAP 3 UART is not delivering transmit IRQs
> while in some of the deeper low power modes.
> 
> I tried reverting the rest of the patches between this one and HEAD for
> omap-serial.c, but they have no effect what so ever on this bug.  As I
> said in one of my emails in this thread, the above commit can't be
> trivially reverted because some other stuff that the code relied upon
> has vanished.
> 
> So, the above along with the other part in arch/arm/mach-omap2/cpuidle34xx.c
> is the smallest 'fix' I could find of resolving the regression.

OK, thanks, that should be enough info for let Kevin take a look at this.

Regards,

Tony

