From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS
 driver interface for audio
Date: Fri, 11 May 2012 19:18:44 -0500
Message-ID: <4FADAC64.8090009@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	<1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
	<1336390986.2667.8.camel@deskari> <4FA9B289.5000101@ti.com>
	<1336552081.3962.15.camel@deskari> <4FAB403E.6010000@ti.com>
	<1336636449.5182.26.camel@deskari> <4FAC71E0.2060808@ti.com>
	<1336740693.8751.78.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1336740693.8751.78.camel@deskari>
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

On 05/11/2012 07:51 AM, Tomi Valkeinen wrote:
> On Thu, 2012-05-10 at 20:56 -0500, Ricardo Neri wrote:
>
>> Sorry, some hunks where missing in the patch that I submitted yesterday.
>>
>> I just pushed a branch containing the whole most up-to-date series here:
>>
>> git://gitorious.org/omap-audio/linux-audio.git
>> ricardon/topic/dss_audio-for-tomi
>>
>> This includes the implementation of the DSS audio interface for HDMI
>> covering the improved locking strategy [1][2], plus the missing hunks in
>> my yesterday's patch, plus handling of mode changes you pointed out.
>>
>> Please let me know if you want me to resubmit the whole patch series so
>> that you can comment if you need to.
>
> Thanks, I think this is fine. I had to rebase your branch as you had
> some extra patches there also. There were also a few conflicts with
> latest dss stuff, but nothing serious.
>
> I pushed the branch with latest dss and your branch to:
>
> git://gitorious.org/linux-omap-dss2/linux.git test
>
> With a quick test video works ok, but I didn't test audio.

Thanks for taking the patches! In your branch, the audio part would not 
build with audio enabled as your branch does not have the ALSA CEA-861 
definitions patch [1]. The platform devices for the ASoC HDMI drivers[2] 
are also missing. I put these patches on top of your test branch and 
audio works well. [1] and [2] will come from Takashi's and Tony's branches.

BR,

Ricardo


[1]http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66600.html
[2]http://www.spinics.net/lists/linux-omap/msg68834.html
>
>   Tomi
