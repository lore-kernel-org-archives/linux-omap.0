From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: mfd: Provide human readable defines
 for TPS65217 interrupts
Date: Fri, 18 Nov 2016 14:53:53 +0000
Message-ID: <20161118145353.GE2301@dell.home>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
 <20161028123702.21849-6-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161028123702.21849-6-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 28 Oct 2016, Milo Kim wrote:

> TPS65217 supports three interrupt sources. This patch enables assigning
> each IRQ number in the charger and power button node. Then corresponding
> IRQ will be requested by each driver.
> 
> Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  include/dt-bindings/mfd/tps65217.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/tps65217.h
> 
> diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
> new file mode 100644
> index 0000000..cafb9e6
> --- /dev/null
> +++ b/include/dt-bindings/mfd/tps65217.h
> @@ -0,0 +1,26 @@
> +/*
> + * This header provides macros for TI TPS65217 DT bindings.
> + *
> + * Copyright (C) 2016 Texas Instruments
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __DT_BINDINGS_TPS65217_H__
> +#define __DT_BINDINGS_TPS65217_H__
> +
> +#define TPS65217_IRQ_USB	0
> +#define TPS65217_IRQ_AC		1
> +#define TPS65217_IRQ_PB		2

What are "AC" and "PB".  Seeing as these are meant to be "human
readable", let's make them more human friendly.

> +#endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
