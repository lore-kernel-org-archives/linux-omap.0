From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 14/18] ASoC: davinci: Add edma dmaengine
 platform driver
Date: Thu, 13 Mar 2014 14:38:37 +0100
Message-ID: <5321B4DD.5040306@metafoo.de>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <1394702320-21743-15-git-send-email-peter.ujfalusi@ti.com>
 <53218835.3080909@metafoo.de> <5321AC84.7080004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5321AC84.7080004@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, joelf@ti.com, vinod.koul@intel.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, mporter@linaro.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/13/2014 02:03 PM, Peter Ujfalusi wrote:
> On 03/13/2014 12:28 PM, Lars-Peter Clausen wrote:
>>> +int edma_pcm_platform_register(struct device *dev)
>>> +{
>>> +    if (dev->of_node)
>>> +        return snd_dmaengine_pcm_register(dev,
>>> +                    &edma_dmaengine_pcm_config,
>>> +                    SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
>>
>> Since the edma dmaengine driver implements the slave cap API there is no need
>> to manually specify SND_DMAENGINE_PCM_FLAG_NO_RESIDUE manually. But since the
>> edma driver sets the granularity to DMA_RESIDUE_GRANULARITY_DESCRIPTOR in this
>> case the generic dmaengine will not set SND_DMAENGINE_PCM_FLAG_NO_RESIDUE
>> automatically since it assumes that the dmaengine driver is capable of
>> properly reporting the DMA position.
>
> Hrm, I see. For eDMA I think we can support DMA_RESIDUE_GRANULARITY_SEGMENT
> granularity. Since according to the documentation the _SEGMENT means that the
> DMA position will be updated per periods, which is basically the same thing
> what we are doing at the moment when the granularity is
> DMA_RESIDUE_GRANULARITY_DESCRIPTOR.
>  From ALSA point of view at least they are the same: neither of them can report
> exact position, the DMA pointer jumps from period to period.
>
> IMHO in the generic dmaengine PCM we should set the SNDRV_PCM_INFO_BATCH for
> both cases.
>

Ups, sorry mixed up DMA_RESIDUE_GRANULARITY_SEGMENT and 
DMA_RESIDUE_GRANULARITY_DESCRIPTOR. You can just remove the 
SND_DMAENGINE_PCM_FLAG_NO_RESIDUE when registering the dmaengine PCM driver 
and everything will still work as expected.
