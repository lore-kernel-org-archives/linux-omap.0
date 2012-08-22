From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
 make	sense?
Date: Tue, 21 Aug 2012 20:24:45 -0500
Message-ID: <503434DD.8030003@ti.com>
References: <5032E8A5.8070108@ti.com> <s5hlih895kt.wl%tiwai@suse.de>
 <20120821120511.GB7995@opensource.wolfsonmicro.com>
 <50337F7B.1060501@canonical.com>
 <20120821131625.GD7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120821131625.GD7995@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Valkeinen,
 Tomi" <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: linux-omap@vger.kernel.org



On 08/21/2012 08:16 AM, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 02:30:51PM +0200, David Henningsson wrote:
>> On 08/21/2012 02:05 PM, Mark Brown wrote:
>
>>>   - sound/core/ctljack.c which was added later and provides separate
>>>     in-kernel and userspace APIs and is currently only used by HDA.
>
>> This is wrong. PulseAudio uses the new ctljack API. I started out
>> with an implementation which used the input device API
>> (sound/core/jack.c), but since some people did not like this API,
>> the ctljack API was designed and implemented for PA to use, which it
>> does (since PulseAudio 2.0 - the input device API implementation in
>> PulseAudio was never merged upstream).
>
> ...and the only thing using this API to generate events is HDA which is
> what I was talking about here given that this is a question from a
> driver point of view.
>
>>> What I'd like to see happening is that we merge ctljack into jack (since
>>> only HDA is going to be affected by that change it seems like the right
>>> direction to make the merge) and also add extcon support, I have looked
>>> at the extcon support.
>
>> I don't know either why we have two different interfaces for jack
>> detection (not counting extcon) for driver writers. I think we
>> should merge jack and ctljack, as long as that does not mean you
>> break anything I'm relying on in ctljack.
>
>> Maybe something for discussion at Plumbers?
>
> We discussed this last time we all met and came to the above conclusion :/
>
>>> Short term for drivers used on embedded systems I'd have to recommend
>>> extcon rather than anything ALSA-specific.
>
>> I thought that when Takashi did the new ctljack interface, that
>> would effectively deprecate the old input device interface, and that
>> ctljack was the new recommendation.
>
> Android currently uses the out of tree version of the extcon ABI (like I
> say it's where the code originated), and some OSs do use the input ABI
> also but realistically if you've got to pick one Android is where the
> market is at.

So, it seems that the way to go is extcon. I guess that ALSA will use 
extcon just like today snd_jack uses the input driver. is this correct? 
Is there any chance that ctrljack will propagate the events through 
extcon? Is there any early implementation that I could look at? I am 
asking to know how feasible is to use ctljack today and be compatible 
with extcon in the future.

Thanks!

Ricardo

>
> To my knowledge no embedded OS is using the control jacks, it's possible
> that there's something using them as a function of using PulseAudio but
> the ones I'm famililar with currently ignore PulseAudio routing and just
> use the mixing facilities.  Given the dependency on alsa-lib it'd be an
> inconvenient ABI to adopt for most of them.
>
