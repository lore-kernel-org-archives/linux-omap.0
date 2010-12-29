From: "Lambert, David" <dlambert@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Tue, 28 Dec 2010 19:13:58 -0600
Message-ID: <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com> <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60253 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752731Ab0L2BOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 20:14:20 -0500
Received: by gyb11 with SMTP id 11so3949605gyb.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Dec 2010 17:14:19 -0800 (PST)
In-Reply-To: <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Dec 28, 2010 at 5:14 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Dec 27, 2010 at 10:17:02PM -0600, David Lambert wrote:
>>
>> This patch adds support for the OMAP4 digital microphone DAI.
>>
>> This DAI can support support recording in 2, 4, or 6 channels
>>
>> When provided with a 19.2Mhz functional clock, can encode at 96Khz o=
r
>> 192Khz (all
>> channels must have the same sample rate).
>>
>> Details of the hardware interface can be found in the OMAP4 TRM in S=
ection
>> 23.7
>>
>> Signed-off-by: David Lambert <dlambert@ti.com>
>> ---
>> arch/arm/plat-omap/include/plat/dmic.h | =A0 83 +++++
>> sound/soc/omap/omap-dmic.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0596
>> ++++++++++++++++++++++++++++++++
>> sound/soc/omap/omap-dmic.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 38 ++
>> 3 files changed, 717 insertions(+), 0 deletions(-)
>> create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
>> create mode 100644 sound/soc/omap/omap-dmic.c
>> create mode 100644 sound/soc/omap/omap-dmic.h
>>
>> diff --git a/arch/arm/plat-omap/include/plat/dmic.h
>> b/arch/arm/plat-omap/include/plat/dmic.h
>> new file mode 100644
>> index 0000000..8a988bf
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/dmic.h
>> @@ -0,0 +1,83 @@
>> +/*
>> + * omap-dmic.h =A0-- =A0OMAP Digital Microphone Controller
>> + *
>> + * Author: Liam Girdwood <lrg@slimlogic.co.uk>
>> + * =A0 =A0 =A0 =A0David Lambert <dlambert@ti.com>
>> + * =A0 =A0 =A0 =A0Misael Lopez Cruz <misael.lopez@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __ASM_ARCH_OMAP_DMIC_H
>> +#define __ASM_ARCH_OMAP_DMIC_H
>> +
>> +#define OMAP44XX_DMIC_L3_BASE =A00x4902e000
>> +
>> +#define OMAP_DMIC_REVISION =A0 =A0 =A0 =A0 =A0 =A0 0x00
>> +#define OMAP_DMIC_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A00x10
>> +#define OMAP_DMIC_IRQSTATUS_RAW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x24
>> +#define OMAP_DMIC_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A00x28
>> +#define OMAP_DMIC_IRQENABLE_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2C
>> +#define OMAP_DMIC_IRQENABLE_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x30
>> +#define OMAP_DMIC_IRQWAKE_EN =A0 =A0 =A0 =A0 =A0 0x34
>> +#define OMAP_DMIC_DMAENABLE_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x38
>> +#define OMAP_DMIC_DMAENABLE_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3C
>> +#define OMAP_DMIC_DMAWAKEEN =A0 =A0 =A0 =A0 =A0 =A00x40
>> +#define OMAP_DMIC_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x44
>> +#define OMAP_DMIC_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x48
>> +#define OMAP_DMIC_FIFO_CTRL =A0 =A0 =A0 =A0 =A0 =A00x4C
>> +#define OMAP_DMIC_FIFO_DMIC1R_DATA =A0 =A0 0x50
>> +#define OMAP_DMIC_FIFO_DMIC1L_DATA =A0 =A0 0x54
>> +#define OMAP_DMIC_FIFO_DMIC2R_DATA =A0 =A0 0x58
>> +#define OMAP_DMIC_FIFO_DMIC2L_DATA =A0 =A0 0x5C
>> +#define OMAP_DMIC_FIFO_DMIC3R_DATA =A0 =A0 0x60
>> +#define OMAP_DMIC_FIFO_DMIC3L_DATA =A0 =A0 0x64
>> +
>> +/*
>> + * DMIC_IRQ bit fields
>> + * IRQSTATUS_RAW, IRQSTATUS, IRQENABLE_SET, IRQENABLE_CLR
>> + */
>> +
>> +#define OMAP_DMIC_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +#define OMAP_DMIC_IRQ_FULL =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
>> +#define OMAP_DMIC_IRQ_ALMST_EMPTY =A0 =A0 =A0(1 << 2)
>> +#define OMAP_DMIC_IRQ_EMPTY =A0 =A0 =A0 =A0 =A0 =A0(1 << 3)
>> +#define OMAP_DMIC_IRQ_MASK =A0 =A0 =A0 =A0 =A0 =A0 0x07
>> +
>> +/*
>> + * DMIC_DMAENABLE bit fields
>> + */
>> +
>> +#define OMAP_DMIC_DMA_ENABLE =A0 =A0 =A0 =A0 =A0 0x1
>> +
>> +/*
>> + * DMIC_CTRL bit fields
>> + */
>> +
>> +#define OMAP_DMIC_UP1_ENABLE =A0 =A0 =A0 =A0 =A0 0x0001
>> +#define OMAP_DMIC_UP2_ENABLE =A0 =A0 =A0 =A0 =A0 0x0002
>> +#define OMAP_DMIC_UP3_ENABLE =A0 =A0 =A0 =A0 =A0 0x0004
>> +#define OMAP_DMIC_FORMAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0008
>> +#define OMAP_DMIC_POLAR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0010
>> +#define OMAP_DMIC_POLAR2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0020
>> +#define OMAP_DMIC_POLAR3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0040
>> +#define OMAP_DMIC_POLAR_MASK =A0 =A0 =A0 =A0 =A0 0x0070
>> +#define OMAP_DMIC_CLK_DIV_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A07
>> +#define OMAP_DMIC_CLK_DIV_MASK =A0 =A0 =A0 =A0 0x0380
>> +#define =A0 =A0 =A0 =A0OMAP_DMIC_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0x0400
>> +
>> +#define OMAP_DMIC_ENABLE_MASK =A0 =A0 =A0 =A0 =A00x007
>> +
>> +#define OMAP_DMICOUTFORMAT_LJUST =A0 =A0 =A0 (0 << 3)
>> +#define OMAP_DMICOUTFORMAT_RJUST =A0 =A0 =A0 (1 << 3)
>> +
>> +/*
>> + * DMIC_FIFO_CTRL bit fields
>> + */
>> +
>> +#define OMAP_DMIC_THRES_MAX =A0 =A0 =A0 =A0 =A0 =A00xF
>> +
>> +
>
> one blank line only. BTW, are these used anywwhere outside the dmic.c
> driver ? If not, it's better to move the definitions there.
>

