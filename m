From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/5] mfd: tps65217: Add support for IRQs
Date: Thu, 16 Jun 2016 15:30:18 +0100
Message-ID: <20160616143018.GY4948@dell>
References: <20160616114110.23455-1-m.niestroj@grinn-global.com>
 <20160616114110.23455-2-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160616114110.23455-2-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 16 Jun 2016, Marcin Niestroj wrote:

> Add support for handling IRQs: power button, AC and USB power state
> changes. Mask and interrupt bits are shared within one register, whic=
h
> prevents us to use regmap_irq implementation. New irq_domain is creat=
ed in
> order to add interrupt handling for each tps65217's subsystem. IRQ
> resources have been added for charger subsystem to be able to notify =
about
> AC and USB state changes.
>=20
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---

Please insert a change-log here in future.

>  drivers/mfd/Kconfig          |   1 +
>  drivers/mfd/tps65217.c       | 194 +++++++++++++++++++++++++++++++++=
++++++++--
>  include/linux/mfd/tps65217.h |  11 +++
>  3 files changed, 198 insertions(+), 8 deletions(-)

Once you've fixed Grygorii's comments, you may add my:

  Acked-by: Lee Jones <lee.jones@linaro.org>

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
