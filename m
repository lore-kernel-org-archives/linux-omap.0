From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 3/3] CPU-idle trial fix + PM debug expansion
Date: Fri, 4 Jul 2008 11:53:27 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394303C389F@vaebe110.NOE.Nokia.com>
References: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com><1215100756-31445-2-git-send-email-tero.kristo@nokia.com><1215100756-31445-3-git-send-email-tero.kristo@nokia.com><1215100756-31445-4-git-send-email-tero.kristo@nokia.com> <87od5em72m.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58517 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYGDIy1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 04:54:27 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m648s03O013624
	for <linux-omap@vger.kernel.org>; Fri, 4 Jul 2008 11:54:24 +0300
Content-class: urn:content-classes:message
In-Reply-To: <87od5em72m.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jouni.hogander@nokia.com
Cc: linux-omap@vger.kernel.org

Hi,

Quick counter comments here. :P 

>This will leave cx->core_state to its previous value in case 
>of ON state. So just pwrdm_set_next_pwrst(core_pd, 
>cx->core_state) without if is better.

I did not really consider the logic of cpu-idle code too much, just moved context / save functionality to omap_sram_idle. I just made suspend + dynamic idle work.

>> +	save_core = (pwrdm_read_next_pwrst(core_pwrdm) == 
>PWRDM_POWER_OFF);
>> +	save_per = (pwrdm_read_next_pwrst(per_pwrdm) ==
>> PWRDM_POWER_OFF);
>
>Just read next states here.

I am comparing the values to PWRDM_POWER_OFF, because you will only need to save context if you enter OFF state.

>
>> +
>> +	if (save_core) {
>> +		omap3_save_core_ctx();
>> +		omap3_save_prcm_ctx();
>> +	}
>
>And do this if core next_st < PWRDM_POWER_ON

Save is not needed if you enter PWRDM_POWER_RET.

>
>> +
>> +	if (save_per)
>> +		omap3_save_per_ctx();
>
>And same here. Additionally, do this only if core next_st < 
>PWRDM_POWER_ON.

Per domain can in theory go to OFF even if core stays on (yes, there is some discussion about tying Core + Per because of the gpio dependencies, but we might find something else for this.) 

>
>>  
>> -	omap3_save_per_ctx();
>>  	omap2_gpio_prepare_for_retention();
>>  
>>  	/* XXX This is for gpio fclk hack. Will be removed as 
>gpio driver
>>  	 * handqles fcks correctly */
>>  	per_gpio_clk_disable();
>>  
>> -	omap_save_uart_ctx();
>> +	if (save_per)
>> +		omap_save_uart_ctx();
>
>Again, do this only if core next_st < PWRDM_POWER_ON and per 
>next_st == PWRDM_POWER_OFF.

Same here.

>
>> +
>>  	omap_serial_enable_clocks(0);
>
>Consider Rajendras idea to do this only if needed.

I think the idea was to access uart clocks only if we can assume that per_pwrdm will enter ret / off? Yes good idea.

>>  	/* XXX This is for gpio fclk hack. Will be removed as 
>gpio driver
>>  	 * handles fcks correctly */
>>  
>>  	per_gpio_clk_enable();
>> -	omap3_restore_per_ctx();
>> +
>> +	if (save_per)
>> +		omap3_restore_per_ctx();
>>  
>>  	omap2_gpio_resume_after_retention();
>
>Same comments to restore part as before wfi. I think you 
>should look at what Rajendra has done (logic in 
>omap3_enter_idle). You might also want to look at previous 
>discussion related to this. Something like this:

I have looked at this code, and I somehow consider it a bit too complicated for the purpose. The simpler setup I have implemented in omap_sram_idle is working, also all powerdomains have their next states set-up correctly when you reach omap_sram_idle. Anyway, it is easy to expand the code now that it actually works.

>neon_pwrdm\n");
>> +	if (mpu_pwrdm == NULL || neon_pwrdm == NULL || 
>per_pwrdm == NULL ||
>> +			core_pwrdm == NULL) {
>> +		printk(KERN_ERR "Failed to get pwrdm pointers\n");
>
>Neon handling is missing.

Neon pwrdm is accessed only in the init code to make wakeup dependency from mpu -> neon. I have not tried out neon save / restore so far (just some vfp hack is needed.)

-Tero