They were originally in the omap-dmic.h header, but it was suggested
that we move
them to a platform header so that the driver could be more
architecture independent
and we could put the platform specific details here.  I'm OK putting
them just about
anywhere, as long as we have consensus.

>> +#endif
>> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
>> new file mode 100644
>> index 0000000..6ba05bd
>> --- /dev/null
>> +++ b/sound/soc/omap/omap-dmic.c
>> @@ -0,0 +1,596 @@
>> +/*
>> + * omap-dmic.c =A0-- =A0OMAP ASoC DMIC DAI driver
>> + *
>> + * Copyright (C) 2010 Texas Instruments
>> + *
>> + * Author: Liam Girdwood <lrg@slimlogic.co.uk>
>> + * =A0 =A0 =A0 =A0David Lambert <dlambert@ti.com>
>> + * =A0 =A0 =A0 =A0Misael Lopez Cruz <misael.lopez@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#undef DEBUG
>> +
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/wait.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/err.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/slab.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include <plat/control.h>
>> +#include <plat/dma.h>
>> +#include <plat/dmic.h>
>> +#include <plat/omap_hwmod.h>
>
> I'm not sure drivers should be including these (besides dmic.h which =
you
> added). plat/control.h doesn't even exist anymore and hwmod is suppos=
ed
> to live under mach-omap*/ only.
>
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/initval.h>
>> +#include <sound/soc.h>
>> +
>> +#include "omap-dmic.h"
>> +#include "omap-pcm.h"
>
> These little guys here look rather small to deserve being split to
> separate files. Also, it looks like they're only used by this driver
> (??) so it's better to move the definitions to this C source file
> instead.

