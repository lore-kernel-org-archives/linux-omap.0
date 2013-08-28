From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2 01/13] ARM: OMAP2+: CM: reintroduce SW_SLEEP for OMAP4
Date: Wed, 28 Aug 2013 17:44:15 +0530
Message-ID: <521DE997.1050106@ti.com>
References: <cover.1375443858.git.afzal@ti.com> <cfcae1c52efc51786878c60b75cc3c182bcd50a5.1375443858.git.afzal@ti.com> <5214688C.9030801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58524 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936Ab3H1MOp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Aug 2013 08:14:45 -0400
In-Reply-To: <5214688C.9030801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, benoit.cousson@gmail.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Hi Rajendra,

On Wednesday 21 August 2013 12:43 PM, Rajendra Nayak wrote:

>> +void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs)
>> +{
>> +	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
> 
> I guess this won't work on omap4/5 where some clockdomains do not support
> SW_SLEEP and only support HW_AUTO. We might need to have different clkdm
> operations for the different omap4 variants.

Yes, this has to be reworked using clockdomain flag to handle
appropriately the above scenario.

Regards
Afzal

>>  static int omap4_clkdm_sleep(struct clockdomain *clkdm)
>>  {
>> -	omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
>> -					clkdm->cm_inst, clkdm->clkdm_offs);
>> +	omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
>> +				       clkdm->cm_inst, clkdm->clkdm_offs);
>>  	return 0;
>>  }
>>  
>>
> 

