From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 1/1] Added sleep support to UART
Date: Tue, 10 Jun 2008 17:07:39 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE3943020D3AA@vaebe110.NOE.Nokia.com>
References: <1212490022-5866-1-git-send-email-tero.kristo@nokia.com> <20080610051104.GD23796@atomide.com> <20080610060624.GE23796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21636 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbYFJOJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 10:09:11 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080610060624.GE23796@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi,

I'll resend the patch in the following email. Comments below what has
been changed.

>-----Original Message-----
>From: ext Tony Lindgren [mailto:tony@atomide.com] 
>Sent: 10 June, 2008 09:06
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 1/1] Added sleep support to UART
>
>* Tony Lindgren <tony@atomide.com> [080609 22:11]:
>> Hi,
>> 
>> Sorry for the delay on looking at this, it's looking pretty good in 
>> general. Few more mostly cosmetic comments below.
>
>Here's one more comment:
>
>> > --- a/arch/arm/mach-omap2/pm24xx.c
>> > +++ b/arch/arm/mach-omap2/pm24xx.c
>> >  	if (omap2_pm_debug) {
>> >  		unsigned long long tmp;
>> > -		u32 resume_time;
>> > +		s64 resume_time;
>> > +		struct timespec t;
>> >  
>> > -		resume_time = omap2_read_32k_sync_counter();
>> > +		getnstimeofday(&t);
>> > +		resume_time = timespec_to_ns(&t);
>> >  		tmp = resume_time - sleep_time;
>> > -		tmp *= 1000000;
>> > -		omap2_pm_dump(0, 1, tmp / 32768);
>> > +		omap2_pm_dump(0, 1, tmp / 1000);
>> >  	}
>
>You should make all these calculations using timespec_sub():
>
>struct timespec ts1, ts2, ts_delta;
>getnstimeofday(&ts1);
>getnstimeofday(&ts2);
>ts_delta = timespec_sub(&ts2, &ts1);

Fixed this in several places now to use timespec_sub, timespec_add and
timespec_compare.

<copy-paste from another email>
>> +#if defined(CONFIG_ARCH_OMAP2)
>> +static const u32 omap_uart_fclk_mask[OMAP_MAX_NR_PORTS] = {
>> +	OMAP24XX_EN_UART1, OMAP24XX_EN_UART2, OMAP24XX_EN_UART3 };
#endif
>> +
>> +#if defined(CONFIG_ARCH_OMAP3)
>> +static const u32 omap_uart_fclk_mask[OMAP_MAX_NR_PORTS] = {
>> +	OMAP3430_EN_UART1, OMAP3430_EN_UART2, OMAP3430_EN_UART3 };
>
>The above should be omap24xx_uart_fclk_mask and
omap34xx_uart_fclk_mask.
>Otherwise we cannot compile in both 24xx and 34xx into the same kernel.

Changed. Added omap_uart_fclk_mask to point to these structures though,
initialized at boot time. Also removed those #ifdef:s from the code.

>> +/* UART padconfig registers, these may differ if non-default
padconfig
>> +   is used */
>> +#define CONTROL_PADCONF_UART1_RX 0x48002182 #define 
>> +CONTROL_PADCONF_UART2_RX 0x4800217A #define CONTROL_PADCONF_UART3_RX

>> +0x4800219E #define PADCONF_WAKEUP_ST 0x8000
>> +
>> +static const u32 omap_uart_padconf[OMAP_MAX_NR_PORTS] = {
>> +	CONTROL_PADCONF_UART1_RX, CONTROL_PADCONF_UART2_RX, 
>> +CONTROL_PADCONF_UART3_RX }; #endif
>
>This should be omap34xx_uart_padconf is only used for 34xx. Also, it's
currently not defined for 24xx and breaks build.

Changed.

>> +void omap_serial_check_wakeup(void)
>> +{
>> +	int i;
>> +
>> +	if (cpu_is_omap34xx())
>> +		for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
>> +			if (!uart_ick[i])
>> +				continue;
>> +			if (omap_readw(omap_uart_padconf[i]) &
PADCONF_WAKEUP_ST)
>> +				omap_serial_kick();
>> +				return;
>> +		}
>
>The formatting for return above looks one tab too much to the right?

This is actually a hidden bug, that return should be part of that if
statement. Luckily enough the code worked if you had only one UART
enabled in configs. Added braces around that stuff now.


>> +	if (cpu_is_omap24xx()) {
>> +		u32 l;
>> +
>> +		for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
>> +			if (!uart_ick[i])
>> +				continue;
>> +			l = prm_read_mod_reg(CORE_MOD,
omap2_uart_wk_st[i]);
>> +			if (l & omap2_uart_wk_bit[i])
>> +				omap_serial_kick();
>> +				return;
>> +		}
>> +	}
>> +}
>
>Here too.

Similar bug.


>> +
>> +		if (cpu_is_omap24xx())
>> +			prm_set_mod_reg_bits(omap2_uart_wk_bit[i],
CORE_MOD, 
>> +omap2_uart_wk_en[i]);
>>  	}
>
>How about run the patch through checkpatch.pl, this line looks too
long?

Ok, split the code lines that caused warnings now to be multiline
statements.

-Tero
