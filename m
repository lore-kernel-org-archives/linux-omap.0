From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 09/42] drivers: gpio: sprd: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 09:08:12 +0100
Message-ID: <38a0ea2f-2324-ab21-b43f-bb3b883c1422@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-9-git-send-email-info@metux.net>
 <CAMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, Thierry Reding <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, ssantosh@kernel.org, khilman@kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>, jun.nie@linaro.org, shawnguo@kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.orgli
List-Id: linux-omap@vger.kernel.org

On 12.03.19 03:38, Baolin Wang wrote:
> On Tue, 12 Mar 2019 at 02:55, Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> Use the new helper that wraps the calls to platform_get_resource()
>> and devm_ioremap_resource() together.
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>> ---
>>  drivers/gpio/gpio-eic-sprd.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
>> index f0223ce..c12de87 100644
>> --- a/drivers/gpio/gpio-eic-sprd.c
>> +++ b/drivers/gpio/gpio-eic-sprd.c
>> @@ -567,7 +567,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
>>         const struct sprd_eic_variant_data *pdata;
>>         struct gpio_irq_chip *irq;
>>         struct sprd_eic *sprd_eic;
>> -       struct resource *res;
>>         int ret, i;
>>
>>         pdata = of_device_get_match_data(&pdev->dev);
>> @@ -596,13 +595,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>>                  * have one bank EIC, thus base[1] and base[2] can be
>>                  * optional.
>>                  */
>> -               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>> -               if (!res)
>> -                       continue;
>> -
>> -               sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
>> +               sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, 0);
> 
> This is incorrect, since we can have multiple IO resources, but you
> only get index 0.

ah, right, it has to be i instead of 0. thanks for pointing that out.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
