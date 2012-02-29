From: CF Adad <cfadad@rocketmail.com>
Subject: Question: Custom DAI driver for AM35xx using McBSP
Date: Tue, 28 Feb 2012 20:11:52 -0800 (PST)
Message-ID: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm3-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.133]:47661 "HELO
	nm3-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752207Ab2B2ERV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 23:17:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,
Please forgive me if I don't get this post quite right. This is my firs=
t time posting to the mailing lists.

My team is working on a driver that will be used to interface a cell mo=
dem's digital audio interface (DAI) to a McBSP port on an AM3517.=A0 Ou=
r goal is to be able to support multiple such interfaces down the road.=
=A0 For now, however, we will be satisfied just getting the one we have=
 on our demo board (McBSP2) to work 100%.

The driver should be VERY simple:=A0 The cell modem has a 4-wire DAI po=
rt that behaves much like any other PCM hook-up (CLK, FS, TX, RX), and =
we simply want that raw data pulled into userspace via ALSA for handlin=
g.=A0 The DAI on the modem has a fixed configuration:


- Clock is master, fixed at 256kHz

- Frame sync is master, fixed 125us frame=20
duration (8kHz): 32 bits of total data; first 16 bits are valid (while=20
=46S is high), following 16 are "don't care" (while FS low)

- 16-bit linear samples, sent MSB first

- "Long Frame" sync:=A0 transmit and receive occur simultaneously while=
 the common FS line is active (high).

- TX data with 0-bit delay; start at the rising edge of the clock, whil=
e FS is high.
- RX data with 0-bit delay; sample at the falling edge of the clock, wh=
ile FS is high.

(We have posted to the TI E2E forums and sought their help, but have ye=
t to receive a response.=A0 Our E2E posts contain much more detail whic=
h may be useful to anyone willing to take a look here.=A0 They can be f=
ound here: http://e2e.ti.com/support/dsp/sitara_arm174_microprocessors/=
f/416/t/165965.aspx.)

So, obviously the McBSP has to be configured as a slave and setup to su=
pport this fixed signaling standard.=A0 The only thing that I know of t=
hat's a little unique here is the "long frame sync".=A0 Most PCM setups=
 I've seen (like i2s) use a "short frame sync" instead.


There is no "CODEC" necessary per se, as all we want to do for now is p=
ull the raw PCM data into userspace for ALSA handling.=A0 So, we have n=
ot defined any volume controls, etc.=A0 Similarly, power mangement is n=
ot our primary concern.=A0 So, for now, we've ignored DAPM.


The drivers we have pulled together, shown below, are based heavily off=
 other PCM drivers we found (like for S/PDIF or bluetooth headsets) and=
 immediately gave us working playback.=A0 We were able to play audio us=
ing the "aplay <wavefile>" command almost immediately.

