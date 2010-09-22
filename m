From: David Anders <x0132446@ti.com>
Subject: Re: [PATCH 3/4] omap4: pandaboard: Adding card detect support for
 MMC1
Date: Wed, 22 Sep 2010 09:40:08 -0500
Message-ID: <4C9A1548.7070609@ti.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com> <1285104244-32274-4-git-send-email-x0132446@ti.com> <AANLkTi=Us2g=+E50MRPXHuOnNYa2aV3tmxZj3sGS-kQ8@mail.gmail.com> <AANLkTi==h+sBQ08R2=XhjSNXjA5n6yFQWut=djrc2txo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55934 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab0IVOkL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 10:40:11 -0400
In-Reply-To: <AANLkTi==h+sBQ08R2=XhjSNXjA5n6yFQWut=djrc2txo@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, "Goluguri, Jayabharath" <jayabharath@ti.com>, "Pasam, Vijay" <vpasam@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 09/22/2010 03:43 AM, Gadiyar, Anand wrote:
> On Wed, Sep 22, 2010 at 12:58 PM, Bryan Wu<bryan.wu@canonical.com>  wrote:
>    
>> On Wed, Sep 22, 2010 at 5:24 AM, David Anders<x0132446@ti.com>  wrote:
>>      
>>> Adding card detect callback function and card detect configuration
>>> function for MMC1 Controller.
>>>
>>> Signed-off-by: David Anders<x0132446@ti.com>
>>> Signed-off-by: Anand Gadiyar<gadiyar@ti.com>
>>> ---
>>>
>>> patch depends on https://patchwork.kernel.org/patch/189952/
>>>
>>>   arch/arm/mach-omap2/board-omap4panda.c |    7 ++++++-
>>>   1 files changed, 6 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
>>> index 697c0bd..94e819c 100644
>>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>>> @@ -77,9 +77,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>>>         struct omap_mmc_platform_data *pdata = dev->platform_data;
>>>
>>>         /* Setting MMC1 Card detect Irq */
>>> -       if (pdev->id == 0)
>>> +       if (pdev->id == 0) {
>>> +               ret = twl6030_mmc_card_detect_config();
>>>        
>> It looks like we need this function from twl6030 driver, otherwise we
>> will get this compiling error:
>>
>> ----
>> In file included from arch/arm/mach-omap2/board-omap4panda.c:38:
>> arch/arm/plat-omap/include/plat/usb.h:109: warning: return type
>> defaults to 'int'
>> arch/arm/mach-omap2/board-omap4panda.c: In function
>> 'omap4_twl6030_hsmmc_late_init':
>> arch/arm/mach-omap2/board-omap4panda.c:81: error: implicit declaration
>> of function 'twl6030_mmc_card_detect_config'
>> arch/arm/mach-omap2/board-omap4panda.c:86: error:
>> 'twl6030_mmc_card_detect' undeclared (first use in this function)
>> arch/arm/mach-omap2/board-omap4panda.c:86: error: (Each undeclared
>> identifier is reported only once
>> arch/arm/mach-omap2/board-omap4panda.c:86: error: for each function it
>> appears in.)
>> arch/arm/mach-omap2/board-omap4panda.c: In function 'omap4_panda_init':
>> arch/arm/mach-omap2/board-omap4panda.c:285: warning: unused variable 'status'
>> ----
>>
>> Thanks,
>> -Bryan
>>      
> I thought the dependent patch [1] took care of this in the header file?
> (Haven't actually tried this out - will take a look in a bit)
>
> [1] https://patchwork.kernel.org/patch/189952/
>    

correct! this patch depends on the reference patch being applied.

>    
>>
>>      
>>> +               if (ret)
>>> +                       pr_err("Failed configuring MMC1 card detect\n");
>>>                 pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
>>>                                                 MMCDETECT_INTR_OFFSET;
>>> +               pdata->slots[0].card_detect = twl6030_mmc_card_detect;
>>> +       }
>>>         return ret;
>>>   }
>>>
>>>        
> \
>    