Agreed, see comment above about the location of the macros for the
registers.  If we agree it belongs in the platform header,  we can coll=
apse
the content of omap-dmic.h in to the C source file.  If we don't think =
they
belong in a platform header, they can come back here and then it won't
be quite so little.

>
>> +static struct omap_dmic_link omap_dmic_link =3D {
>
> const ?
>
>> + =A0 =A0 =A0 .irq_mask =A0 =A0 =A0 =3D OMAP_DMIC_IRQ_EMPTY | OMAP_D=
MIC_IRQ_FULL,
>> + =A0 =A0 =A0 .threshold =A0 =A0 =A0=3D 2,
>> + =A0 =A0 =A0 .format =A0 =A0 =A0 =A0 =3D OMAP_DMICOUTFORMAT_LJUST,
>> + =A0 =A0 =A0 .polar =A0 =A0 =A0 =A0 =A0=3D OMAP_DMIC_POLAR1 | OMAP_=
DMIC_POLAR2
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP=
_DMIC_POLAR3,
>> +};
>> +
>> +/*
>> + * Stream DMA parameters
>> + */
>> +static struct omap_pcm_dma_data omap_dmic_dai_dma_params =3D {
>
> const ?
>
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "DMIC capture",
>> + =A0 =A0 =A0 .data_type =A0 =A0 =A0=3D OMAP_DMA_DATA_TYPE_S32,
>> + =A0 =A0 =A0 .sync_mode =A0 =A0 =A0=3D OMAP_DMA_SYNC_PACKET,
>> + =A0 =A0 =A0 .packet_size =A0 =A0=3D 2,
>> + =A0 =A0 =A0 .port_addr =A0 =A0 =A0=3D OMAP44XX_DMIC_L3_BASE + OMAP=
_DMIC_DATA,
>> +};
>> +
>> +
>
> one blank line only.
>
>> +#ifdef DEBUG
>> +static void omap_dmic_reg_dump(struct omap_dmic *dmic)
>> +{
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "***********************\n");
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQSTATUS_RAW: =A00x%04x=
\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQSTAT=
US_RAW));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQSTATUS: =A00x%04x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQSTAT=
US));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQENABLE_SET: =A00x%04x=
\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQENAB=
LE_SET));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQENABLE_CLR: =A00x%04x=
\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQENAB=
LE_CLR));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQWAKE_EN: =A00x%04x\n"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQWAKE=
_EN));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DMAENABLE_SET: =A00x%04x=
\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DMAENAB=
LE_SET));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DMAENABLE_CLR: =A00x%04x=
\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DMAENAB=
LE_CLR));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DMAWAKEEN: =A00x%04x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DMAWAKE=
EN));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_CTRL: =A00x%04x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_CTRL));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DATA: =A00x%04x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DATA));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_CTRL: =A00x%04x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_CT=
RL));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC1R_DATA: =A00x%=
08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_DM=
IC1R_DATA));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC1L_DATA: =A00x%=
08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_DM=
IC1L_DATA));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC2R_DATA: =A00x%=
08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_DM=
IC2R_DATA));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC2L_DATA: =A00x%=
08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_DM=
IC2L_DATA));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC3R_DATA: =A00x%=
08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_DM=
IC3R_DATA));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC3L_DATA: =A00x%=
08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_DM=
IC3L_DATA));
>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "***********************\n");
>> +}
>> +#else
>> +static void omap_dmic_reg_dump(struct omap_dmic *dmic) {}
>> +#endif
>
> Would be better to make a debugfs layer ??

I'll look in to what it would take to do this.  Could this be a
feature to add later?

