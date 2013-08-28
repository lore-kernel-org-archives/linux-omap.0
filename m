From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2 06/13] ARM: OMAP2+: PRCM: AM43x definitions
Date: Wed, 28 Aug 2013 17:33:46 +0530
Message-ID: <521DE722.1050700@ti.com>
References: <cover.1375443858.git.afzal@ti.com> <ec65e24f1637245257f55906e5533ca54b010418.1375443858.git.afzal@ti.com> <alpine.DEB.2.02.1308210313410.6426@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57877 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab3H1MEP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Aug 2013 08:04:15 -0400
In-Reply-To: <alpine.DEB.2.02.1308210313410.6426@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, benoit.cousson@gmail.com

Hi Paul,

On Wednesday 21 August 2013 08:50 AM, Paul Walmsley wrote:

>> +/* PRM instances */
>> +#define AM43XX_PRM_OCP_SOCKET_INST			0x0000
>> +#define AM43XX_PRM_MPU_INST				0x0300
>> +#define AM43XX_PRM_GFX_INST				0x0400
>> +#define AM43XX_PRM_RTC_INST				0x0500
>> +#define AM43XX_PRM_TAMPER_INST				0x0600
>> +#define AM43XX_PRM_CEFUSE_INST				0x0700
>> +#define AM43XX_PRM_PER_INST				0x0800
>> +#define AM43XX_PRM_WKUP_INST				0x2000
>> +#define AM43XX_PRM_DEVICE_INST				0x4000
>> +
> 
> ...
> 
>> +/* CM instances */
>> +#define AM43XX_CM_WKUP_INST				0x2800
>> +#define AM43XX_CM_DEVICE_INST				0x4100
>> +#define AM43XX_CM_DPLL_INST				0x4200
>> +#define AM43XX_CM_MPU_INST				0x8300
>> +#define AM43XX_CM_GFX_INST				0x8400
>> +#define AM43XX_CM_RTC_INST				0x8500
>> +#define AM43XX_CM_TAMPER_INST				0x8600
>> +#define AM43XX_CM_CEFUSE_INST				0x8700
>> +#define AM43XX_CM_PER_INST				0x8800
> 
> That's a pretty broad address range to span, in PRCM terms.  Seems pretty 
> unlikely that the whole area is really decoded to a single PRCM IP block?  
> Or is it actually decoded into smaller PRM and CM sub-blocks, similar to 
> OMAP4?
> 
> Just by looking at the offsets, it looks to me like you've got:
> 
> 1. one IP block at 0x0000-0x1fff? that covers system PRM
> 
> 2. one IP block at 0x2000-0x3fff? that covers WKUP PRM & CM
>   
> 3. one IP block at 0x4000-? that covers device & PLL PRM & CM
> 
> 4. one IP block at 0x8000-? that covers system CM

In AM43x, PRCM is a single entity as in AM335x, but with a mixed address
space for PRM & CM instances.

On AM335x, from the header files, it can be seen that PRM & CM base is
0x44e00000, here it is similar case except that the base for both is
0x44df0000 instead.

Also, script too generated the macros as in this change.

Regards
Afzal
