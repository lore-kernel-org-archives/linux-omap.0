From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS
 driver interface for audio
Date: Wed, 9 May 2012 23:12:46 -0500
Message-ID: <4FAB403E.6010000@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	<1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
	<1336390986.2667.8.camel@deskari> <4FA9B289.5000101@ti.com>
	<1336552081.3962.15.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1336552081.3962.15.camel@deskari>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, research@ottomaneng.com, agraf@suse.de, vaibhav.bedia@ti.com, s-chereau@ti.com, peter.ujfalusi@ti.com, mythripk@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

On 05/09/2012 03:28 AM, Tomi Valkeinen wrote:
> On Tue, 2012-05-08 at 18:55 -0500, Ricardo Neri wrote:
>> Hi Tomi,
>>
>> Thanks for taking the time to comment.
>>
>> On 05/07/2012 06:43 AM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On Thu, 2012-05-03 at 20:44 -0500, Ricardo Neri wrote:
>>>> Implement the DSS device driver audio support interface in the HDMI
>>>> panel driver and generic driver. The implementation relies on the
>>>> IP-specific functions that are defined at DSS probe time.
>>>>
>>>> At the moment, a hardirq-safe spinlock is used to protect the audio
>>>> functions. This is because such functions might be called while
>>>> holding a lock (this especially true for audio_start/stop). For the
>>>> rest of the audio functions, a mutex could be used in the future as
>>>> the enablement of resources might take too much time.
>>>
>>> The series looks good, except locking. Granted, the locking in omapdss
>>> is a bit bad generally also, but here I think it's a bit more broken.
>>>
>>> For example, hdmi_panel.c:hdmi_panel_audio_supported() takes the audio
>>> lock, and then uses variables like dssdev->state, and the hdmi video
>>> mode. However, the video functions do not use audio lock, so effectively
>>> the lock doesn't protect at all.
>>
>> Yes, it does not protect.
>>>
>>> I'm not sure how to fix it, though. I think this shows the shortcomings
>>> of the current locking strategy (or lack of =). What if the audio
>
> Btw, I meant shortcomings in the general DSS locking strategy, not the
> locking in this particular patch.
>
>>> functions that can sleep would take the hdmi panel's mutex, and also the
>>> audio spinlock? That would at least fix some of the cases.
>>
>> But if the function can sleep, protecting it with the HDMI panel's mutex
>> should be enough, shouldn't it? Wouldn't it be pointless to also hold
>> the spinlock?
>
> If the start/stop functions use the spinlock, but not the mutex, then
> the sleeping functions should also use the spinlock to prevent touching
> the same data at the same time.
>
>> Ideally, I think, only one lock, the HDMI panel's mutex, should be
>> enough to protect the HDMI panel's functions, including the audio
>> functions. Reusing the HDMI panel's mutex for the audio functions would
>> prevent the situation you describe regarding
>> hdmi_panel.c:hdmi_panel_audio_supported()... and the spinlock would not
>> be required.
>>
>> The only functions that cause problems with this approach are
>> audio_start/stop as ALSA calls them while holding a spinlock. The
>> spinlock could be used for these as they dont read or write the panel's
>> variables.
>
> Locks always protect a particular piece of data. What is the data in
> this case, if not panel's variables? DSS registers?
Yes, in this case, it protects access to HDMI IP registers.

I just implemented an improved locking strategy. I included a new 
variable to monitor the audio state, this will be protected by the audio 
lock.

This is the new implementation:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68409.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68411.html

>
>> However, holding a spinlock only when start/stopping audio would fail,
>> for instance, if someone starts/stops audio while enabling or
>> configuring audio; but that would be an issue in the design of the
>> component using DSS HDMI audio, wouldn't be? To prevent that, an
>
> I guess it's up to us to decide what is the supposed use-patter of the
> functions =). For dss functions in general it's pretty vague and
> non-defined. But we could start here with audio functions and define
> that the audio functions may not be called from multiple threads at the
> same time. That would remove any issues with concurrent calls to audio
> functions, presuming the audio side actually conforms to this =).

Under the new strategy, in addition to not allowing the audio functions 
to be called from multiple threads, audio functions will fail if the 
sequence _CONFIGURED -> _ENABLED -> PLAYING -> DISABLED is not followed. 
This is aligned with the behavior that ALSA follows for the audio 
codecs. Also, it checks the state of the panel to allow the audio 
transitions.
>
> But the video and audio paths are probably always separate, and for
> those we need protection. As you said, using the mutex for the may-sleep
> audio functions solves the issue for those, leaving start/stop as the
> only problem case.

Audio only needs to know if the display is active. Under the improved 
strategy, audio_start indirectly checks the state of the panel because 
the audio needs to be in AUDIO_ENABLED state to start and this state is 
reached only if the panel is active. The mutex is held to check the 
state of the panel and the audio lock is held to change the audio state. 
Also, the audio transitions to AUDIO_DISABLED if the panel is disabled. 
Therefore, I think, this should ensure that the panel is active when 
starting audio.
>
> However, even if we could protect start/stop with locks, we still have a
> problem (which is general problem related to dss locking): we don't have
> any protection between the function calls. So basically this could
> happen:
>
> [video thread] setup video&  enable
> [audio thread] check that all is ok, and configure audio
> [video thread] change video config or disable video
> [audio thread] start_audio ->  fails, because video config no longer
> valid for audio

Under the improved locking strategy, at least it does not fail silently. 
The video thread will disable audio (while holding the audio lock) and, 
when the audio thread gains the lock, audio_start will fail because it 
is in an invalid state. The error is reported to the audio user where it 
can be handled properly(e.g., it can reconfigure and try again).

>
> But I guess we have to accept that the locking is not perfect, and try
> to solve it properly later, as it's a bigger, dss-wide change.

Another piece that is missing is the notify mechanism to let know the 
audio user that the panel was disabled or the video configuration changed.
>
>   Tomi
