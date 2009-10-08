From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/8] ASoC: OMAP: RX-51 Machine driver and AIC34b_dummy
 driver
Date: Thu, 8 Oct 2009 16:18:19 +0300
Message-ID: <20091008131819.GB9558@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-3-git-send-email-eduardo.valentin@nokia.com>
 <1255005086.30157.165.camel@eenurkka-desktop>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39556 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758189AbZJHNUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:20:08 -0400
Content-Disposition: inline
In-Reply-To: <1255005086.30157.165.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 02:31:26PM +0200, Nurkkala Eero.An (EXT-Offcode/Oulu) wrote:
> On Thu, 2009-10-08 at 13:58 +0200, Valentin Eduardo (Nokia-D/Helsinki)
> wrote:
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >
> > Introduce RX-51 Machine driver for ASoC and AIC34b_dummy (block B) i2c driver.
> >
> > Also move the request_gpio of speaker_enabled
> > from board-rx51-peripherals.c to this machine driver.
> >
> > These drivers were originally written by Jarkko Nikula.
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  arch/arm/mach-omap2/board-rx51-peripherals.c |    2 -
> >  sound/soc/omap/Kconfig                       |   10 +
> >  sound/soc/omap/Makefile                      |    2 +
> >  sound/soc/omap/aic34b_dummy.c                |  271 +++++++++
> >  sound/soc/omap/aic34b_dummy.h                |   32 +
> >  sound/soc/omap/rx51.c                        |  793 ++++++++++++++++++++++++++
> >  sound/soc/omap/rx51.h                        |   29 +
> >  7 files changed, 1137 insertions(+), 2 deletions(-)
> >  create mode 100644 sound/soc/omap/aic34b_dummy.c
> >  create mode 100644 sound/soc/omap/aic34b_dummy.h
> >  create mode 100644 sound/soc/omap/rx51.c
> >  create mode 100644 sound/soc/omap/rx51.h
> >

<snip>

> > +static struct platform_device *rx51_snd_device;
> > +
> > +#define REMAP_OFFSET           2
> > +#define DEDICATED_OFFSET       3
> > +#define VMMC2_DEV_GRP          0x2B
> > +#define VMMC2_285V             0x0a
> > +
> 
> These defines appear unused?


yeah, will rip then off.

> 
> > +static int __init rx51_soc_init(void)
> > +{
> > +       int err;
> > +       struct device *dev;
> > +
> > +       if (!machine_is_nokia_rx51())
> > +               return -ENODEV;
> > +
> > +       if (gpio_request(RX51_CODEC_RESET_GPIO, NULL) < 0)
> > +               BUG();
> > +       if (gpio_request(RX51_TVOUT_SEL_GPIO, "tvout_sel") < 0)
> > +               BUG();
> > +       if (gpio_request(RX51_ECI_SWITCH_1_GPIO, "ECI switch 1") < 0)
> > +               BUG();
> > +       if (gpio_request(RX51_ECI_SWITCH_2_GPIO, "ECI switch 2") < 0)
> > +               BUG();
> > +       gpio_direction_output(RX51_CODEC_RESET_GPIO, 0);
> > +       gpio_direction_output(RX51_TVOUT_SEL_GPIO, 0);
> > +       gpio_direction_output(RX51_ECI_SWITCH_1_GPIO, 0);
> > +       gpio_direction_output(RX51_ECI_SWITCH_2_GPIO, 1);
> > +
> > +       gpio_set_value(RX51_CODEC_RESET_GPIO, 0);
> > +       udelay(1);
> > +       gpio_set_value(RX51_CODEC_RESET_GPIO, 1);
> > +       msleep(1);
> > +
> > +       if (gpio_request(RX51_SPEAKER_AMP_TWL_GPIO, NULL) < 0)
> > +               BUG();
> > +       gpio_direction_output(RX51_SPEAKER_AMP_TWL_GPIO, 0);
> > +
> > +       err = snd_soc_register_dai(&btcodec_dai);
> > +       if (err)
> > +               return err;
> > +
> > +       rx51_snd_device = platform_device_alloc("soc-audio", -1);
> > +       if (!rx51_snd_device) {
> > +               err = -ENOMEM;
> > +               goto err0;
> > +       }
> > +
> > +       platform_set_drvdata(rx51_snd_device, &rx51_snd_devdata);
> > +       rx51_snd_devdata.dev = &rx51_snd_device->dev;
> > +       err = platform_device_add(rx51_snd_device);
> > +       if (err)
> > +               goto err1;
> > +
> > +       dev = &rx51_snd_device->dev;
> > +
> > +       *(unsigned int *)rx51_dai[0].cpu_dai->private_data = 1;
> > +       *(unsigned int *)rx51_dai[1].cpu_dai->private_data = 2;
> > +
> > +       err = device_create_file(dev, &dev_attr_eci_mode);
> > +       if (err)
> > +               goto err2;
> > +
> > +       return err;
> > +err2:
> > +       platform_device_del(rx51_snd_device);
> > +err1:
> > +       platform_device_put(rx51_snd_device);
> > +err0:
> > +       snd_soc_unregister_dai(&btcodec_dai);
> > +
> > +       return err;
> > +
> > +}
> > +
> > +static void __exit rx51_soc_exit(void)
> > +{
> > +       platform_device_unregister(rx51_snd_device);
> > +       snd_soc_unregister_dai(&btcodec_dai);
> > +}
> > +
> > +module_init(rx51_soc_init);
> > +module_exit(rx51_soc_exit);
> > +
> > +MODULE_AUTHOR("Nokia Corporation");
> > +MODULE_DESCRIPTION("ALSA SoC Nokia RX51");
> > +MODULE_LICENSE("GPL");
> > diff --git a/sound/soc/omap/rx51.h b/sound/soc/omap/rx51.h
> > new file mode 100644
> > index 0000000..ee55260
> > --- /dev/null
> > +++ b/sound/soc/omap/rx51.h
> > @@ -0,0 +1,29 @@
> > +#ifndef _RX51_H_
> > +#define _RX51_H_
> > +
> > +/*
> > + *  rx51.h - SoC audio for Nokia RX51
> > + *
> > + *  Copyright (C) 2008 - 2009 Nokia Corporation
> > + *
> > + *  Contact: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > + *           Eduardo Valentin <eduardo.valentin@nokia.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; version 2 of the License.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + */
> > +
> > +int rx51_set_eci_mode(int mode);
> > +void rx51_jack_report(int status);
> > +
> > +#endif /* _RX51_H_ */
> > --
> > 1.6.4.183.g04423
> >

-- 
Eduardo Valentin
