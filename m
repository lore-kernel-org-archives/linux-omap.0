From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 4/4] Add ASoC support for DEVKIT8000
Date: Thu, 12 Nov 2009 16:24:21 +0530
Message-ID: <ce9ab5790911120254l13a51b45n59270331be1264a7@mail.gmail.com>
References: <8e4f2cbd8c0fccce7759ee7545699e1d@djdvant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:65191 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbZKLKyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 05:54:37 -0500
In-Reply-To: <8e4f2cbd8c0fccce7759ee7545699e1d@djdvant.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Botherway <kbotherway@djdvant.com>
Cc: alsa-devel@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Nov 12, 2009 at 3:54 PM, Kim Botherway <kbotherway@djdvant.com>=
 wrote:
> This patch add support for DEVKIT8000, it is a copy of Beagleboard so=
und
> driver
>
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 653a362..8cdcfe9 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -91,6 +91,14 @@ config SND_OMAP_SOC_OMAP3_BEAGLE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y if you want to add support for SoC audio on =
the Beagleboard.
>
> +config SND_OMAP_SOC_OMAP3_DEVKIT8000
> + =A0 =A0 =A0 =A0tristate "SoC Audio support for OMAP3 DEVKIT8000"
> + =A0 =A0 =A0 =A0depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP=
3_DEVKIT8000
> + =A0 =A0 =A0 =A0select SND_OMAP_SOC_MCBSP
> + =A0 =A0 =A0 =A0select SND_SOC_TWL4030
> + =A0 =A0 =A0 =A0help
> + =A0 =A0 =A0 =A0 =A0Say Y if you want to add support for SoC audio o=
n the
> DEVKIT8000.

Patch is corrupted due to line-wrapping.

