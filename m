From: David Brownell <david-b@pacbell.net>
Subject: Re: ALSA sound on beagleboard
Date: Tue, 21 Oct 2008 22:15:27 -0700
Message-ID: <200810212215.27517.david-b@pacbell.net>
References: <E1KsVml-0007JI-Eq@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:31670 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752062AbYJVFPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 01:15:30 -0400
In-Reply-To: <E1KsVml-0007JI-Eq@amazonia.comcast.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: linux-omap@vger.kernel.org

On Tuesday 21 October 2008, you wrote:
> =A0 Please give me a clue on where to start.

This patch came on linux-omap a while back.  I'm not sure
why it isn't merged yet.  The clock framework crapped out
on me because of a lockdep problem ... maybe it'll work OK
if you don't enable lockdep.

- Dave



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] alsa: add Beagleboard SoC configuration.

This is exactly the same as the overo configuration. It might make sens=
e
to have them in a single one.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

# CHANGED to not spew messages about beagle on non-beagle boards

---
This was suggested by Koen Kooi.

 sound/soc/omap/Kconfig       |    8 ++
 sound/soc/omap/Makefile      |    2=20
 sound/soc/omap/omap3beagle.c |  149 ++++++++++++++++++++++++++++++++++=
+++++++
 3 files changed, 159 insertions(+)
 create mode 100644 sound/soc/omap/omap3beagle.c

--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -22,3 +22,11 @@ config SND_OMAP_SOC_OVERO
 	help
 	  Say Y if you want to add support for SoC audio on the Gumstix Overo=
=2E
=20
+config SND_OMAP_SOC_OMAP3_BEAGLE
+	tristate "SoC Audio support for OMAP3 Beagle"
+	depends on SND_OMAP_SOC && MACH_OMAP3_BEAGLE
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Beagleboard.
+
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -8,7 +8,9 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) +=3D snd-
 # OMAP Machine Support
 snd-soc-n810-objs :=3D n810.o
 snd-soc-overo-objs :=3D overo.o
+snd-soc-omap3beagle-objs :=3D omap3beagle.o
=20
 obj-$(CONFIG_SND_OMAP_SOC_N810) +=3D snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) +=3D snd-soc-overo.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) +=3D snd-soc-omap3beagle.o
=20
--- /dev/null
+++ b/sound/soc/omap/omap3beagle.c
@@ -0,0 +1,149 @@
+/*
+ * omap3beagle.c  --  SoC audio for OMAP3 Beagle
+ *
+ * Author: Steve Sakoman <steve@sakoman.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+static int omap3beagle_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap3beagle_ops =3D {
+	.hw_params =3D omap3beagle_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap3beagle_dai =3D {
+	.name =3D "TWL4030",
+	.stream_name =3D "TWL4030",
+	.cpu_dai =3D &omap_mcbsp_dai[0],
+	.codec_dai =3D &twl4030_dai,
+	.ops =3D &omap3beagle_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_omap3beagle =3D {
+	.name =3D "omap3beagle",
+	.dai_link =3D &omap3beagle_dai,
+	.num_links =3D 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3beagle_snd_devdata =3D {
+	.machine =3D &snd_soc_machine_omap3beagle,
+	.platform =3D &omap_soc_platform,
+	.codec_dev =3D &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap3beagle_snd_device;
+
+static int __init omap3beagle_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap3_beagle()) {
+		pr_debug("Not OMAP3 Beagle!\n");
+		return -ENODEV;
+	}
+	pr_info("OMAP3 Beagle SoC init\n");
+
+	omap3beagle_snd_device =3D platform_device_alloc("soc-audio", -1);
+	if (!omap3beagle_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap3beagle_snd_device, &omap3beagle_snd_devdata=
);
+	omap3beagle_snd_devdata.dev =3D &omap3beagle_snd_device->dev;
+	*(unsigned int *)omap3beagle_dai.cpu_dai->private_data =3D 1; /* McBS=
P2 */
+
+	ret =3D platform_device_add(omap3beagle_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(omap3beagle_snd_device);
+
+	return ret;
+}
+
+static void __exit omap3beagle_soc_exit(void)
+{
+	platform_device_unregister(omap3beagle_snd_device);
+}
+
+module_init(omap3beagle_soc_init);
+module_exit(omap3beagle_soc_exit);
+
+MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP3 Beagle");
+MODULE_LICENSE("GPL");

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
