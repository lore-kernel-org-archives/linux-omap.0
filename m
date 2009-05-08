From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 1/1] ASoC: Added OMAP3 EVM support in ASoC.
Date: Fri, 8 May 2009 14:38:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305600DA5@dbde02.ent.ti.com>
References: <1241712527-16269-1-git-send-email-anuj.aggarwal@ti.com>
 <dfeb90390905072142h760e79afmf2d2de0d45646165@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46346 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbZEHJIZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 05:08:25 -0400
In-Reply-To: <dfeb90390905072142h760e79afmf2d2de0d45646165@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Arun KS [mailto:getarunks@gmail.com]
> Sent: Friday, May 08, 2009 10:13 AM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/1] ASoC: Added OMAP3 EVM support in ASoC.
>=20
> On Thu, May 7, 2009 at 9:38 PM, Anuj Aggarwal <anuj.aggarwal@ti.com>
> wrote:
> >
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > ---
> > =A0sound/soc/omap/Kconfig =A0 =A0| =A0 =A08 +++
> > =A0sound/soc/omap/Makefile =A0 | =A0 =A02 +
> > =A0sound/soc/omap/omap3evm.c | =A0147
> +++++++++++++++++++++++++++++++++++++++++++++
> > =A03 files changed, 157 insertions(+), 0 deletions(-)
> > =A0create mode 100644 sound/soc/omap/omap3evm.c
> >
> > diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> > index 675732e..b771238 100644
> > --- a/sound/soc/omap/Kconfig
> > +++ b/sound/soc/omap/Kconfig
> > @@ -39,6 +39,14 @@ config SND_OMAP_SOC_OMAP2EVM
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0Say Y if you want to add support for SoC audio o=
n the omap2evm
> board.
> >
> > +config SND_OMAP_SOC_OMAP3EVM
> > + =A0 =A0 =A0 tristate "SoC Audio support for OMAP3EVM board"
> > + =A0 =A0 =A0 depends on TWL4030_CORE && SND_OMAP_SOC &&
> MACH_OMAP3EVM
> > + =A0 =A0 =A0 select SND_OMAP_SOC_MCBSP
> > + =A0 =A0 =A0 select SND_SOC_TWL4030
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Say Y if you want to add support for SoC audio on=
 the omap3evm
