From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support for
 AUXCLKs
Date: Thu, 11 Apr 2013 11:46:48 -0700
Message-ID: <20130411184648.7915.17500@quantum>
References: <515D2D30.3000306@ti.com> <515EA9E3.1010409@ti.com>
 <20130405155851.GA10155@atomide.com> <5163E589.1040809@ti.com>
 <20130409164928.GL10155@atomide.com> <20130409174319.GP10155@atomide.com>
 <20130409204900.GA8815@kahuna> <20130410080630.14359.68178@quantum>
 <5165453E.6090503@ti.com> <20130410173921.GA31017@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130410173921.GA31017@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>
Cc: grygorii.strashko@ti.com, linux@arm.linux.org.uk, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Nishanth Menon (2013-04-10 10:39:21)
> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
> new file mode 100644
> index 0000000..63a4cce
> --- /dev/null
> +++ b/drivers/clk/omap/clk.c
> @@ -0,0 +1,94 @@
> +/*
> + * Texas Instruments OMAP Clock driver
> + *
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + *     Nishanth Menon
> + *     Tony Lindgren <tony@atomide.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clkdev.h>
> +#include <linux/clk-private.h>

Please use clk-provider.h.  Otherwise this looks like an OK transitional
solution.  Hopefully this will be replaced with a more legitimate clock
driver for 3.11.

Regards,
Mike
