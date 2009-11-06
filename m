From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 2/3] PM: Skip PER previous state register read
Date: Fri, 6 Nov 2009 08:52:57 +0100
Message-ID: <E839BB5467CE1640B3CC2F90F647A52C2749D7A346@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com>
 <87k4ycrggl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24571 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbZKFHxC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 02:53:02 -0500
In-Reply-To: <87k4ycrggl.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, kalle.jokiniemi@digia.com
Cc: linux-omap@vger.kernel.org, Peter.De-Schrijver@nokia.com

Hi Kevin, 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kevin Hilman
>Sent: 30. lokakuuta 2009 18:32
>To: Kalle Jokiniemi
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 2/3] PM: Skip PER previous state register read
>
>Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:
>
>> According to measurements, reading the previous state of PER domain 
>> after wfi takes ~11us on OPP2.
>>
>> Removed this unneccessary latency from cases where we know PER power 
>> domain did not try to enter off mode.
>>
>> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
>
>Looks good, pulling into PM branch.
>
>But still amazed at such a *huge* latency to read that register.

We talked about this with Peter, and he suggested the reason might
be that the register is in WKUP domain, which runs on slow clock.
Checking from TRM, it is mentioned that at least in low-power mode,
the 32k clock is used in PRM. Could not figure out what is used in
normal mode, though. 

Probably the same reason makes the debug counter updates so slow.

- Kalle


>
>Kevin
>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   19 +++++++++++++------
>>  1 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>> b/arch/arm/mach-omap2/pm34xx.c index 237c819..b70ea19 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -489,12 +489,19 @@ void omap_sram_idle(void)
>>  
>>  	/* PER */
>>  	if (per_next_state < PWRDM_POWER_ON) {
>> -		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
>> -		if (per_prev_state == PWRDM_POWER_OFF) {
>> -			omap3_per_restore_context();
>> -			omap3_gpio_restore_pad_context(0);
>> -		} else if (per_next_state == PWRDM_POWER_OFF)
>> -			omap3_gpio_restore_pad_context(1);
>> +		if (per_next_state == PWRDM_POWER_OFF) {
>> +			/*
>> +			 * Reading the prev-state takes long 
>time (11us@OPP2),
>> +			 * only do it, if we really tried to 
>put PER in OFF
>> +			 */
>> +			per_prev_state = 
>pwrdm_read_prev_pwrst(per_pwrdm);
>> +			if (per_prev_state == PWRDM_POWER_OFF) {
>> +				omap3_per_restore_context();
>> +				omap3_gpio_restore_pad_context(0);
>> +			} else if (per_next_state == PWRDM_POWER_OFF) {
>> +				omap3_gpio_restore_pad_context(1);
>> +			}
>> +		}
>>  		omap2_gpio_resume_after_idle();
>>  		omap_uart_resume_idle(2);
>>  		if (per_state_modified)
>> --
>> 1.5.4.3
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in the body of a message to 
>majordomo@vger.kernel.org More majordomo info at  
>http://vger.kernel.org/majordomo-info.html
>