>
>> +static irqreturn_t omap_dmic_irq_handler(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 struct omap_dmic *dmic =3D dev_id;
>> + =A0 =A0 =A0 u32 irq_status;
>> +
>> + =A0 =A0 =A0 irq_status =3D omap_dmic_read(dmic, OMAP_DMIC_IRQSTATU=
S);
>> +
>> + =A0 =A0 =A0 /* Acknowledge irq event */
>> + =A0 =A0 =A0 omap_dmic_write(dmic, OMAP_DMIC_IRQSTATUS, irq_status)=
;
>> + =A0 =A0 =A0 if (irq_status & OMAP_DMIC_IRQ_FULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC FIFO error %x=
\n", irq_status);
>> +
>> + =A0 =A0 =A0 if (irq_status & OMAP_DMIC_IRQ_EMPTY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC FIFO error %x=
\n", irq_status);
>> +
>> + =A0 =A0 =A0 if (irq_status & OMAP_DMIC_IRQ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC write request=
\n");
>
> no locking needed ??
>
>> +static int omap_dmic_dai_startup(struct snd_pcm_substream *substrea=
m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct snd_soc_dai *dai)
>> +{
>> + =A0 =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai=
);
>> +
>> + =A0 =A0 =A0 if (!dmic->active++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(dmic->dev);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substr=
eam,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct snd_soc_dai *dai)
>> +{
>> + =A0 =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai=
);
>> +
>> + =A0 =A0 =A0 if (!--dmic->active)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(dmic->dev);
>
> I could be wrong but I believe pm_runtime implementation on OMAP has
> its own refcounting, so you could drop the need for dmic->active.

This was a included for a future use case where the driver would be
accessed by the
Audio Back End.  In this case, there are multiple DAI's associated to
this driver and
we need to keep track of the number of active DAI's and only cal
pm_runtime_put_sync()
when there are no others running.

>
>> +static struct snd_soc_dai_ops omap_dmic_dai_ops =3D {
>
> should this be const ?
>
>> +static struct snd_soc_dai_driver omap_dmic_dai =3D {
>
> this too ??
>
>> +static __devinit int asoc_dmic_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct omap_dmic *dmic;
>> + =A0 =A0 =A0 struct resource *res;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 dmic =3D kzalloc(sizeof(struct omap_dmic), GFP_KERNEL)=
;
>> + =A0 =A0 =A0 if (!dmic)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, dmic);
>> + =A0 =A0 =A0 dmic->dev =3D &pdev->dev;
>> + =A0 =A0 =A0 dmic->link =3D &omap_dmic_link;
>> + =A0 =A0 =A0 dmic->sysclk =3D OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS;
>> +
>> + =A0 =A0 =A0 spin_lock_init(&dmic->lock);
>> +
>> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
>> + =A0 =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dmic->dev, "invalid memory res=
ource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 dmic->io_base =3D ioremap(res->start, resource_size(re=
s));
>> + =A0 =A0 =A0 if (!dmic->io_base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 dmic->irq =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 =A0 if (dmic->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dmic->irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0)=
;
>> + =A0 =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dmic->dev, "invalid dma resour=
ce\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 omap_dmic_dai_dma_params.dma_req =3D res->start;
>> +
>> + =A0 =A0 =A0 pm_runtime_enable(dmic->dev);
>> +
>> + =A0 =A0 =A0 /* Disable lines while request is ongoing */
>> + =A0 =A0 =A0 omap_dmic_write(dmic, OMAP_DMIC_CTRL, 0x00);
>> +
>> + =A0 =A0 =A0 ret =3D request_threaded_irq(dmic->irq, NULL, omap_dmi=
c_irq_handler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
IRQF_ONESHOT, "DMIC", (void *)dmic);
>
> Does this need to be threaded ? Doesn't look like. Also, you don't ne=
ed
> the (void *) cast.

This was originally not a threaded IRQ handler.  But in an internal
review, it was
suggested that this was the current trend in drivers and I should
follow that course.
I'm open to having it non-threaded.

>
>> +static int __devexit asoc_dmic_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct omap_dmic *dmic =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 =A0 snd_soc_unregister_dai(&pdev->dev);
>> + =A0 =A0 =A0 free_irq(dmic->irq, dmic);
>> + =A0 =A0 =A0 iounmap(dmic->io_base);
>> + =A0 =A0 =A0 kfree(dmic);
>
> pm_runtime_disable() ??
>
> --
> balbi
>

--
David Lambert
OMAP=99 Multimedia
214-567-5692
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
