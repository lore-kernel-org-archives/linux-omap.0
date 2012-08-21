From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] [RFC] ASoC: snd_soc_jack for HDMI audio: does it
 make	sense?
Date: Tue, 21 Aug 2012 14:30:51 +0200
Message-ID: <50337F7B.1060501@canonical.com>
References: <5032E8A5.8070108@ti.com> <s5hlih895kt.wl%tiwai@suse.de> <20120821120511.GB7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58550 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746Ab2HUMax (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 08:30:53 -0400
In-Reply-To: <20120821120511.GB7995@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Ricardo Neri <ricardo.neri@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>

On 08/21/2012 02:05 PM, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 07:28:34AM +0200, Takashi Iwai wrote:
>> Ricardo Neri wrote:
>
>>> I was wondering about how much sense does it make to you guys use a
>>> snd_soc_jack in this case?
>
>> HD-audio already uses the generic jack event for the HDMI/DP
>> connection change notification as well, so I think it would make sense
>> in general.
>
> The whole problem here is that we don't *have* a generic jack interface.
> We've got:
>
>   - sound/core/jack.c which was written to be a generic API and is used
>     by everything that does jack support currently.
>
>   - sound/core/ctljack.c which was added later and provides separate
>     in-kernel and userspace APIs and is currently only used by HDA.

This is wrong. PulseAudio uses the new ctljack API. I started out with 
an implementation which used the input device API (sound/core/jack.c), 
but since some people did not like this API, the ctljack API was 
designed and implemented for PA to use, which it does (since PulseAudio 
2.0 - the input device API implementation in PulseAudio was never merged 
upstream).

>   - extcon which does have a good reason to be a separate API since that
>     it's not audio specific (and is likely to be picked up by Android as
>     the code was originally taken from there); it's currently not
>     supported by the frameworks in ALSA.  I'd suggest Pulse should be using
>     it too.
>
> This is a complete shambles for both driver authors and userspace, the
> ABI varies randomly with drivers and in theory driver authors have to
> implement everything three times which is just nuts.
>
> What I'd like to see happening is that we merge ctljack into jack (since
> only HDA is going to be affected by that change it seems like the right
> direction to make the merge) and also add extcon support, I have looked
> at the extcon support.

I don't know either why we have two different interfaces for jack 
detection (not counting extcon) for driver writers. I think we should 
merge jack and ctljack, as long as that does not mean you break anything 
I'm relying on in ctljack.

Maybe something for discussion at Plumbers?

> Short term for drivers used on embedded systems I'd have to recommend
> extcon rather than anything ALSA-specific.

I thought that when Takashi did the new ctljack interface, that would 
effectively deprecate the old input device interface, and that ctljack 
was the new recommendation.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
