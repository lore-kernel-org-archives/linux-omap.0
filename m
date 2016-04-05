From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/5] mfd: tps65217: Add support for IRQs
Date: Tue, 5 Apr 2016 13:07:02 +0300
Message-ID: <57038E46.9070204@ti.com>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
 <1459789865-3704-3-git-send-email-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1459789865-3704-3-git-send-email-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>, Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/04/2016 08:11 PM, Marcin Niestroj wrote:
> Add support for handling IRQs: power button, AC and USB power state
> changes. Mask and interrupt bits are shared within one register, which
> prevents us to use regmap_irq implementation. New irq_domain is created in
> order to add interrupt handling for each tps65217's subsystem. IRQ
> resources have been added for charger subsystem to be able to notify about
> AC and USB state changes.
>
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---

Just curious Why not use a regmap_irq?

-- 
regards,
-grygorii
