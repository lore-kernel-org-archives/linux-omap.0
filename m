From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 2/5] gpio/omap: Use devm_ API and add request_mem_region
Date: Thu, 16 Feb 2012 12:07:14 +0530
Message-ID: <4F3CA41A.4020800@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>	<1329321854-24490-3-git-send-email-b-cousson@ti.com> <CAC83ZvKuOkLKdAVNeoVjRZriouDCGPXPhkZZ+MgcktH+9pYN3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:53218 "HELO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756778Ab2BPGhV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 01:37:21 -0500
Received: by mail-tul01m020-f181.google.com with SMTP id up10so2960764obb.40
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 22:37:20 -0800 (PST)
In-Reply-To: <CAC83ZvKuOkLKdAVNeoVjRZriouDCGPXPhkZZ+MgcktH+9pYN3w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org

On Thursday 16 February 2012 11:11 AM, DebBarma, Tarun Kanti wrote:
> Hi Benoit,
>
> On Wed, Feb 15, 2012 at 9:34 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Replace the regular kzalloc and ioremap with the devm_ equivalent
>> to simplify error handling.
>>
>> Add the missing devm_request_mem_region to reserve the region used
>> by the driver.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>>  drivers/gpio/gpio-omap.c |   35 +++++++++++++++--------------------
>>  1 files changed, 15 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index a0c3e03..c3a9dc8 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -19,7 +19,7 @@
>>  #include <linux/err.h>
>>  #include <linux/clk.h>
>>  #include <linux/io.h>
>> -#include <linux/slab.h>
>> +#include <linux/device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pm.h>
>>
>> @@ -1052,23 +1052,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>        struct gpio_bank *bank;
>>        int ret = 0;
>>
>> -       if (!dev->platform_data) {
>> -               ret = -EINVAL;
>> -               goto err_exit;
>> -       }
>> +       if (!dev->platform_data)
>> +               return -EINVAL;
>>
>> -       bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
>> +       bank = devm_kzalloc(&pdev->dev, sizeof(struct gpio_bank), GFP_KERNEL);
>>        if (!bank) {
>>                dev_err(dev, "Memory alloc failed\n");
>> -               ret = -ENOMEM;
>> -               goto err_exit;
>> +               return -ENOMEM;
>>        }
>>
>>        res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>        if (unlikely(!res)) {
>>                dev_err(dev, "Invalid IRQ resource\n");
>> -               ret = -ENODEV;
>> -               goto err_free;
>> +               return -ENODEV;
> How is the memory allocated to 'bank' getting freed before return -ENODEV?

I think that may not be needed

See http://www.kernel.org/doc/htmldocs/device-drivers/API-devm-kzalloc.html



>>        }
>>
>>        bank->irq = res->start;
>> @@ -1096,15 +1092,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>        if (unlikely(!res)) {
>>                dev_err(dev, "Invalid mem resource\n");
>> -               ret = -ENODEV;
>> -               goto err_free;
>> +               return -ENODEV;
> And here?
>
>> +       }
>> +
>> +       if (!devm_request_mem_region(dev, res->start, resource_size(res),
>> +                                    pdev->name)) {
>> +               dev_err(dev, "Region already claimed\n");
>> +               return -EBUSY;
>>        }
>>
>> -       bank->base = ioremap(res->start, resource_size(res));
>> +       bank->base = devm_ioremap(dev, res->start, resource_size(res));
>>        if (!bank->base) {
>>                dev_err(dev, "Could not ioremap\n");
>> -               ret = -ENOMEM;
>> -               goto err_free;
>> +               return -ENOMEM;
> And here?
> --
> Tarun
>>        }
>>
>>        platform_set_drvdata(pdev, bank);
>> @@ -1125,11 +1125,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>        list_add_tail(&bank->node, &omap_gpio_list);
>>
>>        return ret;
>> -
>> -err_free:
>> -       kfree(bank);
>> -err_exit:
>> -       return ret;
>>  }
>>
>>  #ifdef CONFIG_ARCH_OMAP2PLUS
>> --
>> 1.7.0.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

