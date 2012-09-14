From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 03/15] dmaengine: Add no_wakeup parameter to dmaengine_prep_dma_cyclic()
Date: Fri, 14 Sep 2012 10:12:25 +0300
Message-ID: <5052D8D9.8060802@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com> <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com> <5051FB4D.3000009@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5051FB4D.3000009@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/13/2012 06:27 PM, Lars-Peter Clausen wrote:
> On 09/13/2012 03:37 PM, Peter Ujfalusi wrote:
>> The dmaengine_prep_dma_cyclic() function primarily used by audio for=
 cyclic
>> transfer required by ALSA.
>> With this new parameter it is going to be possible to enable the
>> SNDRV_PCM_INFO_NO_PERIOD_WAKEUP mode on platforms where it is possib=
le.
>> This patch only changes the public API first. Followup patch will ch=
ange
>> the device_prep_dma_cyclic() callback parameters to pass this inform=
ation
>> towards the dma drivers.
>>
>=20
> Hi,
>=20
> Hm... Do you think it would work as well if we implement this by sett=
ing the
> callback for the descriptor to NULL? If the callback is NULL there is
> nothing to at the end of a transfer/period and the dma engine driver =
may
> choose to disable interrupts. This would also benefit non cyclic tran=
sfers
> where the callback is NULL and we do not need add the new parameter t=
o
> dmaengine_prep_dma_cyclic.

We could do that but dma drivers enable the interrupts within
dmaengine_prep_dma_cyclic() call, and we fill up the callback for
dmaengine_submit() dmaengine API call.
We need to tell the dma drivers in dmaengine_prep_dma_cyclic() to suppr=
ess the
interrupts.

Note: First I was trying this to be done in hw_params() time via the
dmaengine_slave_config() call, but substream->runtime->no_period_wakeup=
 is not
configured in there. It is set for _prepare() and _trigger().

As Vinod and Russell suggested I will modify the dmaengine_prep_dma_cyc=
lic()
API to pass flags as well instead of the no_wakeup parameter.

>=20
> - Lars
>=20
>> ---
>>  include/linux/dmaengine.h     | 3 ++-
>>  sound/soc/soc-dmaengine-pcm.c | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 9c02a45..990444b 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -653,7 +653,8 @@ static inline struct dma_async_tx_descriptor *dm=
aengine_prep_rio_sg(
>> =20
>>  static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cy=
clic(
>>  		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>> -		size_t period_len, enum dma_transfer_direction dir)
>> +		size_t period_len, enum dma_transfer_direction dir,
>> +		bool no_wakeup)
>>  {
>>  	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_le=
n,
>>  						period_len, dir, NULL);
>> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine=
-pcm.c
>> index 5df529e..6b70adb 100644
>> --- a/sound/soc/soc-dmaengine-pcm.c
>> +++ b/sound/soc/soc-dmaengine-pcm.c
>> @@ -147,7 +147,8 @@ static int dmaengine_pcm_prepare_and_submit(stru=
ct snd_pcm_substream *substream)
>>  	desc =3D dmaengine_prep_dma_cyclic(chan,
>>  		substream->runtime->dma_addr,
>>  		snd_pcm_lib_buffer_bytes(substream),
>> -		snd_pcm_lib_period_bytes(substream), direction);
>> +		snd_pcm_lib_period_bytes(substream), direction,
>> +		substream->runtime->no_period_wakeup);
>> =20
>>  	if (!desc)
>>  		return -ENOMEM;
>=20


--=20
P=E9ter
