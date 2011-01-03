From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/7 v2] OMAP2430: hwmod data: Add McSPI
Date: Mon, 3 Jan 2011 18:50:39 +0530
Message-ID: <AANLkTinvQOGhe-Y-6nECig3ZpKHkm1nJ8wNeTMgm4j2U@mail.gmail.com>
References: <33236.10.24.255.18.1291212082.squirrel@dbdmail.itg.ti.com> <20101230190320.GA2713@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48144 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab1ACNVA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 08:21:00 -0500
Received: by qyj19 with SMTP id 19so15845127qyj.19
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 05:20:59 -0800 (PST)
In-Reply-To: <20101230190320.GA2713@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Cousson@dbdmail.itg.ti.com, Benoit <b-cousson@ti.com>, Charulatha V <charu@ti.com>

On Fri, Dec 31, 2010 at 12:33 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Wed, Dec 01, 2010 at 07:31:22PM +0530, Govindraj.R wrote:
>> From: Charulatha V <charu@ti.com>
>>
>> Update the 2430 hwmod data file with McSPI info.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Hmmm; this patch is virtually identical to the first patch in this
> series which adds 2420 hwmod support. =A0I see a large block of
> identical data with minor differences. =A0Surely support for these tw=
o
> chips can share the common blocks of data.
>
> Is this going to be a common situation for HWMOD data?

Grant,

Thanks for your Review comments.

Currently we have four hwmod data files:
2420, 2430 , 3xxx, 44xx

We need to fill these four files with hw info data to be passed
to driver there could be small info that might be duplicated.

Currently we are updating all the four files.
As Paul said there might be some changes done going forward.
To handle the hwmod files.

Hope this clarifies.

--
Thanks,
Govindraj.R


