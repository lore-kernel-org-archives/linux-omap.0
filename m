From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 14/18] ASoC: davinci: Add edma dmaengine
	platform driver
Date: Thu, 13 Mar 2014 13:56:56 +0200
Message-ID: <53219D08.9070308@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
	<1394702320-21743-15-git-send-email-peter.ujfalusi@ti.com>
	<53218835.3080909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <53218835.3080909-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/13/2014 12:28 PM, Lars-Peter Clausen wrote:
> On 03/13/2014 10:18 AM, Peter Ujfalusi wrote: [...]
>> +static const struct snd_pcm_hardware edma_pcm_hardware =3D { +    .info
>> =3D SNDRV_PCM_INFO_MMAP | +                  SNDRV_PCM_INFO_MMAP_VALID |=
 +
>> SNDRV_PCM_INFO_BATCH | +                  SNDRV_PCM_INFO_PAUSE |
>> SNDRV_PCM_INFO_RESUME | +                  SNDRV_PCM_INFO_INTERLEAVED, +
>> .buffer_bytes_max    =3D 128 * 1024, +    .period_bytes_min    =3D 32, +
>> .period_bytes_max    =3D 64 * 1024, +    .periods_min        =3D 2, +
>> .periods_max        =3D 19, /* Limit by edma dmaengine driver */ +};
> =

> The idea is that we can auto-discover all the things using the
> dma_slave_caps API. Too bad we removed the possibility to specify the
> maximum number of segments from the API. Maybe we need to add it back. Is
> the 19 a hard-limit or could it be worked around by software in the
> dmaengine driver?

The edma dmaengine driver will refuse to configure more than 20 paRAM slots=
 (1
for the channel + 19 for the periods). Depending on the SoC we might have
different number of paRAM entries available. The intention with the limit w=
as
to prevent cases when we run out of paRAM entires for other devices because
audio took most of them.

>> + +static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config
>> =3D { +    .pcm_hardware =3D &edma_pcm_hardware, +    .prepare_slave_con=
fig =3D
>> snd_dmaengine_pcm_prepare_slave_config, +    .prealloc_buffer_size =3D 1=
28
>> * 1024,
> =

> Unless there is a very good reason for exactly this size, just leave it 0
> and let the generic dmaengine driver use the default.

I'd rather keep this here. Since I have the .pcm_hardware the core will ign=
ore
the snd_pcm_hardware.buffer_bytes_max when preallocating and it is in fact
going to go for:
	prealloc_buffer_size =3D 512 * 1024;
	max_buffer_size =3D SIZE_MAX;

While I have 128 * 1024 for the snd_pcm_hardware.buffer_bytes_max.

I think as long as I have the .pcm_hardware provided from the edma-pcm driv=
er
I will have the .prealloc_buffer_size as well.

>> +}; + +static const struct snd_dmaengine_pcm_config =

>> edma_compat_dmaengine_pcm_config =3D { +    .pcm_hardware =3D
>> &edma_pcm_hardware, +    .prepare_slave_config =3D
>> snd_dmaengine_pcm_prepare_slave_config, +    .compat_filter_fn =3D
>> edma_filter_fn, +    .prealloc_buffer_size =3D 128 * 1024, +};
> =

> There is no need for different configs for DT and non-DT.
> =

>> + +int edma_pcm_platform_register(struct device *dev) +{ +    if
>> (dev->of_node) +        return snd_dmaengine_pcm_register(dev, +
>> &edma_dmaengine_pcm_config, +
>> SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> =

> Since the edma dmaengine driver implements the slave cap API there is no
> need to manually specify SND_DMAENGINE_PCM_FLAG_NO_RESIDUE manually. But
> since the edma driver sets the granularity to
> DMA_RESIDUE_GRANULARITY_DESCRIPTOR in this case the generic dmaengine will
> not set SND_DMAENGINE_PCM_FLAG_NO_RESIDUE automatically since it assumes
> that the dmaengine driver is capable of properly reporting the DMA
> position.
> =

>> +    else +        return snd_dmaengine_pcm_register(dev, +
>> &edma_compat_dmaengine_pcm_config, +
>> SND_DMAENGINE_PCM_FLAG_NO_RESIDUE | +
>> SND_DMAENGINE_PCM_FLAG_NO_DT | +
>> SND_DMAENGINE_PCM_FLAG_COMPAT);
> =

> =

> If you set the flags to just SND_DMAENGINE_PCM_FLAG_COMPAT it will do the =

> right thing in the generic dmaengine driver depending on whether
> dev->of_node is set or not.

I have missed these in the core. Makes the code simpler for sure.

> There is also a devm_ version of snd_dmaengine_pcm_register() it probably =

> makes sense to use it here.

I forgot about the devm_ version. True, I'll use that instead.

-- =

P=E9ter
