From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 4/6] OMAP4: hwmod data: Add McSPI
Date: Tue, 18 Jan 2011 12:00:04 +0530
Message-ID: <AANLkTikjDBHXKgqJwDrrZCY6j6x7adWBvjb-KXzdWbzt@mail.gmail.com>
References: <32203.10.24.255.18.1295274218.squirrel@dbdmail.itg.ti.com> <87wrm35w9g.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57285 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1ARGaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 01:30:25 -0500
Received: by wwa36 with SMTP id 36so6134312wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 22:30:24 -0800 (PST)
In-Reply-To: <87wrm35w9g.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

On Mon, Jan 17, 2011 at 9:59 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Update omap4 hwmod file with McSPI info.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> Shouldn't Benoit be the author of this patch?

Sorry my mistake, will give a quick respin and post out a new version
today.

--
Thanks,
Govindraj.R

>
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0266 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 266 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index c2806bd..d4cd695 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -24,6 +24,7 @@
>> =A0#include <plat/cpu.h>
>> =A0#include <plat/gpio.h>
>> =A0#include <plat/dma.h>
>> +#include <plat/mcspi.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>>
>> @@ -2001,6 +2002,265 @@ static struct omap_hwmod omap44xx_wd_timer3_=
hwmod =3D {
>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP443=
0),
>> =A0};
>>
>> +/*
>> + * 'mcspi' class
>> + * multichannel serial port interface (mcspi) / master/slave synchr=
onous serial
>> + * bus
>> + */
>> +
>> +static struct omap_hwmod_class_sysconfig omap44xx_mcspi_sysc =3D {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMU=
=46REE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SOFTRESET =
| SYSC_HAS_RESET_STATUS),
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type2,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_mcspi_hwmod_class =3D {
>> + =A0 =A0 .name =3D "mcspi",
>> + =A0 =A0 .sysc =3D &omap44xx_mcspi_sysc,
>> + =A0 =A0 .rev =3D OMAP4_MCSPI_REV,
>> +};
>> +
>> +/* mcspi1 */
>> +static struct omap_hwmod omap44xx_mcspi1_hwmod;
>> +static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 65 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx0", .dma_req =3D 34 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx0", .dma_req =3D 35 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "tx1", .dma_req =3D 36 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx1", .dma_req =3D 37 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "tx2", .dma_req =3D 38 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx2", .dma_req =3D 39 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "tx3", .dma_req =3D 40 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx3", .dma_req =3D 41 + OMAP44XX_DMA_REQ_STAR=
T },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_mcspi1_addrs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48098000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480981ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> mcspi1 */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi1 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_per_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi1_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_mcspi1_addrs,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi1_addrs=
),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* mcspi1 slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_mcspi1_slaves[] =3D {
>> + =A0 =A0 &omap44xx_l4_per__mcspi1,
>> +};
>> +
>> +static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr =3D {
>> + =A0 =A0 .num_chipselect =3D 4,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_mcspi1_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mcspi1",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi_hwmod_class,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_mcspi1_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_mcspi1_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_mcspi1_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_mcspi1_sdma_reqs=
),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mcspi1_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4430_=
CM_L4PER_MCSPI1_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_mcspi1_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi1_slaves)=
,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &omap_mcspi1_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> +/* mcspi2 */
>> +static struct omap_hwmod omap44xx_mcspi2_hwmod;
>> +static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 66 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx0", .dma_req =3D 42 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx0", .dma_req =3D 43 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "tx1", .dma_req =3D 44 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx1", .dma_req =3D 45 + OMAP44XX_DMA_REQ_STAR=
T },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_mcspi2_addrs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4809a000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4809a1ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> mcspi2 */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi2 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_per_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi2_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_mcspi2_addrs,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi2_addrs=
),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* mcspi2 slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_mcspi2_slaves[] =3D {
>> + =A0 =A0 &omap44xx_l4_per__mcspi2,
>> +};
>> +
>> +static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr =3D {
>> + =A0 =A0 .num_chipselect =3D 2,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_mcspi2_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mcspi2",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi_hwmod_class,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_mcspi2_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_mcspi2_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_mcspi2_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_mcspi2_sdma_reqs=
),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mcspi2_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4430_=
CM_L4PER_MCSPI2_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_mcspi2_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi2_slaves)=
,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &omap_mcspi2_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> +/* mcspi3 */
>> +static struct omap_hwmod omap44xx_mcspi3_hwmod;
>> +static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 91 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx0", .dma_req =3D 14 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx0", .dma_req =3D 15 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "tx1", .dma_req =3D 22 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx1", .dma_req =3D 23 + OMAP44XX_DMA_REQ_STAR=
T },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_mcspi3_addrs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x480b8000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480b81ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> mcspi3 */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi3 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_per_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi3_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_mcspi3_addrs,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi3_addrs=
),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* mcspi3 slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_mcspi3_slaves[] =3D {
>> + =A0 =A0 &omap44xx_l4_per__mcspi3,
>> +};
>> +
>> +static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr =3D {
>> + =A0 =A0 .num_chipselect =3D 2,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_mcspi3_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mcspi3",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi_hwmod_class,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_mcspi3_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_mcspi3_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_mcspi3_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_mcspi3_sdma_reqs=
),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mcspi3_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4430_=
CM_L4PER_MCSPI3_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_mcspi3_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi3_slaves)=
,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &omap_mcspi3_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> +/* mcspi4 */
>> +static struct omap_hwmod omap44xx_mcspi4_hwmod;
>> +static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 48 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx0", .dma_req =3D 69 + OMAP44XX_DMA_REQ_STAR=
T },
>> + =A0 =A0 { .name =3D "rx0", .dma_req =3D 70 + OMAP44XX_DMA_REQ_STAR=
T },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_mcspi4_addrs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x480ba000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480ba1ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> mcspi4 */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi4 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_per_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi4_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_mcspi4_addrs,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi4_addrs=
),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* mcspi4 slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_mcspi4_slaves[] =3D {
>> + =A0 =A0 &omap44xx_l4_per__mcspi4,
>> +};
>> +
>> +static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr =3D {
>> + =A0 =A0 .num_chipselect =3D 1,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_mcspi4_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mcspi4",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mcspi_hwmod_class,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_mcspi4_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_mcspi4_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_mcspi4_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_mcspi4_sdma_reqs=
),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mcspi4_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4430_=
CM_L4PER_MCSPI4_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_mcspi4_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mcspi4_slaves)=
,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &omap_mcspi4_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> =A0static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>>
>> =A0 =A0 =A0 /* dmm class */
>> @@ -2068,6 +2328,12 @@ static __initdata struct omap_hwmod *omap44xx=
_hwmods[] =3D {
>> =A0 =A0 =A0 &omap44xx_wd_timer2_hwmod,
>> =A0 =A0 =A0 &omap44xx_wd_timer3_hwmod,
>>
>> + =A0 =A0 /* mcspi class */
>> + =A0 =A0 &omap44xx_mcspi1_hwmod,
>> + =A0 =A0 &omap44xx_mcspi2_hwmod,
>> + =A0 =A0 &omap44xx_mcspi3_hwmod,
>> + =A0 =A0 &omap44xx_mcspi4_hwmod,
>> +
>> =A0 =A0 =A0 NULL,
>> =A0};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
