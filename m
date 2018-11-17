From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
Date: Sat, 17 Nov 2018 10:05:02 -0600
Message-ID: <20181117160502.dhlqbx5qnmdp5iog@kahuna>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113060111.16374-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 11:31-20181113, Vignesh R wrote:
> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
> defining pinmux configs in human readable form, instead of raw-coded
> hex values.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  MAINTAINERS                      |  1 +
>  include/dt-bindings/pinctrl/k3.h | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/k3.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa45ff36fde9..1574ad6d7ead 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2204,6 +2204,7 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/arm/ti/k3.txt
>  F:	arch/arm64/boot/dts/ti/Makefile
>  F:	arch/arm64/boot/dts/ti/k3-*
> +F:	include/dt-bindings/pinctrl/k3.h
>  
>  ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>  M:	Santosh Shilimkar <ssantosh@kernel.org>
> diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
> new file mode 100644
> index 000000000000..463d845a9b36
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/k3.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for pinctrl bindings for TI's K3 SoC
> + * family.
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +#ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
> +#define _DT_BINDINGS_PINCTRL_TI_K3_H
> +
> +#define PULLUDEN_SHIFT		(16)
> +#define PULLTYPESEL_SHIFT	(17)
> +#define RXACTIVE_SHIFT		(18)
> +
> +#define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
> +#define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> +
> +#define PULL_UP			(1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
> +#define PULL_DOWN		(0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
> +
> +#define INPUT_EN		(1 << RXACTIVE_SHIFT)
> +#define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
> +
> +/* Only these macros are expected be used directly in device tree files */
> +#define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
> +#define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
> +#define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
> +#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
> +#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
> +#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)


Thanks for reducing the combinations down to the minimum needed. We can
worry about the DS and isolation bits when we have a real user for them.

Acked-by: Nishanth Menon <nm@ti.com>

Tero: v4.21-rc1 perhaps ?

-- 
Regards,
Nishanth Menon
