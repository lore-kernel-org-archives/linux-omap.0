From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 4/4] mfd: tps65217: Instantiate sub-devices from device tree
Date: Fri, 9 Jun 2017 02:00:01 +0200
Message-ID: <CABxcv=nzCreCSm9wkY+Kv_-vmoQN12Ct=_VegsfTrbe6H-1hTw@mail.gmail.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
 <20170607103242.16008-4-enric.balletbo@collabora.com> <6359abe2-9a21-78a2-f5ea-87e2e3335af3@ti.com>
 <CAFqH_53v32iODN4xhoh4ho4s6grxknEDS3Ak6CHBcTAQo6fDNw@mail.gmail.com>
 <578f348c-509f-79d3-9770-73c9fcffe19c@ti.com> <CAFqH_52rU7ZBG_Muy2JHoqJGdXOdsNfmtJxsZoPRyx3V1aWmFw@mail.gmail.com>
 <CABxcv=mN6=hbDSqrVkwSL8zccCntN7m_3DP6ZCbkOT6CLw+skQ@mail.gmail.com> <fba09819-7d7e-57bb-c147-46c39098cff8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fba09819-7d7e-57bb-c147-46c39098cff8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pav>
List-Id: linux-omap@vger.kernel.org

Hello Grygorii,

[snip]

>>
>> For tps65218 couldn't instead of using mfd_add_devices() for all the
>> sub-devs, had used of_platform_populate() for the ones that have
>> device nodes and mfd_add_devices() only for the "tps65218-regulator"?
>>
>> The commit talks about nodes without compatibles but's actually about
>> sub-devices without an associated device node. For me it makes sense
>> to use of_platform_populate() when the MFD has device nodes for their
>> sub-devices and mfd_add_devices() when DT knows nothing about the
>> sub-devices.
>
> FYI. Below is link discussion I'm referring to between Mark Brown and Andrew F. Davis
> https://lkml.org/lkml/2015/10/22/823
> the same - https://groups.google.com/forum/#!topic/linux.kernel/wQsdSpPMroQ
>

Thanks a lot for the pointer. There's a subtle difference between the
argument you made and the one that Mark is making in this thread
though.

Because you said (sorry if I misunderstood) that mfd_add_devices()
should be used instead of of_device_populate() even when sub-devices
are described as DT nodes (as is the case in the commit you shared)
while Mark is saying that if the sub-devs IP blocks are part of the
MFD, then it shouldn't be exposed in the DT and be instantiated via
mfd_add_devices() and I absolutely agree with that.

So I was arguing for using of_device_populate() if the sub-devices are
described in the DT. If that makes sense or not to expose the
sub-devices in the DT for this particular driver is a different
discussion and I can't comment on that since I'm not familiar with the
HW.

Best regards,
Javier