*** However, when recording ("arecord -f S16_LE -r 8000 -c 1 <wavefile>=
"), we have never been able to get anything but silence (0x00).=A0 ***


We are presently using a snapshotted version of Linux 3.2-rc6 from the =
linux-omap tree.=A0 We plan on upgrading as soon as we can straighten t=
his out and prove it works.=A0 We simply don't want to make changes to =
a working setup mid-debug so as to avoid adding any other issues into t=
he mix.


We have enabled a significant amount of debugging, and as best we can t=
ell, we are getting IRQs from omap_pcm_dma_irq() and we are actually re=
ading nothing but 0s in the data block.=A0 We determined this by dumpin=
g the bytes as they came into userspace via snd_pcm_lib_read_transfer()=
=2E=A0 The data going onto the wire is non-zero, as an o-scope clearly =
shows bits changing.=A0 We have checked the pin mux maps (even making t=
he line a GPIO output to toggle it to make sure), and about every other=
 setting we can think of.=A0 If we disconnect either the CLK or FS wire=
 from the McBSP, everything stops. So, we know the control lines are be=
ing monitored.=A0 What we do not know, is whether or not they're being =
interpretted correctly.=A0 Our gut tells us they are not.=A0 If we allo=
w our record to run long enough (> 6-10 seconds), we do start receiving=
 an overrun or two, and we've not sorted out the cause of that yet.


Our first expectation is that something is not setup properly in the Mc=
BSP.=A0 Since the McBSP is being configured by Linux in our case, we fi=
gured we'd take it to the experts here to see if you could identify whe=
re we've gone wrong.

THANKS IN ADVANCE FOR YOU HELP!!!


The code below is for the two driver files we have come up with to date=
=2E=A0 (Again, our apologies that they are not compliant with the lates=
t combined omap-mcbsp stuff being released as we speak.):

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=A0=A0 celldai-soc.c =A0 >=
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


/*
=A0* celldai-soc.c=A0 --=A0 ALSA SoC audio pcm for OMAP3/AM35xx
=A0*
=A0*
=A0* Based on sound/soc/omap/overo.c by Steve Sakoman
=A0*=A0=A0 and am3517evm.c by Anuj Aggarwal <anuj.aggarwal@ti.com>
=A0*=20
=A0* This program is free software; you can redistribute it and/or
=A0* modify it under the terms of the GNU General Public License
=A0* version 2 as published by the Free Software Foundation.
=A0*
=A0* This program is distributed in the hope that it will be useful, bu=
t
=A0* WITHOUT ANY WARRANTY; without even the implied warranty of
=A0* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the GN=
U
=A0* General Public License for more details.
=A0*
=A0* You should have received a copy of the GNU General Public License
=A0* along with this program; if not, write to the Free Software
=A0* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
=A0* 02110-1301 USA
=A0*
=A0*/



#include <linux/init.h>
#include <linux/clk.h>
#include <linux/platform_device.h>
#include <linux/module.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/soc.h>
/*** includes here down, needed??? ***/
#include <asm/mach-types.h>
#include <mach/hardware.h>
#include <mach/gpio.h>
//#include <plat/mcbsp.h>

#include "omap-mcbsp.h"
//#include "omap-pcm.h"

static struct platform_device *celldai_snd_device;
static struct platform_device *celldai_codec_device;

static int celldai_hw_params(struct snd_pcm_substream *substream,
=A0=A0=A0 =A0=A0=A0 struct snd_pcm_hw_params *params)
{
=A0=A0=A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
=A0=A0=A0 /* we really do not have a "codec", it's an external device w=
ith no control & a fixed configuration */
//=A0=A0=A0 struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
=A0=A0=A0 struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
=A0=A0=A0 unsigned int fmt =3D 0;
=A0=A0=A0 int ret;

=A0=A0=A0 switch (params_channels(params)) {
=A0=A0=A0 case 1: /* voice only - 8kHz, S16_LE, mono */
=A0=A0=A0 =A0=A0=A0 fmt =3D SND_SOC_DAIFMT_LEFT_J |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SND_SOC_DAIFMT_IB_NF |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SND_SOC_DAIFMT_CBM_CFM;
=A0=A0=A0 =A0=A0=A0 break;
=A0=A0=A0 default:
=A0=A0=A0 =A0=A0=A0 return -EINVAL;
=A0=A0=A0 =A0=A0=A0 break;
=A0=A0=A0 }

#if 0=A0 /*** I don't think we'll be configuring anything with the audi=
o device from the kernel ***/
=A0=A0=A0 /* Set codec DAI configuration */
=A0=A0=A0 ret =3D snd_soc_dai_set_fmt(codec_dai, fmt);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set codec DAI configuration\=
n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }
=A0=A0=A0=20
=A0=A0=A0 /* Set the codec system clock for DAC and ADC */
=A0=A0=A0 ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SND_SOC_CLO=
CK_IN);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set codec system clock\n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }
#endif

=A0=A0=A0 /* Set cpu DAI configuration */
=A0=A0=A0 ret =3D snd_soc_dai_set_fmt(cpu_dai, fmt);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set cpu DAI configuration\n"=
);
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }

#if 0 /*** these next 2 are valid only for mcbsp1 (0 to the driver),=20
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 as other mcbsp's lack separate CLKR/FSR l=
ines ***/
=A0=A0=A0 /* set cpu CLKR & FSR as inputs (unused) */
=A0=A0=A0 ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_C=
LKX, 0,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SND_SOC_CLOCK_IN);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set CPU system clock OMAP_MC=
BSP_CLKR_SRC_CLKX\n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }

