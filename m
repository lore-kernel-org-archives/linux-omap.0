From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH 1/5] mfd: tps65217: Add support for IRQs
Date: Tue, 5 Apr 2016 13:16:04 +0200
Message-ID: <57039E74.7030704@grinn-global.com>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
 <1459789865-3704-3-git-send-email-m.niestroj@grinn-global.com>
 <57038E46.9070204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <57038E46.9070204@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 05.04.2016 12:07, Grygorii Strashko wrote:
> On 04/04/2016 08:11 PM, Marcin Niestroj wrote:
>> Add support for handling IRQs: power button, AC and USB power state
>> changes. Mask and interrupt bits are shared within one register, which
>> prevents us to use regmap_irq implementation. New irq_domain is
>> created in
>> order to add interrupt handling for each tps65217's subsystem. IRQ
>> resources have been added for charger subsystem to be able to notify
>> about
>> AC and USB state changes.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>> ---
>
> Just curious Why not use a regmap_irq?
>

tps65217 has IRQ mask and status bits in a single register. regmap_irq 
works in case of two different registers (one mask, one status), but 
with the same layout of mask and status bits in both.

-- 
Marcin Niestroj
