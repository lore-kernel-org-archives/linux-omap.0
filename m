From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v3 1/4] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Fri, 28 Jan 2011 13:13:15 +0530
Message-ID: <AANLkTi=7B9YVWsBcGBcpz+=YgheEFLLUGtBN2qsRMpZD@mail.gmail.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com> <1295992862-6154-2-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36443 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753379Ab1A1HoE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 02:44:04 -0500
Received: by yib2 with SMTP id 2so970723yib.36
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 23:43:56 -0800 (PST)
In-Reply-To: <1295992862-6154-2-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, Jan 26, 2011 at 03:30, David Lambert <dlambert@ti.com> wrote:
> This patch adds support for the OMAP4 digital microphone DAI.
>
> This DAI can support support recording in 2, 4, or 6 channels
>
> When provided with a 19.2Mhz functional clock, can encode at 96Khz or
> 192Khz (all channels must have the same sample rate).
>
> Details of the hardware interface can be found in the OMAP4 TRM in Se=
ction 23.7
>
> Signed-off-by: David Lambert <dlambert@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/dmic.h | =A0 82 +++++
> =A0sound/soc/omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 =
+
> =A0sound/soc/omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
+
> =A0sound/soc/omap/omap-dmic.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0534 ++++++=
++++++++++++++++++++++++++
> =A04 files changed, 621 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
> =A0create mode 100644 sound/soc/omap/omap-dmic.c
>
> diff --git a/arch/arm/plat-omap/include/plat/dmic.h b/arch/arm/plat-o=
map/include/plat/dmic.h
> new file mode 100644
> index 0000000..a72e080
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/dmic.h
> @@ -0,0 +1,82 @@
> +/*
> + * omap-dmic.h =A0-- =A0OMAP Digital Microphone Controller
> + *
> + * Author: Liam Girdwood <lrg@slimlogic.co.uk>
> + * =A0 =A0 =A0 =A0David Lambert <dlambert@ti.com>
> + * =A0 =A0 =A0 =A0Misael Lopez Cruz <misael.lopez@ti.com>

Consider adding the copyright info.

> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARCH_OMAP_DMIC_H
> +#define __ASM_ARCH_OMAP_DMIC_H
> +
> +#define OMAP44XX_DMIC_L3_BASE =A00x4902e000
> +
> +#define OMAP_DMIC_REVISION =A0 =A0 =A0 =A0 =A0 =A0 0x00
> +#define OMAP_DMIC_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A00x10

As this driver would use hwmod framework, it would be good
to avoid defining this macro in the driver. Anyway it is not
used in the driver.

> +#define OMAP_DMIC_IRQSTATUS_RAW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x24
> +#define OMAP_DMIC_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A00x28
> +#define OMAP_DMIC_IRQENABLE_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2C
> +#define OMAP_DMIC_IRQENABLE_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x30
> +#define OMAP_DMIC_IRQWAKE_EN =A0 =A0 =A0 =A0 =A0 0x34
> +#define OMAP_DMIC_DMAENABLE_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x38
> +#define OMAP_DMIC_DMAENABLE_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3C
> +#define OMAP_DMIC_DMAWAKEEN =A0 =A0 =A0 =A0 =A0 =A00x40
> +#define OMAP_DMIC_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x44
> +#define OMAP_DMIC_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x48
> +#define OMAP_DMIC_FIFO_CTRL =A0 =A0 =A0 =A0 =A0 =A00x4C
> +#define OMAP_DMIC_FIFO_DMIC1R_DATA =A0 =A0 0x50
> +#define OMAP_DMIC_FIFO_DMIC1L_DATA =A0 =A0 0x54
> +#define OMAP_DMIC_FIFO_DMIC2R_DATA =A0 =A0 0x58
> +#define OMAP_DMIC_FIFO_DMIC2L_DATA =A0 =A0 0x5C
> +#define OMAP_DMIC_FIFO_DMIC3R_DATA =A0 =A0 0x60
> +#define OMAP_DMIC_FIFO_DMIC3L_DATA =A0 =A0 0x64
> +
> +/*

<<snip>>

> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> new file mode 100644
> index 0000000..06dbb99
> --- /dev/null
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -0,0 +1,534 @@
> +/*
> + * omap-dmic.c =A0-- =A0OMAP ASoC DMIC DAI driver
> + *
> + * Copyright (C) 2010 Texas Instruments
> + *
> + * Author: Liam Girdwood <lrg@slimlogic.co.uk>
> + * =A0 =A0 =A0 =A0David Lambert <dlambert@ti.com>
> + * =A0 =A0 =A0 =A0Misael Lopez Cruz <misael.lopez@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/wait.h>
> +#include <linux/interrupt.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <plat/control.h>
> +#include <plat/dma.h>
> +#include <plat/dmic.h>
> +#include <plat/omap_hwmod.h>

The above header file is not required in the driver

> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +

<<snip>>

> +
> +static int omap_dmic_dai_trigger(struct snd_pcm_substream *substream=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int=
 cmd, struct snd_soc_dai *dai)
> +{
> + =A0 =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai)=
;
> + =A0 =A0 =A0 int dmic_id =3D dmic->link->channels;
> +
> + =A0 =A0 =A0 switch (cmd) {
> + =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_START:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_start(dmic, dmic_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_STOP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_stop(dmic, dmic_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:

You may consider adding a "command not supported" warning if it would
be meaningful.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +

<<snip>>

> +
> +static struct snd_soc_dai_driver omap_dmic_dai =3D {
> +
> + =A0 =A0 =A0 .name =3D "omap-dmic-dai-0",
> + =A0 =A0 =A0 .capture =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels_min =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels_max =3D 6,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rates =3D OMAP_DMIC_RATES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .formats =3D OMAP_DMIC_FORMATS,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .ops =3D &omap_dmic_dai_ops,
> +};
> +
> +static __devinit int asoc_dmic_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_dmic *dmic;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 dmic =3D kzalloc(sizeof(struct omap_dmic), GFP_KERNEL);
> + =A0 =A0 =A0 if (!dmic)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, dmic);
> + =A0 =A0 =A0 dmic->dev =3D &pdev->dev;
> + =A0 =A0 =A0 dmic->link =3D &omap_dmic_link;
> + =A0 =A0 =A0 dmic->sysclk =3D OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS;
> +
> + =A0 =A0 =A0 spin_lock_init(&dmic->lock);
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dmic->dev, "invalid memory reso=
urce\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dmic->io_base =3D ioremap(res->start, resource_size(res=
));
> + =A0 =A0 =A0 if (!dmic->io_base) {

Print the error.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dmic->dev, "invalid dma resourc=
e\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_dai;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 omap_dmic_dai_dma_params.dma_req =3D res->start;
> +
> + =A0 =A0 =A0 pm_runtime_enable(dmic->dev);
> +

Before accessing the below register, you should be doing a pm_runtime_g=
et*()

> + =A0 =A0 =A0 /* Disable lines while request is ongoing */
> + =A0 =A0 =A0 omap_dmic_write(dmic, OMAP_DMIC_CTRL, 0x00);
> +
> + =A0 =A0 =A0 ret =3D snd_soc_register_dais(&pdev->dev, &omap_dmic_da=
i, 1);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_dai;
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_dai:
> + =A0 =A0 =A0 iounmap(dmic->io_base);
> +err_res:
> + =A0 =A0 =A0 kfree(dmic);
> + =A0 =A0 =A0 return ret;
> +}
> +

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
