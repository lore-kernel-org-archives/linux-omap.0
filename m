From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt
 controller
Date: Wed, 21 Oct 2009 10:07:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A46D9B6@dbde02.ent.ti.com>
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
	<13B9B4C6EF24D648824FF11BE8967162039B2A021C@dlee02.ent.ti.com>
	<004f01ca4e88$be2a6a50$3d1018ac@am.dhcp.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162039B317F66@dlee02.ent.ti.com>
	<005001ca4e8b$ea107c10$3d1018ac@am.dhcp.ti.com>
	<1F18D6510CF0474A8C9500565A7E41A210F69EEFFB@NOK-EUMSG-02.mgdnok.nokia.com>
	<87oco2njfh.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A210F6A57C90@NOK-EUMSG-02.mgdnok.nokia.com>
 <87oco2m3fq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50657 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbZJUEha convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 00:37:30 -0400
In-Reply-To: <87oco2m3fq.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>
Cc: "Ghongdemath, Girish" <girishsg@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>

Treo,

>>@@ -505,6 +507,12 @@ void omap_sram_idle(void)
>>                prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>>                omap3_enable_io_chain();
>>        }
>>+       /*
>>+        * Disable INTC autoidle as it can cause interrupt controller
>>+        * to enter unknown state with right combination of sleep / wakeup
>>+        * transitions
>>+        */
>>+       omap_writel(0x0, OMAP34XX_IC_BASE + INTC_SYSCONFIG);
>>
>>        /*
>>        * On EMU/HS devices ROM code restores a SRDC value
>>@@ -561,6 +569,8 @@ void omap_sram_idle(void)
>>                                                OMAP3430_GR_MOD,
>>                                                OMAP3_PRM_VOLTCTRL_OFFSET);
>>        }
>>+       /* Re-enable interrupt controller autoidle */
>>+       omap_writel(OMAP3430_AUTOIDLE, OMAP34XX_IC_BASE + INTC_SYSCONFIG);

Autoidle is being enabled inside the  if (core_next_state < PWRDM_POWER_ON). This is a bug because it is disabled irrespective of core pwr domain state. So if Core domain is on , this code will end up not enabling INTC autoidle during resume.

Regards
Thara

>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Tuesday, October 20, 2009 10:02 PM
>>To: Tero.Kristo@nokia.com
>>Cc: Ghongdemath, Girish; Woodruff, Richard; linux-omap@vger.kernel.org; jouni.hogander@nokia.com
>>Subject: Re: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt controller
>>
>><Tero.Kristo@nokia.com> writes:
>>
>>[...]
>>
>>>>>
>>>>> Anyway, I guess the optimization would look something like this:
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c
>>>>b/arch/arm/mach-omap2/pm34xx.c
>>>>> index 210a806..7a98321 100644
>>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>>> @@ -93,6 +93,8 @@ u32 voltage_off_while_idle;
>>>>>                 OMAP3430_ST_GPT5_MASK|OMAP3430_ST_GPT4_MASK|\
>>>>>                 OMAP3430_ST_GPT3_MASK|OMAP3430_ST_GPT2_MASK)
>>>>>
>>>>> +#define INTC_SYSCONFIG                 0x10
>>>>> +
>>>>>  struct power_state {
>>>>>         struct powerdomain *pwrdm;
>>>>>         u32 next_state;
>>>>> @@ -505,6 +507,12 @@ void omap_sram_idle(void)
>>>>>                 prm_set_mod_reg_bits(OMAP3430_EN_IO,
>>>>WKUP_MOD, PM_WKEN);
>>>>>                 omap3_enable_io_chain();
>>>>>         }
>>>>> +       /*
>>>>> +        * Disable INTC autoidle as it can cause interrupt controller
>>>>> +        * to enter unknown state with right combination of
>>>>sleep / wakeup
>>>>> +        * transitions
>>>>> +        */
>>>>> +       omap_writel(0x0, OMAP34XX_IC_BASE + INTC_SYSCONFIG);
>>>>
>>>>Except omap_write* functions are deprecated.
>>>
>>> I see, will use __raw_writel here then.
>>>
>>>>
>>>>I'd rather see a call into the interrupt code.  Something like
>>>>omap_intc_prepare_idle()
>>>
>>> Can do these changes to add the interface yes. Though name would be omap3_intc_prepare_idle() /
>>...resume_idle() as this is only needed for OMAP3.
>>
>>OK.
>>
>>>>
>>>>Also, isn't this only needed if CORE != ON?
>>>
>>> I understood from the problem description that this is needed always when we are entering WFI,
>>because we might have L3/L4 sleep/run transitions there even if CORE is on.
>>>
>>
>>OK.
>>
>>Kevin
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html

