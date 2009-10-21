From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 17/17] OMAP3: PM: Force disable OTG autoidle
Date: Wed, 21 Oct 2009 12:21:57 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A210F6A58292@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-14-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-15-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-16-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-17-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-18-git-send-email-tero.kristo@nokia.com>
 <87eioxsy5w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51428 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZJUKWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 06:22:17 -0400
In-Reply-To: <87eioxsy5w.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 20 October, 2009 21:44
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 17/17] OMAP3: PM: Force disable OTG autoidle
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> OMAP3 sleep can be prevented in some cases where OTG 
>autoidle is enabled.
>> This patch force disables autoidle during boot and after 
>wakeup from off-mode.
>> See omap erratas 1.164 and 1.165.
>
>The init-at-boot step isn't needed as this is already done in 
>PM branch (see usb-muxb.c:usb_musb_pm_init()).

True, that reset part actually does this, which is also part of the errata.

>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index ae83121..5f351f2 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -94,6 +94,8 @@ u32 voltage_off_while_idle;
>>  		OMAP3430_ST_GPT5_MASK|OMAP3430_ST_GPT4_MASK|\
>>  		OMAP3430_ST_GPT3_MASK|OMAP3430_ST_GPT2_MASK)
>>  
>> +#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
>> +
>>  struct power_state {
>>  	struct powerdomain *pwrdm;
>>  	u32 next_state;
>> @@ -423,6 +425,16 @@ static void restore_table_entry(void)
>>  	restore_control_register(control_reg_value);
>>  }
>>  
>> +static inline void disable_otg_autoidle(void)
>> +{
>> +	/*
>> +	 * OTG autoidle can prevent core domain sleep in some 
>cases, thus
>> +	 * disable it. See omap erratas 1.164 and 1.165.
>> +	 */
>> +	cm_set_mod_reg_bits(OMAP3430_EN_HSOTGUSB, CORE_MOD, CM_ICLKEN1);
>
>Is the ICLK enable required as part of the fix too?  I don't see
>mention of enabling the iclk as part of the workaround for either of
>these errata.
>
>If the iclk needs to be enabled, it should be done at init using
>the clk API.

ICLK enable part is here because we will crash unless ICLK is active. It does not really need to be on, but it was rather simpler to do it this way. I can try to look if adding this into USB code would make sense.

>
>> +	omap_writel(0x0, OTG_SYSCONFIG);
>
>omap_writel() deprecated.  

Again...

>
>> +}
>> +
>
>For readability, this should be a function in the USB core code
>(either usb-musb.c or a static inline in <mach/usb.h>)
>
>Kevin
>
>>  void omap_sram_idle(void)
>>  {
>>  	/* Variable to tell what needs to be saved and restored
>> @@ -628,6 +640,7 @@ void omap_sram_idle(void)
>>  			omap3_prcm_restore_context();
>>  			omap3_sram_restore_context();
>>  			omap2_sms_restore_context();
>> +			disable_otg_autoidle();
>>  		}
>>  		omap_uart_resume_idle(0);
>>  		omap_uart_resume_idle(1);
>> @@ -1417,6 +1430,7 @@ static int __init omap3_pm_early_init(void)
>>  				OMAP3_PRM_POLCTRL_OFFSET);
>>  
>>  	configure_vc();
>> +	disable_otg_autoidle();
>>  
>>  	return 0;
>>  }
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>