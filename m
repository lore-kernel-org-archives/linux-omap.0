From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Audio suspend/resume status on OMAP3 based
 platforms
Date: Fri, 15 Jan 2010 23:30:33 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB8F4@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
	<201001130910.04292.peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB031E1D7A8D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7A8D@dbde02.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> > > I want to check the status of suspend/resume functionality when audio
> > > subsystem is being used. Specifically, has some one tried the
> following
> > > tests on their omap3 based platforms:
> > >
> > > a) echo mem > /sys/power/state, when audio playback is running in
> > > background
> > > b) same command, when audio capture is running in
> > > background
> > > b) same command, when audio loopback is running in
> > > background
> > >
> > > I am facing some issues with (b) & (c) so wanted to confirm whether
> > > someone else has faced similar problem or not.
> >
> > As Jarkko pointed out in a separate mail, we should not expect the
> > suspend/resume to be working correctly until the context save/restore,
> and
> > the
> > clock management is sorted out.
> >
> > On the other hand it seams that the problem is in the capture path (b
> and
> > c
> > having issues).
> >
> > How is the McBSP configured in your setup (master or slave)?
> [Aggarwal, Anuj] TWL4030 is master and McBSP is slave.
> 
> > I think we might have different issues with suspend/resume when OMAP
> McBSP
> > is
> > slave or if it is master.
Few (+)updates from my side:

a) Capture not working after suspend/resume: After taking a dump of
mcbsp, DMA and codec registers and comparing them, I found out that
DMA.CCR[Enable] and DMA.CSR[Sync] bits were set when system was coming out
of suspend. I don't understand why these two bits are not set in case of
playback running in backgnd but when I forcefully clear them in 
omap_pcm_trigger() fn under SNDRV_PCM_TRIGGER_RESUME, my problem goes away.
Now I am able to do suspend/resume successfully while capture is running in bg without getting the Input/output error.

b) McBSP registers being accessed from omap_pcm_trigger(): When audio
playback is running in background and I try suspend, I saw mcbsp registers
getting read/written by omap_pcm_trigger() through 
dma_data->set_threshold(). This happens when soc_pcm_trigger() calls
platform->pcm_ops->trigger before cpu_dai->ops->trigger and the clocks
are getting enabled only in cpu_dai->trigger. Because of this,
I found one warning coming through but this needs a fix.

c) System hangs when audio loopback is going on in background: Finally, I 
was able to narrow down the problem. After the mcbsp clocks are cut for
playback stream, when suspend gets called for capture, mcbsp is stopped
inside omap_mcbsp_dai_trigger->SNDRV_PCM_TRIGGER_PAUSE_PUSH, before
disabling the clocks. This resulted in hang and the system doesn't 
come out of snd_pcm_suspend_all() which I reported in my previous email.
I modified the clock disabling routine and averted the hang. Now the problem
is with the mcbsp/DMA configuration as I am not able to resume the loopback fully (1 in 5 times only it works) and receive this error:

ALSA sound/core/pcm_lib.c:1708: playback write error (DMA or IRQ trouble?)

After this, the application exits gracefully. On further debugging, I 
realized that mcbsp is not getting configured properly on either the
playback or capture stream, while resuming. Hence the error. I think
this problem can go if I apply the mcbsp-register-cache patches but
I have to try that before I can come to a conclusion.

I have (dirty) fixes for (a) and (b) which, on cleaning, I would be
sending for reviews.

Thanks for the suggestions/pointers.
