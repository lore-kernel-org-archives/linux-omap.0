From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] ASoC: ti: remove compat dma probing
Date: Thu, 7 Mar 2019 16:12:05 +0100
Message-ID: <CAK8P3a2kbHU2TLNebO9vvqh6uim7p8EU7DWQssfOd1TtdJHDXQ@mail.gmail.com>
References: <20190304203114.1894822-1-arnd@arndb.de> <20190304203114.1894822-2-arnd@arndb.de>
 <865ffc6e-c6f7-a30a-1c0c-14194b3458ef@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <865ffc6e-c6f7-a30a-1c0c-14194b3458ef@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 7, 2019 at 2:22 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Hi Arnd,
>
> On 04/03/2019 22.30, Arnd Bergmann wrote:
> > After running into a link error:
> >
> > sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'
> >
> > I checked all users of this, and they have new-style 'dma_slave_map' tables,
> > so none of them should still need it. Removing the associated lines
> > simplifies the code and avoids the build-time dependency on the
> > respective dmaengine drivers.
>
> Thank you for the patch!
>
> Yes, I believe I have covered all possible legacy uses for both edma and
> sdma with dma_slave_map
>
> With the two comments addressed:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks!

> > @@ -43,14 +43,12 @@ static const struct snd_pcm_hardware edma_pcm_hardware = {
> >  static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
> >       .pcm_hardware = &edma_pcm_hardware,
> >       .prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> > -     .compat_filter_fn = edma_filter_fn,
>
> We can also remove the
> #include <linux/edma.h>
>
> as it is no longer needed.

> Here we can remove the
> #include <linux/omap-dmaengine.h>

Ah, perfect!

I also see that linux/edma.h can be completely removed afterwards, and the
filter function made static. linux/omap-dmaengine.h too, but it is included
from linux/omap.h, of which at least parts are still needed for omap_udc.c

       Arnd
