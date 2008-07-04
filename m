From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 3/3] CPU-idle trial fix + PM debug expansion
Date: Fri, 04 Jul 2008 12:03:13 +0300
Message-ID: <87tzf6komm.fsf@trdhcp146196.ntc.nokia.com>
References: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
	<1215100756-31445-2-git-send-email-tero.kristo@nokia.com>
	<1215100756-31445-3-git-send-email-tero.kristo@nokia.com>
	<1215100756-31445-4-git-send-email-tero.kristo@nokia.com>
	<87od5em72m.fsf@trdhcp146196.ntc.nokia.com>
	<B71CE868F2BC2847B3F23C5A8EE394303C389F@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25444 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYGDJEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 05:04:08 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6492ulh004161
	for <linux-omap@vger.kernel.org>; Fri, 4 Jul 2008 04:04:06 -0500
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE394303C389F@vaebe110.NOE.Nokia.com>
	(Kristo Tero's message of "Fri, 4 Jul 2008 11:53:27 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

"Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com> writes:

> Hi,
>
> Quick counter comments here. :P=20
>
>>This will leave cx->core_state to its previous value in case=20
>>of ON state. So just pwrdm_set_next_pwrst(core_pd,=20
>>cx->core_state) without if is better.
>
> I did not really consider the logic of cpu-idle code too much, just m=
oved context / save functionality to omap_sram_idle. I just made suspen=
d + dynamic idle work.
>
>>> +	save_core =3D (pwrdm_read_next_pwrst(core_pwrdm) =3D=3D=20
>>PWRDM_POWER_OFF);
>>> +	save_per =3D (pwrdm_read_next_pwrst(per_pwrdm) =3D=3D
>>> PWRDM_POWER_OFF);
>>
>>Just read next states here.
>
> I am comparing the values to PWRDM_POWER_OFF, because you will only
> need to save context if you enter OFF state.

Yes, but then you might need to read them again:

core_not_on =3D (pwrdm_read_next_pwrst(core_pwrdm) =3D=3D  PWRDM_POWER_=
OFF);
per_not_on =3D (pwrdm_read_next_pwrst(core_pwrdm) =3D=3D  PWRDM_POWER_O=
=46F);

>
>>
>>> +
>>> +	if (save_core) {
>>> +		omap3_save_core_ctx();
>>> +		omap3_save_prcm_ctx();
>>> +	}
>>
>>And do this if core next_st < PWRDM_POWER_ON
>
> Save is not needed if you enter PWRDM_POWER_RET.

Yes I meant whole block:

if (core_not_on) {
   /* Some more code here */
   if (save_core) {
      omap3_save_core_ctx();
      omap3_save_prcm_ctx();
   }
}

>
>>
>>> +
>>> +	if (save_per)
>>> +		omap3_save_per_ctx();
>>
>>And same here. Additionally, do this only if core next_st <=20
>>PWRDM_POWER_ON.
>
> Per domain can in theory go to OFF even if core stays on (yes, there
> is some discussion about tying Core + Per because of the gpio
> dependencies, but we might find something else for this.)=20

No per can't enter sleep if core is not entering sleep. Please read
discussion in cpuidle patch thread.

>
>>
>>> =20
>>> -	omap3_save_per_ctx();
>>>  	omap2_gpio_prepare_for_retention();
>>> =20
>>>  	/* XXX This is for gpio fclk hack. Will be removed as=20
>>gpio driver
>>>  	 * handqles fcks correctly */
>>>  	per_gpio_clk_disable();
>>> =20
>>> -	omap_save_uart_ctx();
>>> +	if (save_per)
>>> +		omap_save_uart_ctx();
>>
>>Again, do this only if core next_st < PWRDM_POWER_ON and per=20
>>next_st =3D=3D PWRDM_POWER_OFF.
>
> Same here.
>
>>
>>> +
>>>  	omap_serial_enable_clocks(0);
>>
>>Consider Rajendras idea to do this only if needed.
>
> I think the idea was to access uart clocks only if we can assume
> that per_pwrdm will enter ret / off? Yes good idea.

Yes, simpler option is to do this only if core or per is going to
sleep.

>
>>>  	/* XXX This is for gpio fclk hack. Will be removed as=20
>>gpio driver
>>>  	 * handles fcks correctly */
>>> =20
>>>  	per_gpio_clk_enable();
>>> -	omap3_restore_per_ctx();
>>> +
>>> +	if (save_per)
>>> +		omap3_restore_per_ctx();
>>> =20
>>>  	omap2_gpio_resume_after_retention();
>>
>>Same comments to restore part as before wfi. I think you=20
>>should look at what Rajendra has done (logic in=20
>>omap3_enter_idle). You might also want to look at previous=20
>>discussion related to this. Something like this:
>
> I have looked at this code, and I somehow consider it a bit too
> complicated for the purpose. The simpler setup I have implemented in
> omap_sram_idle is working, also all powerdomains have their next
> states set-up correctly when you reach omap_sram_idle. Anyway, it is
> easy to expand the code now that it actually works.

ok.

>
>>neon_pwrdm\n");
>>> +	if (mpu_pwrdm =3D=3D NULL || neon_pwrdm =3D=3D NULL ||=20
>>per_pwrdm =3D=3D NULL ||
>>> +			core_pwrdm =3D=3D NULL) {
>>> +		printk(KERN_ERR "Failed to get pwrdm pointers\n");
>>
>>Neon handling is missing.
>
> Neon pwrdm is accessed only in the init code to make wakeup
> dependency from mpu -> neon. I have not tried out neon save /
> restore so far (just some vfp hack is needed.)

ok

>
> -Tero
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
