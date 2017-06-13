From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: tps65217: Update binding documentation.
Date: Tue, 13 Jun 2017 09:43:20 -0500
Message-ID: <CAL_JsqJ8--8Wj9L3LFDrUpeQ33MUu3RwZfxM2x5tAr0Dp4uVqg@mail.gmail.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
 <20170609140309.zhagc5g662d4la3z@rob-hp-laptop> <CAFqH_53+diszv4QtKU0CgVPb3TO-MeDWjbPpFQuVzLXZsQ=Zog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CAFqH_53+diszv4QtKU0CgVPb3TO-MeDWjbPpFQuVzLXZsQ=Zog@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Tony
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 9, 2017 at 5:30 PM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Hello Rob,
>
> 2017-06-09 16:03 GMT+02:00 Rob Herring <robh@kernel.org>:
>> On Wed, Jun 07, 2017 at 12:32:39PM +0200, Enric Balletbo i Serra wrote:
>>> This patch adds a new binding documentation for the TPS65217 MFD and
>>> updates the documentation for all the sub-devices in accordance to get
>>> each individual sub-driver functioning correctly.
>>
>> Explain why breaking compatibility is okay.
>>
>
> We had some discussion in patch 4 that make me rethink a bit all this,
> please let me send a new version and continue the discussion there
> (now I'm not sure if I'll break the compatibility or not)
>
> But let me ask a question. The TPS65217 MFD has different sub-nodes
> (charger, backlight, pwrbutton, regulators) in DT, I suspect the
> answer is no, but is it ok that some of them were not described in the
> DT because there is nothing to configure?

But you are configuring the interrupts. I'm all for not creating nodes
just for the purpose instantiating a driver (DT is not the only way to
create platform devices) when the parent node is sufficient. We see
both models, but we don't really want a mixture of both ways so I'd
stick with the latter here.

> i.e: Have this because the resources of charger and pwrbutton are
> static so can be hard-coded in the driver
>
> &tps {
>         compatible = "ti,tps65217";
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
>         regulators {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 dcdc1_reg: regulator@0 {
>                         reg = <0>;
>                 ...
>        };
> };
>
> instead of :
>
> &tps {
>         compatible = "ti,tps65217";
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
>         charger {
>                 compatible = "ti,tps65217-charger";
>                 interrupts = <0>, <1>;
>                 interrupt-names = "USB", "AC";
>         };
>
>         pwrbutton {
>                 compatible = "ti,tps65217-pwrbutton";
>                 interrupts = <2>;
>         };
>
>         regulators {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 dcdc1_reg: regulator@0 {
>                         reg = <0>;
>                 ...
>        };
> };
