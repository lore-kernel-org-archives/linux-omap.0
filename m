From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Thu, 13 Nov 2014 16:54:48 +0200
Message-ID: <5464C638.40708@ti.com>
References: <cover.1415803064.git.jsarha@ti.com>	<20141112222344.GU3815@sirena.org.uk>	<54646648.5030807@ti.com> <20141113101738.6338bb1c@armhf> <54648149.9070104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39293 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbaKMOy7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2014 09:54:59 -0500
In-Reply-To: <54648149.9070104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Francois Moine <moinejf@free.fr>
Cc: Mark Brown <broonie@kernel.org>, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On 11/13/2014 12:00 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 13/11/14 11:17, Jean-Francois Moine wrote:
>> On Thu, 13 Nov 2014 10:05:28 +0200
>> Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
...
>> and I saw only a few dependencies between the 2 subsystems:
>>
>> - the CODEC must know the transmitter parameters (DAIs - static -,
>>    audio constraints - dynamic -),
>
> The video mode (i.e. availability of audio) or the EDID (i.e. the
> supported audio parameters) may change at any time, so I presume in your
> series the video side will inform the codec of these changes at any point?
>
>> - the CODEC must alert the transmitter on audio start and stop.
>>
>> I don't think that stopping audio streaming on HDMI disconnection is
>
> And you allow audio playback also if the monitor does not support audio,
> or the video mode does not supprot audio?
>
>> useful. I even let audio streaming start when the HDMI cable is
>> disconnected.
>
> Ah, this is actually unclear thing to me: what should the audio side
> behavior be when the HDMI cable is disconnected or the video is blanked?
> I believe the options are:
>
> a) Always keep the audio device operational, no matter what is the
> status of the video side. How should this work if the HDMI videomode or
> the HDMI monitor does not support audio? Is it desirable that the
> userspace has no idea that the audio is not actually going anywhere?
>
> b) Remove the audio device when audio support is not available. This
> kind of makes sense, as, well, there's no possibility for audio output.
> But maybe this is not how linux sound devices are supposed to behave?
>
> c) Return errors when playback is attempted when audio support is not
> available. Again, this kind of makes sense, as audio playback is not
> possible. But maybe this is also not how audio devices generally work.
>
> Jyri, were there some other options we discussed?
>

There was the 4th option: the driver forcing pause on the pcm when the 
cable is disconnected or screen is blanked and resuming it automatically 
when the picture is back. But I think that is maybe too hackish solution.

Considering the big picture, including the userspace. I think we would 
need some way to tell the userspace when the HDMI device is available. 
The problem is the same for both a and c cases. Maybe a read only alsa 
mixer could be used for that.

Cheers,
Jyri

> Currently, the OMAP HDMI version does c). It's the easiest solution for us.
>
> Option a) is a bit problematic for us, as it requires the HDMI IP side
> to be fully operational, with the video output configured and enabled,
> as that is what drives the audio DMA. If we stop the video, I believe
> the audio DMA will freeze, and it'll lead to timeouts on the audio side.
>
> I haven't tried, but I believe we could program the HDMI IP to some safe
> default video mode if the cable is disconnected, and turn off the actual
> HDMI PHY, so that the audio side could work even if the HDMI stream is
> not going anywhere. I think it would be quite big change to how the HDMI
> driver works at the moment.
>
> But then, if the cable _is_ connected and the video mode is such that it
> cannot not support audio, I wonder if we can still fake the audio
> playback or will the HDMI IP get confused...
>