=A0=A0=A0 snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SND_SOC_CLOCK_IN);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set CPU system clock OMAP_MC=
BSP_FSR_SRC_FSX\n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }
#endif

#if 0=A0 /*** I believe these are NOT needed since McBSP is slave! ***/
=A0=A0=A0 /* Set McBSP clock to external */
=A0=A0=A0 // note, final parameter appears ignored.
=A0=A0=A0 ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLK=
X_EXT,=20
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 256 * params_rate(par=
ams), SND_SOC_CLOCK_IN);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set cpu DAI clock source: OM=
AP_MCBSP_SYSCLK_CLKX_EXT\n");=A0 // was 0
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }

=A0=A0=A0 /* Set cpu DAI master clock divisor */
=A0=A0=A0 ret =3D=A0=A0=A0 snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_C=
LKGDV, 8);=A0 // was 1
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set cpu DAI clock divider: O=
MAP_MCBSP_CLKGDV\n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }
#endif

=A0=A0=A0 return 0;
}

static struct snd_soc_ops celldai_ops =3D {
=A0=A0=A0 .hw_params =3D celldai_hw_params,
};

/* Digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link celldai_dai =3D {
=A0=A0=A0 .name =3D "cell_dai",
=A0=A0=A0 .stream_name =3D "cell_dai",
=A0=A0=A0 .cpu_dai_name =3D "omap-mcbsp-dai.1",
=A0=A0=A0 .platform_name =3D "omap-pcm-audio",
=A0=A0=A0 .codec_dai_name =3D "celldai-codec-dai",
=A0=A0=A0 .codec_name =3D "celldai-codec",
=A0=A0=A0 .ops =3D &celldai_ops,
};

/* Audio machine driver */
static struct snd_soc_card snd_soc_celldai =3D {
=A0=A0=A0 .name =3D "celldai",
=A0=A0=A0 .owner =3D THIS_MODULE,
=A0=A0=A0 .dai_link =3D &celldai_dai,
=A0=A0=A0 .num_links =3D 1,
};

static int __init celldai_soc_init(void)
{
=A0=A0=A0 int ret =3D 0;
=A0=A0=A0 printk(KERN_DEBUG "celldai_soc_init\n");

=A0=A0=A0 celldai_codec_device =3D platform_device_alloc("celldai-codec=
", -1);
=A0=A0=A0 if (!celldai_codec_device)
=A0=A0=A0 =A0=A0=A0 return -ENOMEM;

=A0=A0=A0 ret =3D platform_device_add(celldai_codec_device);
=A0=A0=A0 if (ret)
=A0=A0=A0 =A0=A0=A0 goto err1;

=A0=A0=A0 celldai_snd_device =3D platform_device_alloc("soc-audio", -1)=
;
=A0=A0=A0 if (!celldai_snd_device) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "Platform device allocation failed\=
n");
=A0=A0=A0 =A0=A0=A0 return -ENOMEM;
=A0=A0=A0 }

=A0=A0=A0 platform_set_drvdata(celldai_snd_device, &snd_soc_celldai);

=A0=A0=A0 ret =3D platform_device_add(celldai_snd_device);
=A0=A0=A0 if (ret)
=A0=A0=A0 =A0=A0=A0 goto err2;

=A0=A0=A0 printk(KERN_INFO "celldai SoC init\n");
=A0=A0=A0=20
=A0=A0=A0 return 0;

err1:
=A0=A0=A0 printk(KERN_ERR "Unable to add platform device (codec)\n");
=A0=A0=A0 platform_device_put(celldai_codec_device);
err2:
=A0=A0=A0 printk(KERN_ERR "Unable to add platform device (snd)\n");
=A0=A0=A0 platform_device_put(celldai_snd_device);

=A0=A0=A0 return ret;
}

static void __exit celldai_soc_exit(void)
{
=A0=A0=A0 printk(KERN_DEBUG "celldai_soc_exit\n");
=A0=A0=A0 platform_device_unregister(celldai_snd_device);
=A0=A0=A0 platform_device_unregister(celldai_codec_device);
}

module_init(celldai_soc_init);
module_exit(celldai_soc_exit);

