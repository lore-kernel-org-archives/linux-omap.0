From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: tps65217: Add support for IRQs
Date: Mon, 11 Apr 2016 10:44:26 +0100
Message-ID: <20160411094426.GB8094@x1>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
 <1459789865-3704-3-git-send-email-m.niestroj@grinn-global.com>
 <57038E46.9070204@ti.com>
 <57039E74.7030704@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57039E74.7030704@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>, broonie@kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=46AO Mark,

> On 05.04.2016 12:07, Grygorii Strashko wrote:
> >On 04/04/2016 08:11 PM, Marcin Niestroj wrote:
> >>Add support for handling IRQs: power button, AC and USB power state
> >>changes. Mask and interrupt bits are shared within one register, wh=
ich
> >>prevents us to use regmap_irq implementation. New irq_domain is
> >>created in
> >>order to add interrupt handling for each tps65217's subsystem. IRQ
> >>resources have been added for charger subsystem to be able to notif=
y
> >>about
> >>AC and USB state changes.
> >>
> >>Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> >>---
> >
> >Just curious Why not use a regmap_irq?
>=20
> tps65217 has IRQ mask and status bits in a single register.
> regmap_irq works in case of two different registers (one mask, one
> status), but with the same layout of mask and status bits in both.

Mark, is this the right approach?  Or is there another way regmap_irq
can be manipulated to support this configuration?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
