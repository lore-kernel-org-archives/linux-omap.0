From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCHv2 2/2] power_supply: Add support for tps65217-charger.
Date: Thu, 24 Sep 2015 17:55:35 +0200
Message-ID: <CAFqH_52FJMY=p5jSZwxegSNvCUtwmsYNr2oPtimz990gy9JtCw@mail.gmail.com>
References: <1443079405-17813-1-git-send-email-enric.balletbo@collabora.com>
	<1443079405-17813-3-git-send-email-enric.balletbo@collabora.com>
	<20150924154529.GB3125@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150924154529.GB3125@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, sameo@linux.intel.com, Lee Jones <lee.jones@linaro.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-omap@vger.kernel.org

Hi,

2015-09-24 17:45 GMT+02:00 Sebastian Reichel <sre@kernel.org>:
> Hi,
>
> On Thu, Sep 24, 2015 at 09:23:25AM +0200, Enric Balletbo i Serra wrote:
>> This patch adds support for the tps65217 charger driver. This driver is
>> responsible for controlling the charger aspect of the tps65217 mfd.
>> Currently, this mainly consists of turning on and off the charger, but
>> some other features of the charger can be supported through this driver.
>>
>> [...]
>>
>> +static int tps65217_ac_get_property(struct power_supply *psy,
>> +                     enum power_supply_property psp,
>> +                     union power_supply_propval *val)
>> +{
>> +     struct tps65217_charger *charger = power_supply_get_drvdata(psy);
>> +
>> +     if (psp == POWER_SUPPLY_PROP_ONLINE) {
>> +             val->intval = charger->ac_online;
>> +             charger->prev_ac_online = charger->ac_online;
>
> I think this is no longer needed at this place.
>
Right, as I moved ...

>> +             return 0;
>> +     }
>> +     return -EINVAL;
>> +}
>>
>> [...]
>>
>> +static int tps65217_charger_remove(struct platform_device *pdev)
>> +{
>> +     struct tps65217_charger *charger = platform_get_drvdata(pdev);
>> +
>> +     kthread_stop(charger->poll_task);
>> +
>> +     power_supply_unregister(charger->ac);
>
> This is not needed with devm_power_supply_register() and actually
> it's wrong, since it would be called again by managed resources
> infrastructure.
>

Yes I missed this unregister. I'll send v3

Thanks,
Enric

>> +     return 0;
>> +}
>
> -- Sebastian
