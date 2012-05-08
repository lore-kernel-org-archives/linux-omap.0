From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS
 driver interface for audio
Date: Tue, 8 May 2012 18:55:53 -0500
Message-ID: <4FA9B289.5000101@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	<1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
	<1336390986.2667.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1336390986.2667.8.camel@deskari>
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

Hi Tomi,

Thanks for taking the time to comment.

On 05/07/2012 06:43 AM, Tomi Valkeinen wrote:
> Hi,
>
> On Thu, 2012-05-03 at 20:44 -0500, Ricardo Neri wrote:
>> Implement the DSS device driver audio support interface in the HDMI
>> panel driver and generic driver. The implementation relies on the
>> IP-specific functions that are defined at DSS probe time.
>>
>> At the moment, a hardirq-safe spinlock is used to protect the audio
>> functions. This is because such functions might be called while
>> holding a lock (this especially true for audio_start/stop). For the
>> rest of the audio functions, a mutex could be used in the future as
>> the enablement of resources might take too much time.
>
> The series looks good, except locking. Granted, the locking in omapdss
> is a bit bad generally also, but here I think it's a bit more broken.
>
> For example, hdmi_panel.c:hdmi_panel_audio_supported() takes the audio
> lock, and then uses variables like dssdev->state, and the hdmi video
> mode. However, the video functions do not use audio lock, so effectively
> the lock doesn't protect at all.

Yes, it does not protect.
>
> I'm not sure how to fix it, though. I think this shows the shortcomings
> of the current locking strategy (or lack of =). What if the audio
> functions that can sleep would take the hdmi panel's mutex, and also the
> audio spinlock? That would at least fix some of the cases.

But if the function can sleep, protecting it with the HDMI panel's mutex 
should be enough, shouldn't it? Wouldn't it be pointless to also hold 
the spinlock?

Ideally, I think, only one lock, the HDMI panel's mutex, should be 
enough to protect the HDMI panel's functions, including the audio 
functions. Reusing the HDMI panel's mutex for the audio functions would 
prevent the situation you describe regarding 
hdmi_panel.c:hdmi_panel_audio_supported()... and the spinlock would not 
be required.

The only functions that cause problems with this approach are 
audio_start/stop as ALSA calls them while holding a spinlock. The 
spinlock could be used for these as they dont read or write the panel's 
variables.

However, holding a spinlock only when start/stopping audio would fail, 
for instance, if someone starts/stops audio while enabling or 
configuring audio; but that would be an issue in the design of the 
component using DSS HDMI audio, wouldn't be? To prevent that, an 
audio_configured state variable in the HDMI panel could be used to 
monitor that audio is started only after it is enabled and configured. 
In that case, both the spinlock and the mutex would be required, as you 
propose, because audio_configured would be read inside audio_start/stop.

BR,

Ricardo

>
>   Tomi
