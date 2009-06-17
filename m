From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF,
	reduces OFF latency by 20ms
Date: Wed, 17 Jun 2009 15:20:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305A54100@dbde02.ent.ti.com>
References: <1245224794.6847.141.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43296 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbZFQJvE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 05:51:04 -0400
In-Reply-To: <1245224794.6847.141.camel@ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>


>-----Original Message-----
>From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com] 
>Sent: Wednesday, June 17, 2009 1:17 PM
>To: Nayak, Rajendra
>Cc: linux-omap@vger.kernel.org; Derrick, David; Woodruff, Richard
>Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle 
>before OFF, reduces OFF latency by 20ms
>
>Hi Rajendra,
>
>On Tue, 2009-06-16 at 14:52 +0300, Rajendra Nayak wrote:
>> If autoidle for DPLL4 is enabled in the stored scratchpad
>> value of CM_AUTOIDLE_PLL then there is an added delay by
>> the boot ROM when coming out of OFF mode.
>> The patch disables this bitfield in the stored scratchpad value.
>> 
>> This should significantly reduce CORE OFF latency and also
>> bring down the threshold for CORE OFF, making OFF affordable
>> even with smaller sleep times.
>
>I did some measurements on RX-51 with this patch, and it seems it does
>not reduce latency, it increases it by few hundred us.
>
>Servicing an empty timer interrupt from off mode (measured from VDD1
>ramp up to start of VDD1 ramp down):
>
>with dpll4 patch : ~14100us
>without patch    : ~13600us
>
>I attached pictures of both situations.
>
>My kernel had only C7 state enabled.
>
>Have you measured the latency effects on SDP or some other board?

I haven't done the latency measurements on SDP yet, but David had done it
sometime back, using a different codebase though.

Can you explain more on how you are measuring the latency here, I am a bit
confused. This is supposed to bring down the OFF wakeup latency, the sleep latency
remains the same.

>
>- Kalle
>
>
>> This patch however does not optimize the C state threshold for
>> CORE OFF states based on the new latency.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/mach-omap2/control.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/control.c 
>b/arch/arm/mach-omap2/control.c
>> index c9407c0..a7159a9 100644
>> --- a/arch/arm/mach-omap2/control.c
>> +++ b/arch/arm/mach-omap2/control.c
>> @@ -238,6 +238,13 @@ void omap3_save_scratchpad_contents(void)
>>  			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
>>  	prcm_block_contents.cm_autoidle_pll =
>>  			cm_read_mod_reg(PLL_MOD, 
>OMAP3430_CM_AUTOIDLE_PLL);
>> +	/*
>> +	 * ROM restore takes 20mS longer if PER idle is enabled 
>before OFF.
>> +	 * Clear feature before sleep. The origional idle state is
>> +	 * restored by software as part of wake procedure.
>> +	 */
>> +	prcm_block_contents.cm_autoidle_pll &= 
>~OMAP3430_AUTO_PERIPH_DPLL_MASK;
>> +
>>  	prcm_block_contents.cm_clksel1_pll =
>>  			cm_read_mod_reg(PLL_MOD, 
>OMAP3430_CM_CLKSEL1_PLL);
>>  	prcm_block_contents.cm_clksel2_pll =
>