MODULE_AUTHOR("TBD");
MODULE_DESCRIPTION("ALSA SoC - Custom Cell DAI");
MODULE_LICENSE("GPL");

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=A0=A0 celldai-codec.c=A0=A0=
=20
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/*
=A0* celldai-codec.c -- SOC codec driver for cell modem
=A0*
=A0*
=A0* based on spdif_transciever.c by Steve Chen <schen@mvista.com>
=A0*
=A0* This program is free software; you can redistribute it and/or
=A0* modify it under the terms of the GNU General Public License
=A0* version 2 as published by the Free Software Foundation.
=A0*
=A0* This program is distributed in the hope that it will be useful, bu=
t
=A0* WITHOUT ANY WARRANTY; without even the implied warranty of
=A0* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the GN=
U
=A0* General Public License for more details.
=A0*
=A0* You should have received a copy of the GNU General Public License
=A0* along with this program; if not, write to the Free Software
=A0* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
=A0* 02110-1301 USA
=A0*
=A0*/

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/slab.h>
#include <sound/soc.h>
#include <sound/pcm.h>
#include <sound/initval.h>

#define DRV_NAME "celldai-codec"


/**********************************************************************=
*
=A0* This device really does not need a CODEC. There definitely is to "=
encoding"
=A0* or "decoding" being done here. All that is desired is a passthroug=
h for the raw
=A0* PCM. Likewise, there is no interconnect to the cell modem (i2c, SP=
I, etc)=20
=A0* and it is not configurable. This file is really just a stub.
=A0********************************************************************=
***/

static struct snd_soc_codec_driver soc_codec_celldai_codec =3D {
};

static struct snd_soc_dai_driver pcm_stub_dai =3D {
=A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =3D "celldai-codec-dai",
=A0=A0=A0 .playback =A0=A0=A0 =3D {
=A0=A0=A0 =A0=A0=A0 .stream_name =3D "Playback",
=A0=A0=A0 =A0=A0=A0 .channels_min =3D 1,
=A0=A0=A0 =A0=A0=A0 .channels_max =3D 1,
=A0=A0=A0 =A0=A0=A0 .rates =3D SNDRV_PCM_RATE_8000,
=A0=A0=A0 =A0=A0=A0 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
=A0=A0=A0 },
=A0=A0=A0 .capture =3D {
=A0=A0=A0 =A0=A0=A0 .stream_name =3D "Capture",
=A0=A0=A0 =A0=A0=A0 .channels_min =3D 1,
=A0=A0=A0 =A0=A0=A0 .channels_max =3D 1,
=A0=A0=A0 =A0=A0=A0 .rates =3D SNDRV_PCM_RATE_8000,
=A0=A0=A0 =A0=A0=A0 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
=A0=A0=A0 },
};

static int celldai_codec_probe(struct platform_device *pdev)
{
=A0=A0=A0 return snd_soc_register_codec(&pdev->dev, &soc_codec_celldai_=
codec,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 &pcm_stub_dai, 1);
}

static int celldai_codec_remove(struct platform_device *pdev)
{
=A0=A0=A0 snd_soc_unregister_codec(&pdev->dev);
=A0=A0=A0 return 0;
}

static struct platform_driver celldai_codec_driver =3D {
=A0=A0=A0 .probe=A0=A0=A0 =A0=A0=A0 =3D celldai_codec_probe,
=A0=A0=A0 .remove=A0=A0=A0 =A0=A0=A0 =3D celldai_codec_remove,
=A0=A0=A0 .driver=A0=A0=A0 =A0=A0=A0 =3D {
=A0=A0=A0 =A0=A0=A0 .name=A0=A0=A0 =3D DRV_NAME,
=A0=A0=A0 =A0=A0=A0 .owner=A0=A0=A0 =3D THIS_MODULE,
=A0=A0=A0 },
};

static int __init dit_modinit(void)
{
=A0=A0=A0 return platform_driver_register(&celldai_codec_driver);
}

static void __exit dit_exit(void)
{
=A0=A0=A0 platform_driver_unregister(&celldai_codec_driver);
}

module_init(dit_modinit);
module_exit(dit_exit);

MODULE_AUTHOR("TBD");
MODULE_DESCRIPTION("Custom Cell DAI 'codec' driver");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:" DRV_NAME);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
