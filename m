From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2] mfd: tps65217: Introduce dependency on CONFIG_OF
Date: Sun, 11 Jun 2017 21:51:37 +0200
Message-ID: <CABxcv=m7Ra=Z9=OMcEFSD8bB5hbVMN+BPgrXubDu-xY2bg31Pw@mail.gmail.com>
References: <1496918764-23438-1-git-send-email-j-keerthy@ti.com>
 <CAFqH_52yTzmJaxxWpmdu+Kq-8T1LPbmQVb2yx=CXXQLd4POAgQ@mail.gmail.com>
 <CABxcv=n7V1KRcdypxYz+9vsDdSzXrANGFiyFW7ZXtA4GYLJ20Q@mail.gmail.com>
 <481f45bd-7970-7254-6c38-654e412e4f9c@ti.com> <CABxcv=kcJQBYJhZiacCX1xC_hzJrwwcwSQtz8rh8mHtSog8euQ@mail.gmail.com>
 <31c8a0f3-885e-c464-f597-29d3894c19f9@ti.com> <8ad3c0ba-8e84-b75c-7873-882f90fa39d5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8ad3c0ba-8e84-b75c-7873-882f90fa39d5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Keerthy,

On Sun, Jun 11, 2017 at 8:12 PM, Keerthy <j-keerthy@ti.com> wrote:
>
>
> On Sunday 11 June 2017 10:50 AM, Keerthy wrote:
>>
>>
>> On Friday 09 June 2017 05:18 AM, Javier Martinez Canillas wrote:
>>> On Fri, Jun 9, 2017 at 1:18 AM, Keerthy <j-keerthy@ti.com> wrote:
>>>
>>> [snip]
>>>
>>>>>
>>>>>>>
>>>>>>> -static const struct i2c_device_id tps65217_id_table[] = {
>>>>>>> -       {"tps65217", TPS65217},
>>>>>>> -       { /* sentinel */ }
>>>>>>> -};
>>>>>>> -MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
>>>>>
>>>>> Unfortunately you can't get rid of this table (yet) since the I2C
>>>>> subsystem always reports a MODALIAS of the form "i2c:tps65217" even
>>>>> when the devices have been registered via OF. There are only a couple
>>>>> of drivers more to clean-up and then I'll post a patch that fixes the
>>>>> I2C core to report a proper OF modalias. But for now, removing will
>>>>> mean that module autoload will be broken for this driver.
>>>>
>>>> So this means whole logic of probe_new without i2c_device_id is not
>>>> ready? I will have to revert all that logic right?
>>>>
>>>
>>> No, that's not what I meant.
>>>
>>> It's absolutely correct for drivers that can't be build as a module
>>> (i.e: have a boolean instead of tristate Kconfig symbol) or if you
>>> want to get rid of the struct i2c_device_id pointed passed to your
>>> probe callback since isn't used in the driver.
>>>
>>> But it's not enough to get rid of the struct i2c_device_id table for
>>> the reason I mentioned before.
>>
>> Thanks for clarifying!
>>
>>>
>>>> Lee Jones,
>>>>
>>>> Does that mean even for LP87565 driver we need MODULE_DEVICE_TABLE for
>>>> module autoload?
>>>>
>>>
>>> I guess you are talking about [0], right?
>>>
>>> Yes, it's needed because the driver can be built as a module.
>>
>> Okay.
>
> Javier,
>
> I found one instance where in the config is tristate MFD_MAX77686.
> The driver already seems to be using probe_new.
>
> mfd: max77686: Use the struct i2c_driver .probe_new instead of .probe
>
> So for the above module auto probe would be broken?
>

Yes, and to make things even worse I see that I was the author of that
commit... so I missed that when posting the series :(

Now, arguably no one would build the MAX77686 as a module since the
regulators provided by that PMIC need to be enabled very early in the
boot process or the system will hang. Both exynos_defconfig and
multi_v7_defconfig have it as built-in. But yes, this is a regression
and the patch should be reverted (or maybe just wait for the I2C core
to report a proper modalias since no one complained, not sure what's
better for this driver).

> - Keerthy
>>
>>>

Best regards,
Javier
