From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: prevent module from being unloaded while
 in use
Date: Mon, 6 Jul 2015 18:15:54 +0300
Message-ID: <559A9BAA.2010400@ti.com>
References: <1435245213-17858-1-git-send-email-grygorii.strashko@ti.com> <CAAVeFuK5j+s+Wj2kAHT7K9dj3RtK2aYZ50xDLb7S-73MJ7FTHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAVeFuK5j+s+Wj2kAHT7K9dj3RtK2aYZ50xDLb7S-73MJ7FTHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, tony@atomide.com, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 06/30/2015 04:52 PM, Alexandre Courbot wrote:
> On Fri, Jun 26, 2015 at 12:13 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> OMAP GPIO driver allowed to be built as loadable module, but it
>> doesn't set owner field in GPIO chip structure. As result,
>> module_get/put() API is not working and it's possible to unload
>> OMAP driver while in use:
>>
>>    omap_gpio 48051000.gpio: REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED
>>
>> Hence, add missing configuration.
> 
> Isn't this also fixed by your other patch "gpiolib: assign chip owner
> to dev->driver->owner if not set"?
> 
> Nevertheless,
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> For inclusion into -rc if the other patch is for the next cycle.

Yes. I've sent this one for -rc as it's 100% fix and was not sure about
destiny of patch "gpiolib: assign chip owner.." :)


> 
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Fixes: cac089f9026e ('gpio: omap: Allow building as a loadable module')
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> Hi Linus,
>>
>> Seems this one is for 4.2-rc.
>>
>>   drivers/gpio/gpio-omap.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index a0ad803..61a731f 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1187,6 +1187,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>>          bank->irq = res->start;
>>          bank->dev = dev;
>>          bank->chip.dev = dev;
>> +       bank->chip.owner = THIS_MODULE;
>>          bank->dbck_flag = pdata->dbck_flag;
>>          bank->stride = pdata->bank_stride;
>>          bank->width = pdata->bank_width;
>> --
>> 2.4.4
>>


-- 
regards,
-grygorii