> +
> =A0config SND_OMAP_SOC_ZOOM2
> =A0 =A0 =A0 =A0tristate "SoC Audio support for Zoom2"
> =A0 =A0 =A0 =A0depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_Z=
OOM2
>
> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> index 02d6947..7239737 100644
> --- a/sound/soc/omap/Makefile
> +++ b/sound/soc/omap/Makefile
> @@ -15,6 +15,7 @@ snd-soc-omap3evm-objs :=3D omap3evm.o
> =A0snd-soc-sdp3430-objs :=3D sdp3430.o
> =A0snd-soc-omap3pandora-objs :=3D omap3pandora.o
> =A0snd-soc-omap3beagle-objs :=3D omap3beagle.o
> +snd-soc-omap3devkit8000-objs :=3D omap3devkit8000.o
> =A0snd-soc-zoom2-objs :=3D zoom2.o
>
> =A0obj-$(CONFIG_SND_OMAP_SOC_N810) +=3D snd-soc-n810.o
> @@ -26,4 +27,5 @@ obj-$(CONFIG_MACH_OMAP3EVM) +=3D snd-soc-omap3evm.o
> =A0obj-$(CONFIG_SND_OMAP_SOC_SDP3430) +=3D snd-soc-sdp3430.o
> =A0obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) +=3D snd-soc-omap3pandora=
=2Eo
> =A0obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) +=3D snd-soc-omap3beagle.o
> +obj-$(CONFIG_SND_OMAP_SOC_OMAP3_DEVKIT8000) +=3D snd-soc-omap3devkit=
8000.o
> =A0obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) +=3D snd-soc-zoom2.o
>
> diff --git a/sound/soc/omap/omap3devkit8000.c
> b/sound/soc/omap/omap3devkit8000.c
> new file mode 100644
> index 0000000..6a975d4
> --- /dev/null
> +++ b/sound/soc/omap/omap3devkit8000.c
> @@ -0,0 +1,154 @@
> +/*
> + * omap3devkit8000.c =A0-- =A0SoC audio for OMAP3 Beagle
> + *
> + * Author: Steve Sakoman <steve@sakoman.com>
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
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include <asm/mach-types.h>
> +#include <plat/hardware.h>
> +#include <plat/gpio.h>
> +#include <plat/mcbsp.h>
> +
> +#include "omap-mcbsp.h"
> +#include "omap-pcm.h"
> +#include "../codecs/twl4030.h"
> +
> +static int omap3devkit8000_hw_params(struct snd_pcm_substream *subst=
ream,
> + =A0 =A0 =A0 struct snd_pcm_hw_params *params)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_=
data;
> + =A0 =A0 =A0 struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
> + =A0 =A0 =A0 struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
> + =A0 =A0 =A0 unsigned int fmt;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 switch (params_channels(params)) {
> + =A0 =A0 =A0 case 2: /* Stereo I2S mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt =3D =A0 SND_SOC_DAIFMT_I2S |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_NB_NF |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_CBM_CFM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 4: /* Four channel TDM mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt =3D =A0 SND_SOC_DAIFMT_DSP_A |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_IB_NF |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_CBM_CFM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set codec DAI configuration */
> + =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, fmt);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't set codec DAI co=
nfiguration\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set cpu DAI configuration */
> + =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(cpu_dai, fmt);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't set cpu DAI conf=
iguration\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set the codec system clock for DAC and ADC */
> + =A0 =A0 =A0 ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SND_SOC_CLOCK_IN);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't set codec system=
 clock\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct snd_soc_ops omap3devkit8000_ops =3D {
> + =A0 =A0 =A0 .hw_params =3D omap3devkit8000_hw_params,
> +};
> +
> +/* Digital audio interface glue - connects codec <--> CPU */
> +static struct snd_soc_dai_link omap3devkit8000_dai =3D {
> + =A0 =A0 =A0 .name =3D "TWL4030",
> + =A0 =A0 =A0 .stream_name =3D "TWL4030",
> + =A0 =A0 =A0 .cpu_dai =3D &omap_mcbsp_dai[0],
> + =A0 =A0 =A0 .codec_dai =3D &twl4030_dai[TWL4030_DAI_HIFI],
> + =A0 =A0 =A0 .ops =3D &omap3devkit8000_ops,
> +};
> +
> +/* Audio machine driver */
> +static struct snd_soc_card snd_soc_omap3devkit8000 =3D {
> + =A0 =A0 =A0 .name =3D "omap3devkit8000",
> + =A0 =A0 =A0 .platform =3D &omap_soc_platform,
> + =A0 =A0 =A0 .dai_link =3D &omap3devkit8000_dai,
> + =A0 =A0 =A0 .num_links =3D 1,
> +};
> +
> +/* Audio subsystem */
> +static struct snd_soc_device omap3devkit8000_snd_devdata =3D {
> + =A0 =A0 =A0 .card =3D &snd_soc_omap3devkit8000,
> + =A0 =A0 =A0 .codec_dev =3D &soc_codec_dev_twl4030,
> +};
> +
> +static struct platform_device *omap3devkit8000_snd_device;
> +
> +static int __init omap3devkit8000_soc_init(void)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 pr_info("OMAP3 omap3devkit8000 SoC init\n");
> +
> + =A0 =A0 =A0 omap3devkit8000_snd_device =3D platform_device_alloc("s=
oc-audio", -1);
> + =A0 =A0 =A0 if (!omap3devkit8000_snd_device) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Platform device alloca=
tion failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(omap3devkit8000_snd_device,
> &omap3devkit8000_snd_devdata);

ditto

> + =A0 =A0 =A0 omap3devkit8000_snd_devdata.dev =3D &omap3devkit8000_sn=
d_device->dev;
> + =A0 =A0 =A0 *(unsigned int *)omap3devkit8000_dai.cpu_dai->private_d=
ata =3D 1; /* McBSP2
> */

ditto

> +
> + =A0 =A0 =A0 ret =3D platform_device_add(omap3devkit8000_snd_device)=
;
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> +
> + =A0 =A0 =A0 return 0;
> +
> +err1:
> + =A0 =A0 =A0 printk(KERN_ERR "Unable to add platform device\n");
> + =A0 =A0 =A0 platform_device_put(omap3devkit8000_snd_device);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static void __exit omap3devkit8000_soc_exit(void)
> +{
> + =A0 =A0 =A0 platform_device_unregister(omap3devkit8000_snd_device);
> +}
> +
> +module_init(omap3devkit8000_soc_init);
> +module_exit(omap3devkit8000_soc_exit);
> +
> +MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
> +MODULE_DESCRIPTION("ALSA SoC OMAP3 DEVKIT8000");
> +MODULE_LICENSE("GPL");
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
