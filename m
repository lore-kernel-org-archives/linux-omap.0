From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: RE: Issues with GPIO and wake from sleep
Date: Tue, 4 Feb 2014 22:47:38 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE09A5B971D@MARCM-SBS2011.marcmltd.local>
References: <F690310232FDDF4AB457E8B3EF90DDE09A56D39C@MARCM-SBS2011.marcmltd.local>,<20140117173902.GD7235@atomide.com>
 <F690310232FDDF4AB457E8B3EF90DDE09A5A80E9@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpout07.bt.lon5.cpcloud.co.uk ([65.20.0.127]:36226 "EHLO
	smtpout07.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933358AbaBDWro convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Feb 2014 17:47:44 -0500
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE09A5A80E9@MARCM-SBS2011.marcmltd.local>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have been looking more into the issue I am having and it looks like the system isnt even entering a fully suspended state;

Tracing through the suspend sequence it looks like it is having trouble with
void omap_sram_idle(void)

The return from pwrm_read_next is 3 (PWRDM_POWER_ON) surely the next power state should be 0 (PWRDM_POWER_OFF)
	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);

	
All the remaining checks are then invalid as it thinks the power domain needs to be on for all;
	/* NEON control */
	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);

	/* Enable IO-PAD and IO-CHAIN wakeups */
	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);

	pwrdm_pre_transition(NULL);

	/* PER */
	if (per_next_state < PWRDM_POWER_ON) {
		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
		omap2_gpio_prepare_for_idle(per_going_off);
	}

	/* CORE */
	if (core_next_state < PWRDM_POWER_ON) {
		if (core_next_state == PWRDM_POWER_OFF) {
			omap3_core_save_context();
			omap3_cm_save_context();
		}
	}

	omap3_intc_prepare_idle();

Is there anywhere I can find out what omap3_pm_suspend()  is supposed to be doing when it traverses through the list of power domains ? 
static int omap3_pm_suspend(void)
{
	struct power_state *pwrst;
	int state, ret = 0;

	/* Read current next_pwrsts */
	list_for_each_entry(pwrst, &pwrst_list, node)
		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
	/* Set ones wanted by suspend */
	list_for_each_entry(pwrst, &pwrst_list, node) {
		if (omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
			goto restore;
		if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
			goto restore;
	}

	omap3_intc_suspend();

	omap_sram_idle();

I think the problem lies in the system thinking it is going from an ON state to an ON state maybe ??

Kind Regards
Marc



-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Marc Murphy
Sent: 23 January 2014 09:45
To: Tony Lindgren
Cc: linux-omap@vger.kernel.org
Subject: RE: Issues with GPIO and wake from sleep

I have tried all sorts of configurations now and still cannot get the system to wake from GPIO.

The confusing thing is that if I use the power managements tests via debugfs I can make the system sleep and wakeup using the timer, so the suspend and wake is configured and working.

Using either method of configuring the GPIO to be an interrupt and wakeup source OR a GPIO key with wakeup capability results in the system just sitting there in the suspended state.
I know the GPIO and IRQ is working as I see the count increment in /proc/interrupts

I have tried debugging with JTAG but not having any luck because the core enters a power down state so therefore disconnects the JTAG and the debug session hangs.

I have also removed all devices going back to a very basic system thinking drivers are causing the suspend resume issue but still it stays in the sleep state.

All the references I can find online do not assist in getting a solution for me.

Is there anyone out there that has managed to successfully get the wake from suspend to memory working via a GPIO on a 3.x kernel ?

i am getting close to running out of options to make this system work.

Help appreciated and may help others out there with a similar issue.

Kind Regards
Marc

________________________________________
From: Tony Lindgren [tony@atomide.com]
Sent: 17 January 2014 17:39
To: Marc Murphy
Cc: linux-omap@vger.kernel.org
Subject: Re: Issues with GPIO and wake from sleep

* Marc Murphy <marcmltd@marcm.co.uk> [140117 04:32]:
> I have resisted contacting the list with regards to an issue I am having trying to get what should be a simple part of my system working but I cannot find any documentation or other posts to help.
>
> I am using 3.6 kernel but have tried 3.12 to see if the issue has been addressed in that but its exactly the same.
>
> I am attempting to get a GPIO to wake my AM3517 system up from a 
> suspend to memory.  I have tried with a few different options for GPIO's I have available GPIO-10, GPIO-28 and GPIO-30.
>
> I started by using GPIO-28 and that would configure nicely and I set 
> up the interrupt handler and could see my debug when triggering the 
> input (brilliant) but for some reason I cannot use it  to wake the 
> system as it is not in the correct group for wakeup.  There is a note 
> in the Tech Ref Man -
>
> Only gpio_1, gpio_9, gpio_10, gpio_11, gpio_30, and gpio_31 can be used to generate a direct wake-up event.
>
> So have to use a different one. GPIO-30 cannot be used as that holds the system in reset, so all that is left is GPIO-10.
> All seems to be good for initialisation;

I think you don't need the mux wake-up bits for the first GPIO bank, it's always powered. So just setting gpio10 as an interrupt should keep it working through suspend. The GPIO driver has it's own idle handling for the first bank, see _set_gpio_wakeup().

Maybe you just need to do set_irq_wake() in the interrupt number for gpio10?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