> board.
> > +
> > =A0config SND_OMAP_SOC_SDP3430
> > =A0 =A0 =A0 =A0tristate "SoC Audio support for Texas Instruments SD=
P3430"
> > =A0 =A0 =A0 =A0depends on TWL4030_CORE && SND_OMAP_SOC &&
> MACH_OMAP_3430SDP
> > diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> > index 0c9e4ac..a37f498 100644
> > --- a/sound/soc/omap/Makefile
> > +++ b/sound/soc/omap/Makefile
> > @@ -10,6 +10,7 @@ snd-soc-n810-objs :=3D n810.o
> > =A0snd-soc-osk5912-objs :=3D osk5912.o
> > =A0snd-soc-overo-objs :=3D overo.o
> > =A0snd-soc-omap2evm-objs :=3D omap2evm.o
> > +snd-soc-omap3evm-objs :=3D omap3evm.o
> > =A0snd-soc-sdp3430-objs :=3D sdp3430.o
> > =A0snd-soc-omap3pandora-objs :=3D omap3pandora.o
> > =A0snd-soc-omap3beagle-objs :=3D omap3beagle.o
> > @@ -18,6 +19,7 @@ obj-$(CONFIG_SND_OMAP_SOC_N810) +=3D snd-soc-
> n810.o
> > =A0obj-$(CONFIG_SND_OMAP_SOC_OSK5912) +=3D snd-soc-osk5912.o
> > =A0obj-$(CONFIG_SND_OMAP_SOC_OVERO) +=3D snd-soc-overo.o
> > =A0obj-$(CONFIG_MACH_OMAP2EVM) +=3D snd-soc-omap2evm.o
> > +obj-$(CONFIG_MACH_OMAP3EVM) +=3D snd-soc-omap3evm.o
> > =A0obj-$(CONFIG_SND_OMAP_SOC_SDP3430) +=3D snd-soc-sdp3430.o
> > =A0obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) +=3D snd-soc-
> omap3pandora.o
> > =A0obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) +=3D snd-soc-
> omap3beagle.o
> > diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
> > new file mode 100644
> > index 0000000..2af5d93
> > --- /dev/null
> > +++ b/sound/soc/omap/omap3evm.c
> > @@ -0,0 +1,147 @@
> > +/*
> > + * omap3evm.c =A0-- ALSA SoC support for OMAP3 EVM
> > + *
> > + * Author: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > + *
> > + * Based on sound/soc/omap/beagle.c by Steve Sakoman
> > + *
> > + * Copyright (C) 2008 Texas Instruments, Incorporated
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify it
> > + * under the terms of the GNU General Public License as published =
by the
> > + * Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> kind,
> > + * whether express or implied; without even the implied warranty o=
f
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> GNU
> > + * General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/platform_device.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm.h>
> > +#include <sound/soc.h>
> > +#include <sound/soc-dapm.h>
> > +
> > +#include <asm/mach-types.h>
> > +#include <mach/hardware.h>
> > +#include <mach/gpio.h>
> > +#include <mach/mcbsp.h>
> > +
> > +#include "omap-mcbsp.h"
> > +#include "omap-pcm.h"
> > +#include "../codecs/twl4030.h"
> > +
> > +static int omap3evm_hw_params(struct snd_pcm_substream *substream,
> > + =A0 =A0 =A0 struct snd_pcm_hw_params *params)
> > +{
> > + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->privat=
e_data;
> > + =A0 =A0 =A0 struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai=
;
> > + =A0 =A0 =A0 struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 /* Set codec DAI configuration */
> > + =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S=
ND_SOC_DAIFMT_I2S |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S=
ND_SOC_DAIFMT_NB_NF |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S=
ND_SOC_DAIFMT_CBM_CFM);
> > + =A0 =A0 =A0 if (ret < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Can't set codec DAI =
configuration\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /* Set cpu DAI configuration */
> > + =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(cpu_dai,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S=
ND_SOC_DAIFMT_I2S |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S=
ND_SOC_DAIFMT_NB_NF |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S=
ND_SOC_DAIFMT_CBM_CFM);
> > + =A0 =A0 =A0 if (ret < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Can't set cpu DAI co=
nfiguration\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /* Set the codec system clock for DAC and ADC */
> > + =A0 =A0 =A0 ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000=
,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SND_SOC_CLOCK_IN);
> > + =A0 =A0 =A0 if (ret < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Can't set codec syst=
em clock\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static struct snd_soc_ops omap3evm_ops =3D {
> > + =A0 =A0 =A0 .hw_params =3D omap3evm_hw_params,
> > +};
> > +
> > +/* Digital audio interface glue - connects codec <--> CPU */
> > +static struct snd_soc_dai_link omap3evm_dai =3D {
> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "TWL4030",
> > + =A0 =A0 =A0 .stream_name =A0 =A0=3D "TWL4030",
> > + =A0 =A0 =A0 .cpu_dai =A0 =A0 =A0 =A0=3D &omap_mcbsp_dai[0],
> > + =A0 =A0 =A0 .codec_dai =A0 =A0 =A0=3D &twl4030_dai,
>=20
> Please use
> .codec_dai =3D &twl4030_dai[TWL4030_DAI_HIFI],
[Aggarwal, Anuj] I will do the modification and send the patch again.
>=20
>=20
> > + =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &omap3evm_ops,
> > +};
> > +
> > +/* Audio machine driver */
> > +static struct snd_soc_card snd_soc_omap3evm =3D {
> > + =A0 =A0 =A0 .name =3D "omap3evm",
> > + =A0 =A0 =A0 .platform =3D &omap_soc_platform,
> > + =A0 =A0 =A0 .dai_link =3D &omap3evm_dai,
> > + =A0 =A0 =A0 .num_links =3D 1,
> > +};
> > +
> > +/* Audio subsystem */
> > +static struct snd_soc_device omap3evm_snd_devdata =3D {
> > + =A0 =A0 =A0 .card =3D &snd_soc_omap3evm,
> > + =A0 =A0 =A0 .codec_dev =3D &soc_codec_dev_twl4030,
> > +};
> > +
> > +static struct platform_device *omap3evm_snd_device;
> > +
> > +static int __init omap3evm_soc_init(void)
> > +{
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 if (!machine_is_omap3evm()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("Not OMAP3 EVM!\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 pr_info("OMAP3 EVM SoC init\n");
> > +
> > + =A0 =A0 =A0 omap3evm_snd_device =3D platform_device_alloc("soc-au=
dio", -1);
> > + =A0 =A0 =A0 if (!omap3evm_snd_device) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Platform device allo=
cation failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 platform_set_drvdata(omap3evm_snd_device,
> &omap3evm_snd_devdata);
> > + =A0 =A0 =A0 omap3evm_snd_devdata.dev =3D &omap3evm_snd_device->de=
v;
> > + =A0 =A0 =A0 *(unsigned int *)omap3evm_dai.cpu_dai->private_data =3D=
 1;
> > +
> > + =A0 =A0 =A0 ret =3D platform_device_add(omap3evm_snd_device);
> > + =A0 =A0 =A0 if (ret)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> > +
> > + =A0 =A0 =A0 return 0;
> > +
> > +err1:
> > + =A0 =A0 =A0 printk(KERN_ERR "Unable to add platform device\n");
> > + =A0 =A0 =A0 platform_device_put(omap3evm_snd_device);
> > +
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static void __exit omap3evm_soc_exit(void)
> > +{
> > + =A0 =A0 =A0 platform_device_unregister(omap3evm_snd_device);
> > +}
> > +
> > +module_init(omap3evm_soc_init);
> > +module_exit(omap3evm_soc_exit);
> > +
> > +MODULE_AUTHOR("Anuj Aggarwal <anuj.aggarwal@ti.com>");
> > +MODULE_DESCRIPTION("ALSA SoC OMAP3 EVM");
> > +MODULE_LICENSE("GPLv2");
> > --
> > 1.6.2.4
> >
> >

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
