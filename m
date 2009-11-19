From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
	fix
Date: Fri, 20 Nov 2009 01:18:26 +0530
Message-ID: <2ee9e08d0911191148x9da6112s960a283a7cffea7b@mail.gmail.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	<20091114102024.b5c302bb.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A9CABBE@dbde02.ent.ti.com>
	<bd7b27490911182334r7b9b4682o29a094e8ee521bc5@mail.gmail.com>
Reply-To: anuj.aggarwal@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <bd7b27490911182334r7b9b4682o29a094e8ee521bc5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>, "Wang,
	Jane" <jwang@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 19, 2009 at 1:04 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Wed, Nov 18, 2009 at 8:28 PM, Aggarwal, Anuj <anuj.aggarwal@ti.com>wrote:
>
>> > If no API or feature would require active McBSP block before the
>> > omap_mcbsp_start call, then the clock management could be done inside
>> > the omap_mcbsp_start/-stop functions.
>> [Aggarwal, Anuj] I tried doing that but it didn't work because before
>> _start, we need to call set_hw_params which configures mcbsp, for which
>> clocks are required.
>> >
>>
>
> First modification to .../plat-omap/mcbsp.c could be just a patch which
> keeps the
> clocks on only when needed. I.e. keep them disabled when returning from
> request
> and activate them only when accessing the McBSP registers or when it is
> running.
>
> But that said, I don't know are there some use case or API which requires
> active
> clocks after request so that should be checked.
>
>
>> > Also context save/restore operations belongs more to PM callbacks
>> > of .../plat-omap/mcbsp.c. Or probably that can be done also dynamically
>> > inside the omap_mcbsp_start/-stop for keeping the whole McBSP shutdown
>> > whenever it is idle.
>> [Aggarwal, Anuj] I am sorry I couldn't understand that. Did you mean that
>> PM hooks can be added in the mcbsp driver which can be registered and
>> called
>> As and when required? Any reference driver for this, if my understanding
>> is correct?
>> >
>>
>
> Yep, the PM hooks in .../plat-omap/mcbsp.c should take care of saving the
> McBSP registers before going into suspend or restore them back when
> resuming.
> This would be second patch after the clock change patch.
>
> The comment about dynamic PM was an idea that if McBSP could be unpowered
> whenever it's not running and do the resume only when calling
> omap_mcbsp_start.
> But that would be some future improvements after basic suspend/resume
> functionality.
>
>> I think it's worth to look McBSP register cache concept [1] from Janusz
>> > Krzysztofik would it help all of this context save/restore operations.
>> [Aggarwal, Anuj] I tried these two patches on omap3 evm but they didn't
>> work for me. The system doesn't go to the suspend state when I do:
>> echo mem > /sys/power/state
>> And the culprits were core (think sdma) and per domain. I tried
>> disabling the mcbsp i/f clock as well but it didn't help. On mcbsp
>> register dump, I couldn't find the sysconfig register getting
>> configured. Could that be the root cause?
>>
>
> Does it go into suspend if the audio is not running (i.e. McBSP not
> requested) or
> if you don't even compile the McBSP support? I haven't looked are there
> checks
> for active clocks in PM core but PM is easier to start with bare minimum and
> to
> see that system can do suspend/resume and then add more features one by one.
[Anuj] Yes, w/o audio, it goes into suspend neatly.
After going through the entire patch series "[PATCHv5 00/20] OMAP
ASoC changes in DMA utilization", which I missed earlier, I found that the
sysfs entry dma_op_mode can be toggled among element/frame/threshold,
by default which is element hence not allowing the mcbsp driver to go into
idle state. I changed that at run time and after that I am able to hit
the suspend
state while playing back audio (at least the log doesn't
show that the system is not able to hit suspend).
My question is: is sysfs the only way to choose threshold or can it be made as
default? I could not see that happening in the code so thinking of the possible
reason of choosing not to do so. Because the user who wants to hit suspend
will not like to issue driver specific commands. Any specific reason of not
doing that by default?
>
> --
> Jarkko
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Best Regards,
Anuj Aggarwal
