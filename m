From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [patch v3 3/3] arm: omap4: support pmu
Date: Mon, 7 Mar 2011 10:54:34 +0100
Message-ID: <AANLkTin_qgLYNZhSfviF4FA2V_U5S+U+1-q7M=3USgoS@mail.gmail.com>
References: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
	<1299149633-699-4-git-send-email-tom.leiming@gmail.com>
	<3734c031c0714f7f6bea072bb8b75a02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48081 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab1CGJye convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 04:54:34 -0500
Received: by qyg14 with SMTP id 14so3600314qyg.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 01:54:34 -0800 (PST)
In-Reply-To: <3734c031c0714f7f6bea072bb8b75a02@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tom.leiming@gmail.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Mar 4, 2011 at 7:16 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: tom.leiming@gmail.com [mailto:tom.leiming@gmail.com]
>> Sent: Thursday, March 03, 2011 4:24 PM
>> To: linux@arm.linux.org.uk
>> Cc: linux-arm-kernel@lists.infradead.org; will.deacon@arm.com; Ming
>> Lei; Santosh Shilimkar; Woodruff Richard; Tony Lindgren; linux-
>> omap@vger.kernel.org
>> Subject: [patch v3 3/3] arm: omap4: support pmu
>>
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> This patch supports pmu irq routed from CTI, so
>> make pmu/perf working on OMAP4.
>>
>> The idea is from Woodruff Richard in the disscussion
>> about "Oprofile on Pandaboard / Omap4" on
>> pandaboard@googlegroups.com.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Woodruff Richard <r-woodruff2@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: linux-omap@vger.kernel.org
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
> Looks good.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Great!

Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

>
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 82
>> +++++++++++++++++++++++++++-
>> =A0arch/arm/plat-omap/include/plat/omap44xx.h | =A0 =A02 +
>> =A02 files changed, 81 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
>> omap2/devices.c
>> index d216976..d97bb5a 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -22,6 +22,7 @@
>> =A0#include <asm/mach-types.h>
>> =A0#include <asm/mach/map.h>
>> =A0#include <asm/pmu.h>
>> +#include <asm/cti.h>
>>
>> =A0#include <plat/tc.h>
>> =A0#include <plat/board.h>
>> @@ -322,20 +323,95 @@ static struct resource omap3_pmu_resource =3D =
{
>> =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
>> =A0};
>>
>> +static struct resource omap4_pmu_resource[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D OMAP44XX_IRQ_CTI0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D OMAP44XX_IRQ_CTI0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D OMAP44XX_IRQ_CTI1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D OMAP44XX_IRQ_CTI1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
>> + =A0 =A0 }
>> +};
>> +
>> =A0static struct platform_device omap_pmu_device =3D {
>> =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "arm-pmu",
>> =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D ARM_PMU_DEVICE_CPU,
>> =A0 =A0 =A0 .num_resources =A0=3D 1,
>> =A0};
>>
>> +static struct arm_pmu_platdata omap4_pmu_data;
>> +static struct cti omap4_cti[2];
>> +
>> +static void omap4_enable_cti(int irq)
>> +{
>> + =A0 =A0 if (irq =3D=3D OMAP44XX_IRQ_CTI0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cti_enable(&omap4_cti[0]);
>> + =A0 =A0 else if (irq =3D=3D OMAP44XX_IRQ_CTI1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cti_enable(&omap4_cti[1]);
>> +}
>> +
>> +static void omap4_disable_cti(int irq)
>> +{
>> + =A0 =A0 if (irq =3D=3D OMAP44XX_IRQ_CTI0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cti_disable(&omap4_cti[0]);
>> + =A0 =A0 else if (irq =3D=3D OMAP44XX_IRQ_CTI1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cti_disable(&omap4_cti[1]);
>> +}
>> +
>> +static irqreturn_t omap4_pmu_handler(int irq, void *dev,
>> irq_handler_t handler)
>> +{
>> + =A0 =A0 if (irq =3D=3D OMAP44XX_IRQ_CTI0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cti_irq_ack(&omap4_cti[0]);
>> + =A0 =A0 else if (irq =3D=3D OMAP44XX_IRQ_CTI1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cti_irq_ack(&omap4_cti[1]);
>> +
>> + =A0 =A0 return handler(irq, dev);
>> +}
>> +
>> +static void omap4_configure_pmu_irq(void)
>> +{
>> + =A0 =A0 void __iomem *base0;
>> + =A0 =A0 void __iomem *base1;
>> +
>> + =A0 =A0 base0 =3D ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
>> + =A0 =A0 base1 =3D ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
>> + =A0 =A0 if (!base0 && !base1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("ioremap for OMAP4 CTI failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*configure CTI0 for pmu irq routing*/
>> + =A0 =A0 cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
>> + =A0 =A0 cti_unlock(&omap4_cti[0]);
>> + =A0 =A0 cti_map_trigger(&omap4_cti[0], 1, 6, 2);
>> +
>> + =A0 =A0 /*configure CTI1 for pmu irq routing*/
>> + =A0 =A0 cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
>> + =A0 =A0 cti_unlock(&omap4_cti[1]);
>> + =A0 =A0 cti_map_trigger(&omap4_cti[1], 1, 6, 2);
>> +
>> + =A0 =A0 omap4_pmu_data.handle_irq =3D omap4_pmu_handler;
>> + =A0 =A0 omap4_pmu_data.enable_irq =3D omap4_enable_cti;
>> + =A0 =A0 omap4_pmu_data.disable_irq =3D omap4_disable_cti;
>> +}
>> +
>> =A0static void omap_init_pmu(void)
>> =A0{
>> - =A0 =A0 if (cpu_is_omap24xx())
>> + =A0 =A0 if (cpu_is_omap24xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_pmu_device.resource =3D &omap2_pmu_=
resource;
>> - =A0 =A0 else if (cpu_is_omap34xx())
>> + =A0 =A0 } else if (cpu_is_omap34xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_pmu_device.resource =3D &omap3_pmu_=
resource;
>> - =A0 =A0 else
>> + =A0 =A0 } else if (cpu_is_omap44xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_pmu_device.resource =3D omap4_pmu_res=
ource;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_pmu_device.num_resources =3D 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_pmu_device.dev.platform_data =3D &oma=
p4_pmu_data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_configure_pmu_irq();
>> + =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 platform_device_register(&omap_pmu_device);
>> =A0}
>> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h
>> b/arch/arm/plat-omap/include/plat/omap44xx.h
>> index ea2b8a6..b127a16 100644
>> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
>> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
>> @@ -57,5 +57,7 @@
>> =A0#define OMAP44XX_HSUSB_OHCI_BASE =A0 =A0 (L4_44XX_BASE + 0x64800)
>> =A0#define OMAP44XX_HSUSB_EHCI_BASE =A0 =A0 (L4_44XX_BASE + 0x64C00)
>>
>> +#define OMAP44XX_CTI0_BASE =A0 =A0 =A0 =A0 =A0 0x54148000
>> +#define OMAP44XX_CTI1_BASE =A0 =A0 =A0 =A0 =A0 0x54149000
>> =A0#endif /* __ASM_ARCH_OMAP44XX_H */
>>
>> --
>> 1.7.3
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
