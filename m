From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS
 driver interface for audio
Date: Thu, 10 May 2012 20:56:48 -0500
Message-ID: <4FAC71E0.2060808@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	<1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
	<1336390986.2667.8.camel@deskari> <4FA9B289.5000101@ti.com>
	<1336552081.3962.15.camel@deskari> <4FAB403E.6010000@ti.com>
	<1336636449.5182.26.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1336636449.5182.26.camel@deskari>
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

On 05/10/2012 02:54 AM, Tomi Valkeinen wrote:
> On Wed, 2012-05-09 at 23:12 -0500, Ricardo Neri wrote:
>
>> Under the new strategy, in addition to not allowing the audio functions
>> to be called from multiple threads, audio functions will fail if the
>> sequence _CONFIGURED ->  _ENABLED ->  PLAYING ->  DISABLED is not followed.
>> This is aligned with the behavior that ALSA follows for the audio
>> codecs. Also, it checks the state of the panel to allow the audio
>> transitions.
>>>
>>> But the video and audio paths are probably always separate, and for
>>> those we need protection. As you said, using the mutex for the may-sleep
>>> audio functions solves the issue for those, leaving start/stop as the
>>> only problem case.
>>
>> Audio only needs to know if the display is active. Under the improved
>
> Audio also needs to know if the video mode is suitable for audio, right?
> So not only disabling the video has to stop audio, but also if the video
> mode changes to a non-supported one.

Yes. I overlooked the mode changes. Audio has to be stopped at any mode 
change or timings change because the audio regeneration clock params 
need to be recalculated. I think resuming audio, if possible, should be 
done by the user, which should be notified of the mode change.
>
>> strategy, audio_start indirectly checks the state of the panel because
>> the audio needs to be in AUDIO_ENABLED state to start and this state is
>> reached only if the panel is active. The mutex is held to check the
>> state of the panel and the audio lock is held to change the audio state.
>> Also, the audio transitions to AUDIO_DISABLED if the panel is disabled.
>
> Hmm, I can't see the code that does that. As far as I see, no video
> enable/disable/reconfig affects audio in any way. Am I missing a patch?
> Could you setup a public git branch so it's easier for me to get the
> whole series, instead of sending individual patches.

Sorry, some hunks where missing in the patch that I submitted yesterday.

I just pushed a branch containing the whole most up-to-date series here:

git://gitorious.org/omap-audio/linux-audio.git 
ricardon/topic/dss_audio-for-tomi

This includes the implementation of the DSS audio interface for HDMI 
covering the improved locking strategy [1][2], plus the missing hunks in 
my yesterday's patch, plus handling of mode changes you pointed out.

Please let me know if you want me to resubmit the whole patch series so 
that you can comment if you need to.

BR,

Ricardo

[1] http://www.spinics.net/lists/linux-omap/msg70059.html
[2] http://www.spinics.net/lists/linux-omap/msg70057.html

>
>   Tomi
