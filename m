From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2] mfd: tps65217: Introduce dependency on CONFIG_OF
Date: Sun, 11 Jun 2017 10:50:30 +0530
Message-ID: <31c8a0f3-885e-c464-f597-29d3894c19f9@ti.com>
References: <1496918764-23438-1-git-send-email-j-keerthy@ti.com>
 <CAFqH_52yTzmJaxxWpmdu+Kq-8T1LPbmQVb2yx=CXXQLd4POAgQ@mail.gmail.com>
 <CABxcv=n7V1KRcdypxYz+9vsDdSzXrANGFiyFW7ZXtA4GYLJ20Q@mail.gmail.com>
 <481f45bd-7970-7254-6c38-654e412e4f9c@ti.com>
 <CABxcv=kcJQBYJhZiacCX1xC_hzJrwwcwSQtz8rh8mHtSog8euQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=kcJQBYJhZiacCX1xC_hzJrwwcwSQtz8rh8mHtSog8euQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Friday 09 June 2017 05:18 AM, Javier Martinez Canillas wrote:
> On Fri, Jun 9, 2017 at 1:18 AM, Keerthy <j-keerthy@ti.com> wrote:
> 
> [snip]
> 
>>>
>>>>>
>>>>> -static const struct i2c_device_id tps65217_id_table[] = {
>>>>> -       {"tps65217", TPS65217},
>>>>> -       { /* sentinel */ }
>>>>> -};
>>>>> -MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
>>>
>>> Unfortunately you can't get rid of this table (yet) since the I2C
>>> subsystem always reports a MODALIAS of the form "i2c:tps65217" even
>>> when the devices have been registered via OF. There are only a couple
>>> of drivers more to clean-up and then I'll post a patch that fixes the
>>> I2C core to report a proper OF modalias. But for now, removing will
>>> mean that module autoload will be broken for this driver.
>>
>> So this means whole logic of probe_new without i2c_device_id is not
>> ready? I will have to revert all that logic right?
>>
> 
> No, that's not what I meant.
> 
> It's absolutely correct for drivers that can't be build as a module
> (i.e: have a boolean instead of tristate Kconfig symbol) or if you
> want to get rid of the struct i2c_device_id pointed passed to your
> probe callback since isn't used in the driver.
> 
> But it's not enough to get rid of the struct i2c_device_id table for
> the reason I mentioned before.

Thanks for clarifying!

> 
>> Lee Jones,
>>
>> Does that mean even for LP87565 driver we need MODULE_DEVICE_TABLE for
>> module autoload?
>>
> 
> I guess you are talking about [0], right?
> 
> Yes, it's needed because the driver can be built as a module.

Okay.

> 
> [0]: https://lkml.org/lkml/2017/5/19/394
> 
> Best regards,
> Javier
> 
