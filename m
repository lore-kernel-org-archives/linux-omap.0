From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: tps65217: Add power button interrupt to the
 common tps65217.dtsi file
Date: Tue, 13 Jun 2017 11:08:39 +0200
Message-ID: <CAFqH_50syu5aHBQtJkh-Dpz8Yc_6w0X853DO46T3ZAAJ10F-Pw@mail.gmail.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
 <20170612212412.22719-2-enric.balletbo@collabora.com> <20170613073519.GA3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613073519.GA3730@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

2017-06-13 9:35 GMT+02:00 Tony Lindgren <tony@atomide.com>:
> * Enric Balletbo i Serra <enric.balletbo@collabora.com> [170612 14:28]:
>> The interrupt for power button is static data that comes from the
>> datasheet, there is no reason to need to define this value on every
>> board so seams reasonable put this information into the common tps65217
>> file.
>
> I think there's a problem with these patches where we no longer know
> if the interrupts are wired up on a board. For example, if the USB PHY
> VBUS interrupt is not connected, the phy driver needs poll the
> cable state.
>

Hmm, the tps65217 doesn't have a USB PHY like others tps, so not sure
how could affect this patch. Did you see this issue in any board that
uses tps65217 or any am335x based board which commonly uses this pmic?

> And on some PMICs some pins can be muxed to GPIO mode, don't
> remember if that can be done with tps65217.
>

i don't think this is the case of the boards that use tps65217 as the
pins can't be muxed to GPIO mode.

> Regards,
>
> Tony

Regards,
 Enric
