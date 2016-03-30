From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v8 1/6] ALSA: pcm: add IEC958 channel status helper for
 hw_params
Date: Wed, 30 Mar 2016 11:25:52 +0300
Message-ID: <56FB8D90.9080200@ti.com>
References: <cover.1458214526.git.jsarha@ti.com>
 <164484552294777b0b9b88d7982bd6bfb0da9a9f.1458214526.git.jsarha@ti.com>
 <s5hzithhdfz.wl-tiwai@suse.de> <20160329172312.GR5783@n2100.arm.linux.org.uk>
 <s5h4mbo8p0h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5h4mbo8p0h.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/30/16 09:21, Takashi Iwai wrote:
> On Tue, 29 Mar 2016 19:23:12 +0200,
> Russell King - ARM Linux wrote:
>>
>> On Tue, Mar 29, 2016 at 10:54:08AM +0200, Takashi Iwai wrote:
>>> On Thu, 17 Mar 2016 13:22:29 +0100,
>>> Jyri Sarha wrote:
>>>>
>>>> Add IEC958 channel status helper that gets the audio properties from
>>>> snd_pcm_hw_params instead of snd_pcm_runtime. This is needed to
>>>> produce the channel status bits already in audio stream configuration
>>>> phase.
>>>>
>>>> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
>>>
>>> This patch looks almost good to me, but...
>>>
>>>> @@ -71,6 +59,7 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
>>>>  			     IEC958_AES4_CON_MAX_WORDLEN_24;
>>>>  			break;
>>>>  		case 24:
>>>> +		case 32: /* Assume 24-bit width for 32-bit samples. */
>>>>  			ws = IEC958_AES4_CON_WORDLEN_24_20 |
>>>>  			     IEC958_AES4_CON_MAX_WORDLEN_24;
>>>>  			break;
>>>
>>> ... this change is silently slipped in.  It should be mentioned in the
>>> changelog, or split to another patch, as this is basically an
>>> orthogonal change.
>>
>> Does it even make sense - AES doesn't have support for 32-bit samples,
>> it can only ever truncate them down to 24-bit.
> 
> Well, using SNDRV_PCM_FORMAT_S32_* for 24 bit samples is seen often on
> real devices, mostly on PCI ones.  So, adding the value 32 check there
> itself is valid, I suppose.  It's rather due to a bad design in the
> current API.
> 

That also happens on SoC environment i2s interfaces for various reasons.
For instance if the i2s bit-clock for sample-rate * 24 * 2 is not
available, but sample-rate * 32 * 2 is.

> The actual bits should be specified hw_params.msbits field, instead.
> But, not all drivers set this properly, unfortunately.
> 

How about allowing the 32-bit format only if hw_params.msbits is set to
24 bits?

I can set the hw_params.msbits to 24 in ASoC hdmi-codec's hw_params,
can't I? I could also fake the whole hw_params struct that I pass to
snd_pcm_create_iec958_consumer_hw_params(), but would that make sense?

What ever the approach, I can of course split the 32 bit support into a
separate subsequent patch, but for instance Beaglebone-black 48kHz
24-bit HDMI audio needs 32 bit format on i2s bus because of the
available i2s bit-clocks.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
