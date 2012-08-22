From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
	make sense?
Date: Tue, 21 Aug 2012 19:58:02 -0500
Message-ID: <50342E9A.9010707@ti.com>
References: <5032E8A5.8070108@ti.com> <1345528867.15491.12.camel@lappyti>
 <CAO8GWq=B8wa1tWOiT5ja80T2VrxHiSKSp4U6fHydV9iyOg=+Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAO8GWq=B8wa1tWOiT5ja80T2VrxHiSKSp4U6fHydV9iyOg=+Zg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Clark, Rob" <rob@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Brown,
 Mark" <broonie@opensource.wolfsonmicro.com>, DRI development list <dri-devel@lists.freedesktop.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org



On 08/21/2012 07:39 AM, Clark, Rob wrote:
> On Tue, Aug 21, 2012 at 1:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On Mon, 2012-08-20 at 20:47 -0500, Ricardo Neri wrote:
>>> Hello!
>>>
>>> I have been working on prototypes for the ASoC OMAP HDMI audio driver to
>>> propagate events from the HDMI output (e.g., display getting
>>> enabled/disabled/suspended). This for the users of the driver to react
>>> to such events. For instance, if the display is disabled or disconected,
>>> audio could be stopped, rerouted or whatever other decision the user
>>> makes. This is needed because, if, for instance, the  HDMI IP goes off,
>>> audio will stall and the audio users will only see a "playback write
>>> error (DMA or IRQ trouble?)"
>>>
>>> In my prototypes I have used snd_soc_jack for this purpose and I have
>>> some questions:
>>>
>>> *I see snd_soc_jack is used mostly for headsets and microphones with
>>> actual external mechanical connections. Strictly, in my case I propagate
>>> events originated by the OMAP display driver (changes in the power
>>> state), and not from external events. Some of these events are generated
>>> from an actual HDMI cable connection/disconnection, though.
>>>
>>> *Maybe the event should be propagated by omapdss/omapdrm/drm and the
>>> entity in charge of the audio policy should listen those events instead.
>>>
>>> *I do see SND_JACK_VIDEOOUT and SND_JACK_AVOUT types so maybe it is
>>> feasible for an audio driver to report events from an AV output.
>>>
>>> I was wondering about how much sense does it make to you guys use a
>>> snd_soc_jack in this case?
>>
>> How does DRM handle audio? I made a quick grep, but I see the drm
>> drivers only enabling the audio in the HW, nothing else.
>
> I confess to not knowing too much about audio/alsa, but what does
> audio driver need from hdmi?  Just hotplug events?

At least for the case of the ASoC HDMI audio driver (but hopefully for 
other audio drivers as well), it needs to detect whether an HDMI output 
is available, if the display's current configuration supports audio 
(e.g., a 1080p display configured as VGA should be reported as not 
supporting audio). It also needs interfaces to 
configure/prepare/start/stop audio. Also, of course, needs to know if 
the display is off/on/suspended and when transitions occur. For OMAP, 
omapdss provide an interface for this functionality for ALSA or any 
other interested user.
>
>  From a quick look, it seems most of what the existing drm drivers are
> doing is detecting if the display supports audio, and then turning
> on/off the hw.. (and some infoframe stuff in some cases).

Yes, it seems to me that every driver makes its own audio 
implementation, mainly focused on configuration. I could not find any 
audio common interface so that users like ALSA can take advantage of.

Also, I could not see any ALSA driver using functionality provided by a 
drm driver.

Maybe the lack of audio support in drm is because the audio users should 
not talk to drm directly but to a lower level component (omapdrm, 
omapdss?). However, today there exists video technology supports audio 
as well, such as DisplayPort or HDMI. Could it make more sense now to 
provide audio support?

>
> Does ASoC support 'hotplug' of audio devices?  If so, maybe it makes
> some sense to have some support in drm core.  At least all the edid
> parsing stuff to determine if the display supports audio should be
> generic and not driver specific.

drm already supports generic edid parsing to check for audio support. 
This is a good example of how an audio driver could just use that 
functionality to probe audio support.

Ricardo
>
> BR,
> -R
>
>> If there's a common generic way to handle this, we should obviously use
>> that. But if we need to choose between doing something custom or doing
>> it in omapdrm driver, I think we should go for drm the only solution and
>> forget about audio with omapfb.
>>
>>   Tomi
>>
