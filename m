From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
 make sense?
Date: Thu, 23 Aug 2012 20:44:32 -0500
Message-ID: <5036DC80.90200@ti.com>
References: <5032E8A5.8070108@ti.com> <1345528867.15491.12.camel@lappyti>
 <CAO8GWq=B8wa1tWOiT5ja80T2VrxHiSKSp4U6fHydV9iyOg=+Zg@mail.gmail.com>
 <50342E9A.9010707@ti.com> <s5htxvv8iot.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5htxvv8iot.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Brown,
 Mark" <broonie@opensource.wolfsonmicro.com>, DRI development list <dri-devel@lists.freedesktop.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Clark, Rob" <rob@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Takashi,

On 08/22/2012 02:55 AM, Takashi Iwai wrote:
> At Tue, 21 Aug 2012 19:58:02 -0500,
> Ricardo Neri wrote:
>>
>>
>>
>> On 08/21/2012 07:39 AM, Clark, Rob wrote:
>>> On Tue, Aug 21, 2012 at 1:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>>>> On Mon, 2012-08-20 at 20:47 -0500, Ricardo Neri wrote:
>>>>> Hello!
>>>>>
>>>>> I have been working on prototypes for the ASoC OMAP HDMI audio driver=
 to
>>>>> propagate events from the HDMI output (e.g., display getting
>>>>> enabled/disabled/suspended). This for the users of the driver to react
>>>>> to such events. For instance, if the display is disabled or disconect=
ed,
>>>>> audio could be stopped, rerouted or whatever other decision the user
>>>>> makes. This is needed because, if, for instance, the  HDMI IP goes of=
f,
>>>>> audio will stall and the audio users will only see a "playback write
>>>>> error (DMA or IRQ trouble?)"
>>>>>
>>>>> In my prototypes I have used snd_soc_jack for this purpose and I have
>>>>> some questions:
>>>>>
>>>>> *I see snd_soc_jack is used mostly for headsets and microphones with
>>>>> actual external mechanical connections. Strictly, in my case I propag=
ate
>>>>> events originated by the OMAP display driver (changes in the power
>>>>> state), and not from external events. Some of these events are genera=
ted
>>>>> from an actual HDMI cable connection/disconnection, though.
>>>>>
>>>>> *Maybe the event should be propagated by omapdss/omapdrm/drm and the
>>>>> entity in charge of the audio policy should listen those events inste=
ad.
>>>>>
>>>>> *I do see SND_JACK_VIDEOOUT and SND_JACK_AVOUT types so maybe it ie =
=B7 =B7 Il y a 12 minutes =B7

s
>>>>> feasible for an audio driver to report events from an AV output.
>>>>>
>>>>> I was wondering about how much sense does it make to you guys use a
>>>>> snd_soc_jack in this case?
>>>>
>>>> How does DRM handle audio? I made a quick grep, but I see the drm
>>>> drivers only enabling the audio in the HW, nothing else.
>>>
>>> I confess to not knowing too much about audio/alsa, but what does
>>> audio driver need from hdmi?  Just hotplug events?
>>
>> At least for the case of the ASoC HDMI audio driver (but hopefully for
>> other audio drivers as well), it needs to detect whether an HDMI output
>> is available, if the display's current configuration supports audio
>> (e.g., a 1080p display configured as VGA should be reported as not
>> supporting audio). It also needs interfaces to
>> configure/prepare/start/stop audio. Also, of course, needs to know if
>> the display is off/on/suspended and when transitions occur. For OMAP,
>> omapdss provide an interface for this functionality for ALSA or any
>> other interested user.
>>>
>>>   From a quick look, it seems most of what the existing drm drivers are
>>> doing is detecting if the display supports audio, and then turning
>>> on/off the hw.. (and some infoframe stuff in some cases).
>>
>> Yes, it seems to me that every driver makes its own audio
>> implementation, mainly focused on configuration. I could not find any
>> audio common interface so that users like ALSA can take advantage of.
>>
>> Also, I could not see any ALSA driver using functionality provided by a
>> drm driver.
>>
>> Maybe the lack of audio support in drm is because the audio users should
>> not talk to drm directly but to a lower level component (omapdrm,
>> omapdss?). However, today there exists video technology supports audio
>> as well, such as DisplayPort or HDMI. Could it make more sense now to
>> provide audio support?
>
> The reason is that the audio and video handling are already separated
> in the hardware level, at least, for desktop graphics.

Separated in what sense? Do they have separate register banks in =

independent power domains? Can audio an video work with complete =

independence. What happens if someone decides to power off video. Is the =

audio able to continue if required?
>
> The audio infoframe is passed via ELD to the audio controller part
> upon plug/unplugging via HD-audio unsolicited event, and the audio
> driver sets up the stuff according to the given ELD.  Thus no extra
> interface between drm and ALSA was required in the kernel API level,
> so far.

I see that the unsolicited event is used only to parse the EDID, =

correct? It also notifies about the jack status. Hence, if there the =

cable is disconnected the application will know and act accordingly. Is =

this understanding correct?

Also, I see that hda_pcm_ops does not have a trigger or start/stop =

functions, how does it know when to start/stop audio. Maybe with =

azx_pcm_trigger?

Sorry, I am not expert in HD-audio :)

Ricardo

>
>
> Takashi
>
