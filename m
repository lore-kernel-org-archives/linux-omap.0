From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [RFC 1/3] ASoC: dmaengine: Don't use runtime	private
 data for dmaengine data
Date: Tue, 04 Sep 2012 16:26:28 +0300
Message-ID: <50460184.4000404@ti.com>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk> <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk> <5045124D.3050604@metafoo.de> <20120903204325.GA728@n2100.arm.linux.org.uk> <50451A4A.9000108@metafoo.de> <s5ha9x62an0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:43094 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757065Ab2IDN0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 09:26:10 -0400
Received: by ggdk6 with SMTP id k6so1145217ggd.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 06:26:09 -0700 (PDT)
In-Reply-To: <s5ha9x62an0.wl%tiwai@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Takashi,

On 09/04/2012 04:14 PM, Takashi Iwai wrote:
>> Ok, it might have been helpful in the conversion process, but for th=
e final
>> patch it would be nice if you could replace
>>
>> struct snd_pcm_runtime *runtime =3D substream->runtime;
>> struct omap_runtime_data *prtd =3D runtime->private_data;
>> struct omap_pcm_dma_data *dma_data =3D prtd->dma_data;
>> with
>> struct omap_pcm_dma_data *dma_data =3D snd_dmaengine_pcm_get_data(su=
bstream);
>>
>> and in the hwparams callback use
>>
>> snd_dmaengine_pcm_set_data(substream, dma_data);
>>
>> and then drop patch 1 and 2 from the series.
>=20
> We discussed with Liam about the addition of new field in ALSA core,
> and concluded that a bit different approach, at least, more generic
> name is preferred, even if a new field is inevitably needed.
>=20
> So, eventually some change may happen in near future in ALSA core
> side, but still it'd be really helpful if the callers have been
> standardized beforehand with a helper function like above.

If the omap-pcm dmaengine conversion works on all OMAP versions (from O=
MAP1 to
OMAP5) it is possible to avoid the additional field.
My main concern at the moment is if we will need two sets of drivers to
support OMAP1 and OMAP2/3/4/5.
In all case we use the same omap-mcbsp driver which would need deal wit=
h two
different type of ASoC platform driver (dmaengine and non-dmaengine).
I hope we get confirmation from Janusz soon regarding to OMAP1 with dma=
engine
so we can plan on how to move forward.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
