From: "Clark, Rob" <rob@ti.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it make sense?
Date: Tue, 21 Aug 2012 07:39:55 -0500
Message-ID: <CAO8GWq=B8wa1tWOiT5ja80T2VrxHiSKSp4U6fHydV9iyOg=+Zg@mail.gmail.com>
References: <5032E8A5.8070108@ti.com>
	<1345528867.15491.12.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:36997 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756610Ab2HUMj4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 08:39:56 -0400
Received: by obc16 with SMTP id 16so12193150obc.20
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 05:39:55 -0700 (PDT)
In-Reply-To: <1345528867.15491.12.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, Liam Girdwood <lrg@ti.com>, "Brown, Mark" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guiriec, Sebastien" <s-guiriec@ti.com>, DRI development list <dri-devel@lists.freedesktop.org>

On Tue, Aug 21, 2012 at 1:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-08-20 at 20:47 -0500, Ricardo Neri wrote:
>> Hello!
>>
>> I have been working on prototypes for the ASoC OMAP HDMI audio driver to
>> propagate events from the HDMI output (e.g., display getting
>> enabled/disabled/suspended). This for the users of the driver to react
>> to such events. For instance, if the display is disabled or disconected,
>> audio could be stopped, rerouted or whatever other decision the user
>> makes. This is needed because, if, for instance, the  HDMI IP goes off,
>> audio will stall and the audio users will only see a "playback write
>> error (DMA or IRQ trouble?)"
>>
>> In my prototypes I have used snd_soc_jack for this purpose and I have
>> some questions:
>>
>> *I see snd_soc_jack is used mostly for headsets and microphones with
>> actual external mechanical connections. Strictly, in my case I propagate
>> events originated by the OMAP display driver (changes in the power
>> state), and not from external events. Some of these events are generated
>> from an actual HDMI cable connection/disconnection, though.
>>
>> *Maybe the event should be propagated by omapdss/omapdrm/drm and the
>> entity in charge of the audio policy should listen those events instead.
>>
>> *I do see SND_JACK_VIDEOOUT and SND_JACK_AVOUT types so maybe it is
>> feasible for an audio driver to report events from an AV output.
>>
>> I was wondering about how much sense does it make to you guys use a
>> snd_soc_jack in this case?
>
> How does DRM handle audio? I made a quick grep, but I see the drm
> drivers only enabling the audio in the HW, nothing else.

I confess to not knowing too much about audio/alsa, but what does
audio driver need from hdmi?  Just hotplug events?

>From a quick look, it seems most of what the existing drm drivers are
doing is detecting if the display supports audio, and then turning
on/off the hw.. (and some infoframe stuff in some cases).

Does ASoC support 'hotplug' of audio devices?  If so, maybe it makes
some sense to have some support in drm core.  At least all the edid
parsing stuff to determine if the display supports audio should be
generic and not driver specific.

BR,
-R

> If there's a common generic way to handle this, we should obviously use
> that. But if we need to choose between doing something custom or doing
> it in omapdrm driver, I think we should go for drm the only solution and
> forget about audio with omapfb.
>
>  Tomi
>
