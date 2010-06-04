From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 3/7] omap3: pm: re-programing the setup time based on CORE_DOMAIN target state
Date: Fri, 04 Jun 2010 08:23:13 -0700
Message-ID: <87r5kmq0ta.fsf@deeprootsystems.com>
References: <1274186129-23928-1-git-send-email-leslyam@ti.com>
	<8739x4vwrn.fsf@deeprootsystems.com>
	<007501cb03ba$5bbd3cc0$e08818ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37479 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab0FDPXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 11:23:17 -0400
Received: by pvg16 with SMTP id 16so620489pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Jun 2010 08:23:17 -0700 (PDT)
In-Reply-To: <007501cb03ba$5bbd3cc0$e08818ac@apr.dhcp.ti.com> (Lesly Arackal Manuel's message of "Fri\, 4 Jun 2010 13\:18\:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly Arackal Manuel <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

"Lesly Arackal Manuel" <leslyam@ti.com> writes:

>> > @@ -510,18 +502,6 @@ void omap_sram_idle(void)
>> >  		}
>> >  		omap_uart_resume_idle(0);
>> >  		omap_uart_resume_idle(1);
>> > -		if (core_next_state == PWRDM_POWER_OFF) {
>> > -			u32 voltctrl = OMAP3430_AUTO_OFF;
>> > -
>> > -			if (voltage_off_while_idle)
>> > -				voltctrl |= OMAP3430_SEL_OFF;
>> > -			prm_clear_mod_reg_bits(voltctrl,
>> > -					       OMAP3430_GR_MOD,
>> > -					       OMAP3_PRM_VOLTCTRL_OFFSET);
>> > -		} else if (core_next_state == PWRDM_POWER_RET)
>> > -			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
>> > -						OMAP3430_GR_MOD,
>> > -						OMAP3_PRM_VOLTCTRL_OFFSET);
>> 
>> ...in the resume path, this entire part is removed, but with
>> replacement call into the voltage layer.  This needs to be well
>> documented in the changelog as to why this is not needed.
>
> The comment for removing this part is already there in the changelog:
> ****
>> > Also removed the clearing of PRM_VOLTCTRL register bits, because this
>> will be
>> > used only when it goes to low power mode next time.
> ****
>
> OK, I will add more detail in next ver.

Yes please, that description is not clear.

Thanks,

Kevin
