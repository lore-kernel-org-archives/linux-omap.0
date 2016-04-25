From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH 1/5] mfd: tps65217: Add support for IRQs
Date: Mon, 25 Apr 2016 12:50:58 +0200
Message-ID: <24ac37c7-a318-a145-0123-001947909d7b@grinn-global.com>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
 <1459789865-3704-3-git-send-email-m.niestroj@grinn-global.com>
 <57038E46.9070204@ti.com> <57039E74.7030704@grinn-global.com>
 <20160411094426.GB8094@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160411094426.GB8094@x1>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, broonie@kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ping

On 11.04.2016 11:44, Lee Jones wrote:
> FAO Mark,
>
>> On 05.04.2016 12:07, Grygorii Strashko wrote:
>>> On 04/04/2016 08:11 PM, Marcin Niestroj wrote:
>>>> Add support for handling IRQs: power button, AC and USB power stat=
e
>>>> changes. Mask and interrupt bits are shared within one register, w=
hich
>>>> prevents us to use regmap_irq implementation. New irq_domain is
>>>> created in
>>>> order to add interrupt handling for each tps65217's subsystem. IRQ
>>>> resources have been added for charger subsystem to be able to noti=
fy
>>>> about
>>>> AC and USB state changes.
>>>>
>>>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>>>> ---
>>>
>>> Just curious Why not use a regmap_irq?
>>
>> tps65217 has IRQ mask and status bits in a single register.
>> regmap_irq works in case of two different registers (one mask, one
>> status), but with the same layout of mask and status bits in both.
>
> Mark, is this the right approach?  Or is there another way regmap_irq
> can be manipulated to support this configuration?
>

--=20
Marcin Niestr=C3=B3j
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
