From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 02/33] clk: omap: introduce clock driver
Date: Wed, 31 Jul 2013 11:59:15 +0300
Message-ID: <51F8D1E3.2@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-3-git-send-email-t-kristo@ti.com> <51F7DA0D.7060709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F7DA0D.7060709@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2013 06:21 PM, Nishanth Menon wrote:
> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>> Parses OMAP clock data from DT and registers those clocks with the clock
>> framework.  dt_omap_clk_init must be called early during boot for timer
>> initialization so it is exported and called from the existing clock code
>> instead of probing like a real driver. Based on initial work done by
>> Mike Turquette.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> ---
>>   drivers/clk/Makefile      |    1 +
>>   drivers/clk/omap/Makefile |    1 +
>>   drivers/clk/omap/clk.c    |   39
>> +++++++++++++++++++++++++++++++++++++++
>
> Minor suggestion - should we just start drivers/clk/ti/ instead of
> clk/omap?
>
> AM335x/DRA7 are not "strictly OMAP".. might also allow for some reuse
> for other TI platforms..

Not sure, this idea has been bounced around a bit. samsung has its own 
directory under drivers/clk/ so maybe. I can change this if there is a 
strong wish for this.

>
>>   include/linux/clk/omap.h  |   24 ++++++++++++++++++++++++
>>   4 files changed, 65 insertions(+)
>>   create mode 100644 drivers/clk/omap/Makefile
>>   create mode 100644 drivers/clk/omap/clk.c
>>   create mode 100644 include/linux/clk/omap.h
>>
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index 4038c2b..d3c3733 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_VT8500)    += clk-vt8500.o
>>   obj-$(CONFIG_ARCH_ZYNQ)        += zynq/
>>   obj-$(CONFIG_ARCH_TEGRA)    += tegra/
>>   obj-$(CONFIG_PLAT_SAMSUNG)    += samsung/
>> +obj-$(CONFIG_ARCH_OMAP)        += omap/
>>
>>   obj-$(CONFIG_X86)        += x86/
>>
>> diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
>> new file mode 100644
>> index 0000000..8195931
>> --- /dev/null
>> +++ b/drivers/clk/omap/Makefile
>> @@ -0,0 +1 @@
>> +obj-y                    += clk.o
>> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
>> new file mode 100644
>> index 0000000..4bf1929
>> --- /dev/null
>> +++ b/drivers/clk/omap/clk.c
>> @@ -0,0 +1,39 @@
>> +/*
>> + * OMAP PRCM clock driver
>
> maybe then prcm-clk.c ?

Maybe remove the PRCM part. We have some clocks behind i2c for example, 
and we might want to add support for them here.

>
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *     Tero Kristo <t-kristo@ti.com>
>> + *     Mike Turquette <mturquette@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk/omap.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of_device.h>
>> +
>> +/* FIXME - should the OMAP PRCM clock driver match generic types? */
>
> should it? :)

Not 100% sure about the answer to this, the current implementation works 
though so we could potentially drop this comment. :)

>
>> +static const struct of_device_id clk_match[] = {
>> +    {.compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> drivers/clk/clk-fixed-rate.c seems to already do this with
> CLK_OF_DECLARE, or am I mistaken? and so on?
>> +    {.compatible = "mux-clock", .data = of_mux_clk_setup, },
>> +    {.compatible = "fixed-factor-clock",
>> +        .data = of_fixed_factor_clk_setup, },
>> +    {.compatible = "divider-clock", .data = of_divider_clk_setup, },
>> +    {.compatible = "gate-clock", .data = of_gate_clk_setup, },
>> +    {},
>> +};
>> +
>> +/* FIXME - need to initialize early; skip real driver registration &
>> probe */
>> +int __init dt_omap_clk_init(void)
>
> Might be good to have kernel doc to explain the init requirement as
> documented in commit message.

Yeah, I am lacking docs once again.

>
>> +{
>> +    of_clk_init(clk_match);
>
> just doing of_clk_init(NULL); should do the job, no? that could even be
> a static inline OR introduced in board_generic without additional headers?

I don't think that works, as we have special clock node types we want to 
support (the TI specific types, and we want to override the default 
behavior of some.)

>
>> +    return 0;
>> +}
>> diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
>> new file mode 100644
>> index 0000000..647f02f
>> --- /dev/null
>> +++ b/include/linux/clk/omap.h
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>
> would you like to match licensing to that of the C file?

Ok, copy paste bug #2 for this. Initial version was worse than this though.

>
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
>> 02111-1307  USA
>> + */
>> +
>> +#ifndef __LINUX_CLK_OMAP_H_
>> +#define __LINUX_CLK_OMAP_H_
>> +
>> +int __init dt_omap_clk_init(void);
>> +
>> +#endif
>>
>
>