>
> g.
>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0219 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 219 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_2430_data.c
>> index 7cf0d3a..bcdfb2b 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> @@ -17,6 +17,7 @@
>> =A0#include <plat/dma.h>
>> =A0#include <plat/serial.h>
>> =A0#include <plat/i2c.h>
>> +#include <plat/mcspi.h>
>> =A0#include <plat/omap24xx.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>> @@ -38,6 +39,9 @@ static struct omap_hwmod omap2430_iva_hwmod;
>> =A0static struct omap_hwmod omap2430_l3_main_hwmod;
>> =A0static struct omap_hwmod omap2430_l4_core_hwmod;
>> =A0static struct omap_hwmod omap2430_wd_timer2_hwmod;
>> +static struct omap_hwmod omap2430_mcspi1_hwmod;
>> +static struct omap_hwmod omap2430_mcspi2_hwmod;
>> +static struct omap_hwmod omap2430_mcspi3_hwmod;
>>
>> =A0/* L3 -> L4_CORE interface */
>> =A0static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core =3D {
>> @@ -216,6 +220,60 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wk=
up_slaves[] =3D {
>> =A0static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] =3D {
>> =A0};
>>
>> +/* l4 core -> mcspi1 interface */
>> +static struct omap_hwmod_addr_space omap2430_mcspi1_addr_space[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48098000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480980ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT=
,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi1 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap2430_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap2430_mcspi1_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "mcspi1_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2430_mcspi1_addr_space,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2430_mcspi1_addr_=
space),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* l4 core -> mcspi2 interface */
>> +static struct omap_hwmod_addr_space omap2430_mcspi2_addr_space[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4809a000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4809a0ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT=
,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi2 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap2430_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap2430_mcspi2_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "mcspi2_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2430_mcspi2_addr_space,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2430_mcspi2_addr_=
space),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* l4 core -> mcspi3 interface */
>> +static struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x480b8000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480b80ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT=
,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap2430_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap2430_mcspi3_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "mcspi3_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2430_mcspi3_addr_space,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2430_mcspi3_addr_=
space),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> =A0/* L4 WKUP */
>> =A0static struct omap_hwmod omap2430_l4_wkup_hwmod =3D {
>> =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "l4_wkup",
>> @@ -569,6 +627,162 @@ static struct omap_hwmod omap2430_i2c2_hwmod =3D=
 {
>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP243=
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
>> +static struct omap_hwmod_class_sysconfig omap2430_mcspi_sysc =3D {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS=
_SIDLEMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_E=
NAWAKEUP | SYSC_HAS_SOFTRESET |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_A=
UTOIDLE),
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap2430_mcspi_class =3D {
>> + =A0 =A0 .name =3D "mcspi",
>> + =A0 =A0 .sysc =3D &omap2430_mcspi_sysc,
>> + =A0 =A0 .rev =3D OMAP2_MCSPI_REV,
>> +};
>> +
>> +/* mcspi1 */
>> +static struct omap_hwmod_irq_info omap2430_mcspi1_mpu_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 65 },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap2430_mcspi1_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx0", .dma_req =3D 35 }, /* DMA_SPI1_TX0 */
>> + =A0 =A0 { .name =3D "rx0", .dma_req =3D 36 }, /* DMA_SPI1_RX0 */
>> + =A0 =A0 { .name =3D "tx1", .dma_req =3D 37 }, /* DMA_SPI1_TX1 */
>> + =A0 =A0 { .name =3D "rx1", .dma_req =3D 38 }, /* DMA_SPI1_RX1 */
>> + =A0 =A0 { .name =3D "tx2", .dma_req =3D 39 }, /* DMA_SPI1_TX2 */
>> + =A0 =A0 { .name =3D "rx2", .dma_req =3D 40 }, /* DMA_SPI1_RX2 */
>> + =A0 =A0 { .name =3D "tx3", .dma_req =3D 41 }, /* DMA_SPI1_TX3 */
>> + =A0 =A0 { .name =3D "rx3", .dma_req =3D 42 }, /* DMA_SPI1_RX3 */
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap2430_mcspi1_slaves[] =3D {
>> + =A0 =A0 &omap2430_l4_core__mcspi1,
>> +};
>> +
>> +static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr =3D {
>> + =A0 =A0 .num_chipselect =3D 4,
>> +};
>> +
>> +static struct omap_hwmod omap2430_mcspi1_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mcspi1_hwmod",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap2430_mcspi1_mpu_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap2430_mcspi1_mpu_irqs)=
,
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap2430_mcspi1_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap2430_mcspi1_sdma_reqs=
),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mcspi1_fck",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP24XX_E=
N_MCSPI1_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP2=
4XX_ST_MCSPI1_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap2430_mcspi1_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2430_mcspi1_slaves)=
,
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap2430_mcspi_class,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &omap_mcspi1_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)=
,
>> +};
>> +
>> +/* mcspi2 */
>> +static struct omap_hwmod_irq_info omap2430_mcspi2_mpu_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 66 },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap2430_mcspi2_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx0", .dma_req =3D 43 }, /* DMA_SPI2_TX0 */
>> + =A0 =A0 { .name =3D "rx0", .dma_req =3D 44 }, /* DMA_SPI2_RX0 */
>> + =A0 =A0 { .name =3D "tx1", .dma_req =3D 45 }, /* DMA_SPI2_TX1 */
>> + =A0 =A0 { .name =3D "rx1", .dma_req =3D 46 }, /* DMA_SPI2_RX1 */
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap2430_mcspi2_slaves[] =3D {
>> + =A0 =A0 &omap2430_l4_core__mcspi2,
>> +};
>> +
>> +static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr =3D {
>> + =A0 =A0 .num_chipselect =3D 2,
>> +};
>> +
>> +static struct omap_hwmod omap2430_mcspi2_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mcspi2_hwmod",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap2430_mcspi2_mpu_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap2430_mcspi2_mpu_irqs)=
,
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap2430_mcspi2_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap2430_mcspi2_sdma_reqs=
),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mcspi2_fck",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP24XX_E=
N_MCSPI2_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP2=
4XX_ST_MCSPI2_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap2430_mcspi2_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2430_mcspi2_slaves)=
,
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap2430_mcspi_class,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &omap_mcspi2_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)=
,
>> +};
>> +
>> +/* mcspi3 */
>> +static struct omap_hwmod_irq_info omap2430_mcspi3_mpu_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 91 },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap2430_mcspi3_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx0", .dma_req =3D 15 }, /* DMA_SPI3_TX0 */
>> + =A0 =A0 { .name =3D "rx0", .dma_req =3D 16 }, /* DMA_SPI3_RX0 */
>> + =A0 =A0 { .name =3D "tx1", .dma_req =3D 23 }, /* DMA_SPI3_TX1 */
>> + =A0 =A0 { .name =3D "rx1", .dma_req =3D 24 }, /* DMA_SPI3_RX1 */
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap2430_mcspi3_slaves[] =3D {
>> + =A0 =A0 &omap2430_l4_core__mcspi3,
>> +};
>> +
>> +static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr =3D {
>> + =A0 =A0 .num_chipselect =3D 2,
>> +};
>> +
>> +static struct omap_hwmod omap2430_mcspi3_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mcspi3_hwmod",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap2430_mcspi3_mpu_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap2430_mcspi3_mpu_irqs)=
,
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap2430_mcspi3_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap2430_mcspi3_sdma_reqs=
),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mcspi3_fck",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP2430_E=
N_MCSPI3_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP2=
430_ST_MCSPI3_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap2430_mcspi3_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2430_mcspi3_slaves)=
,
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap2430_mcspi_class,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &omap_mcspi3_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)=
,
>> +};
>> +
>> =A0static __initdata struct omap_hwmod *omap2430_hwmods[] =3D {
>> =A0 =A0 =A0 &omap2430_l3_main_hwmod,
>> =A0 =A0 =A0 &omap2430_l4_core_hwmod,
>> @@ -581,6 +795,11 @@ static __initdata struct omap_hwmod *omap2430_h=
wmods[] =3D {
>> =A0 =A0 =A0 &omap2430_uart3_hwmod,
>> =A0 =A0 =A0 &omap2430_i2c1_hwmod,
>> =A0 =A0 =A0 &omap2430_i2c2_hwmod,
>> +
>> + =A0 =A0 /* mcspi class */
>> + =A0 =A0 &omap2430_mcspi1_hwmod,
>> + =A0 =A0 &omap2430_mcspi2_hwmod,
>> + =A0 =A0 &omap2430_mcspi3_hwmod,
>> =A0 =A0 =A0 NULL,
>> =A0};
>>
>> --
>> 1.7.1
>>
>>
>>
>> --------------------------------------------------------------------=
----------
>> Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
>> Tap into the largest installed PC base & get more eyes on your game =
by
>> optimizing for Intel(R) Graphics Technology. Get started today with =
the
>> Intel(R) Software Partner Program. Five $500 cash prizes are up for =
grabs.
>> http://p.sf.net/sfu/intelisp-dev2dev
>> _______________________________________________
>> spi-devel-general mailing list
>> spi-devel-general@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
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
