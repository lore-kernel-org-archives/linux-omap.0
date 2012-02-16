From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/5] gpio/omap: Use devm_ API and add request_mem_region
Date: Thu, 16 Feb 2012 09:56:13 +0100
Message-ID: <4F3CC4AD.3000103@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>	<1329321854-24490-3-git-send-email-b-cousson@ti.com> <CAC83ZvKuOkLKdAVNeoVjRZriouDCGPXPhkZZ+MgcktH+9pYN3w@mail.gmail.com> <4F3CA41A.4020800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48726 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755642Ab2BPI43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 03:56:29 -0500
In-Reply-To: <4F3CA41A.4020800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org

On 2/16/2012 7:37 AM, Shubhrajyoti wrote:
> On Thursday 16 February 2012 11:11 AM, DebBarma, Tarun Kanti wrote:
>> Hi Benoit,
>>
>> On Wed, Feb 15, 2012 at 9:34 PM, Benoit Cousson<b-cousson@ti.com>  wrote:
>>> Replace the regular kzalloc and ioremap with the devm_ equivalent
>>> to simplify error handling.
>>>
>>> Add the missing devm_request_mem_region to reserve the region used
>>> by the driver.
>>>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>>> ---
>>>   drivers/gpio/gpio-omap.c |   35 +++++++++++++++--------------------
>>>   1 files changed, 15 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index a0c3e03..c3a9dc8 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -19,7 +19,7 @@
>>>   #include<linux/err.h>
>>>   #include<linux/clk.h>
>>>   #include<linux/io.h>
>>> -#include<linux/slab.h>
>>> +#include<linux/device.h>
>>>   #include<linux/pm_runtime.h>
>>>   #include<linux/pm.h>
>>>
>>> @@ -1052,23 +1052,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>>         struct gpio_bank *bank;
>>>         int ret = 0;
>>>
>>> -       if (!dev->platform_data) {
>>> -               ret = -EINVAL;
>>> -               goto err_exit;
>>> -       }
>>> +       if (!dev->platform_data)
>>> +               return -EINVAL;
>>>
>>> -       bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
>>> +       bank = devm_kzalloc(&pdev->dev, sizeof(struct gpio_bank), GFP_KERNEL);
>>>         if (!bank) {
>>>                 dev_err(dev, "Memory alloc failed\n");
>>> -               ret = -ENOMEM;
>>> -               goto err_exit;
>>> +               return -ENOMEM;
>>>         }
>>>
>>>         res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>>         if (unlikely(!res)) {
>>>                 dev_err(dev, "Invalid IRQ resource\n");
>>> -               ret = -ENODEV;
>>> -               goto err_free;
>>> +               return -ENODEV;
>> How is the memory allocated to 'bank' getting freed before return -ENODEV?
>
> I think that may not be needed

It is indeed not needed, and this is the whole point of that API 
compared to the regular kzalloc... and that's why it is highly 
recommended to switch to this kind of API.

Regards,
Benoit
