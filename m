From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP34xx
Date: Tue, 07 Feb 2012 14:36:06 -0800
Message-ID: <87lioegtk9.fsf@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
	<20120204190109.GL20333@atomide.com>
	<20120204203453.GD17309@n2100.arm.linux.org.uk>
	<20120205012556.GG1426@atomide.com>
	<20120205125904.GB11372@n2100.arm.linux.org.uk>
	<20120205172925.GS20333@atomide.com>
	<20120205175809.GF17309@n2100.arm.linux.org.uk>
	<20120205182910.GK1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41534 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756699Ab2BGWgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 17:36:10 -0500
Received: by mail-pz0-f42.google.com with SMTP id g27so9997352dan.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Feb 2012 14:36:09 -0800 (PST)
In-Reply-To: <20120205182910.GK1426@atomide.com> (Tony Lindgren's message of
	"Sun, 5 Feb 2012 10:29:10 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Tony Lindgren <tony@atomide.com> writes:

[...]

>> > > --- a/arch/arm/mach-omap2/pm34xx.c
>> > > +++ b/arch/arm/mach-omap2/pm34xx.c
>> > > @@ -420,7 +420,7 @@ static void omap3_pm_idle(void)
>> > >  {
>> > >  	local_fiq_disable();
>> > >  
>> > > -	if (omap_irq_pending())
>> > > +	if (omap_irq_pending() || 1)
>> > >  		goto out;
>> > >  
>> > >  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> > 
>> > This does not look right to me. I thought reverting of the serial
>> > patches should have already solved the issue you're seeing with
>> > slow serial port?
>> > 
>> > Those are the reverting commits drivers/tty/serial/serial-omap.c:
>> > 
>> > 8a74e9ffd97dc9de063de8c02ae32db79dd60436 (Revert "tty: serial: OMAP: ensure
>> > FIFO levels are set correctly in non-DMA mode")
>> > 
>> > af681cad3f79ad8f7bd6cb170b70990aeef74233 (Revert "tty: serial: OMAP: transmit
>> > FIFO threshold interrupts don't wake the chip")
>> 
>> These commits have absolutely nothing to do with it.  I pointed out the
>> bad commit in one of my emails:
>> 
>> commit 2fd149645eb46d26130d7070c6de037dddf34880
>> Author: Govindraj.R <govindraj.raja@ti.com>
>> Date:   Wed Nov 9 17:41:21 2011 +0530
>> 
>>     ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
>>     
>>     Omap_uart_can_sleep function blocks system wide low power state until
>>     uart is active remove this func and add qos requests to prevent
>>     MPU from transitioning.
>>     
>>     Keep qos request to default value which will allow MPU to transition
>>     and while uart baud rate is available calculate the latency value
>>     from the baudrate and use the same to hold constraint while uart clocks
>>     are enabled, and if uart is auto-idled the constraint is updated with
>>     default constraint value allowing MPU to transition.
>>     
>>     Qos requests are blocking notifier calls so put these requests to
>>     work queue, also the driver uses irq_safe version of runtime API's
>>     and callbacks can be called in interrupt disabled context.
>>     So to avoid warn on slow path warning while using qos update
>>     API's from runtime callbacks use the qos_work_queue.
>>     
>>     During bootup the runtime_resume call backs might not be called and runtime
>>     callback gets called only after uart is idled by setting the autosuspend
>>     timeout. So qos_request from runtime resume callback might not activated during
>>     boot if uart baudrate is calculated during bootup for console uart, so schedule
>>     the qos_work queue once we calc_latency while configuring the uart port.
>>     
>>     Flush and complete any pending qos jobs in work queue while suspending.
>>     
>>     Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>     Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for drivers/tty changes)
>>     Signed-off-by: Kevin Hilman <khilman@ti.com>
>> 
>> Basically, it looks like the OMAP 3 UART is not delivering transmit IRQs
>> while in some of the deeper low power modes.
>> 
>> I tried reverting the rest of the patches between this one and HEAD for
>> omap-serial.c, but they have no effect what so ever on this bug.  As I
>> said in one of my emails in this thread, the above commit can't be
>> trivially reverted because some other stuff that the code relied upon
>> has vanished.
>> 
>> So, the above along with the other part in arch/arm/mach-omap2/cpuidle34xx.c
>> is the smallest 'fix' I could find if resolving the regression.
>
> OK, thanks, that should be enough info for let Kevin take a look at this.

This one is indeed strange.  I have not seen this on the 34xx devices
I'm using (3430/n900, 3530/Overo, 3630/Zoom3).  

Just to confirm.  I assume you are using v3.3-rc2 (or later Linus
master) which has a few fixes for this driver already.

Also, is this happening on your LDP.  Which ES revision does your 3430
have?
 
Kevin



