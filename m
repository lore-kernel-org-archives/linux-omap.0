From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2] mfd: tps65217: Introduce dependency on CONFIG_OF
Date: Wed, 30 Aug 2017 11:16:51 +0530
Message-ID: <410b1bd1-39b2-35f4-68c7-3ac63fc265c2@ti.com>
References: <1496918764-23438-1-git-send-email-j-keerthy@ti.com>
 <CAFqH_52yTzmJaxxWpmdu+Kq-8T1LPbmQVb2yx=CXXQLd4POAgQ@mail.gmail.com>
 <CABxcv=n7V1KRcdypxYz+9vsDdSzXrANGFiyFW7ZXtA4GYLJ20Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=n7V1KRcdypxYz+9vsDdSzXrANGFiyFW7ZXtA4GYLJ20Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Thursday 08 June 2017 07:41 PM, Javier Martinez Canillas wrote:
> On Thu, Jun 8, 2017 at 3:32 PM, Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
>> Hi Keerthy:
>>
>> 2017-06-08 12:46 GMT+02:00 Keerthy <j-keerthy@ti.com>:
>>> Currently the driver boots only via device tree hence add a
>>> dependency on CONFIG_OF. This leaves with a bunch of unused code
>>> so clean that up.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>
> 
> [snip]
> 
>>>
>>>  config MFD_TPS65217
>>>         tristate "TI TPS65217 Power Management / White LED chips"
>>> -       depends on I2C
>>> +       depends on I2C && OF
>>
>> I think you should append || COMPILE_TEST here.
>>
> 
> For me it should be a separate patch, it's nice to have COMPILE_TEST
> but not related to this change IMHO.

Resurrecting this patch.

> 
>>>
>>> -static const struct i2c_device_id tps65217_id_table[] = {
>>> -       {"tps65217", TPS65217},
>>> -       { /* sentinel */ }
>>> -};
>>> -MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
> 
> Unfortunately you can't get rid of this table (yet) since the I2C
> subsystem always reports a MODALIAS of the form "i2c:tps65217" even
> when the devices have been registered via OF. There are only a couple
> of drivers more to clean-up and then I'll post a patch that fixes the
> I2C core to report a proper OF modalias. But for now, removing will
> mean that module autoload will be broken for this driver.

I believe now all the dependent patches are in to get rid of the above
table.

> 
> Best regards,
> Javier
> 
