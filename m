From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
 fix
Date: Thu, 24 Dec 2009 18:46:42 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E43A@dbde02.ent.ti.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	<bd7b27490911182334r7b9b4682o29a094e8ee521bc5@mail.gmail.com>
	<2ee9e08d0911191148x9da6112s960a283a7cffea7b@mail.gmail.com>
	<200911200951.13181.peter.ujfalusi@nokia.com>
	<20091120155343.baf0b9d3.jhnikula@gmail.com>
	<1258726156.6157.11.camel@eenurkka-desktop>
	<2ee9e08d0911200647o33a57e45j1bb4de6d9604d29a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Jane" <jwang@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Aggarwal, Anuj
> Sent: Monday, November 30, 2009 5:21 PM
> To: ext-eero.nurkkala@nokia.com
> Cc: ext Jarkko Nikula; alsa-devel@alsa-project.org; Wang, Jane;
> broonie@opensource.wolfsonmicro.com; Ujfalusi Peter (Nokia-D/Tampere);
> linux-omap@vger.kernel.org
> Subject: RE: [alsa-devel] [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
> fix
> 
> > > Looking at the very original patch, I don't know how things could get
> > > into deep sleep by disabling the fclk only... need to disable the iclk
> > > also. In threshold mode, HW autogates the iclk, so you may be just
> > > "lucky".
> > [Anuj] No, I am not :(. I had to modify the original patch to include
> > the disable part for the ICLK too. Without that, I was not able to hit
> > retention.
> > I will try to do some further regression on OMAP3 EVM and post my
> > findings. As of now, audio is working fine with these patches + ICLK
> > modification.
> [Aggarwal, Anuj] After further testing, I found that there is some
> problem in the capture path. While capturing in background, if I tried
> to do suspend, capture fails after a few seconds giving;
> arecord: pcm_read:1617: read error: Input/output error
> This I was discussing in another thread (*) for AIC23/AM3517 on NFS but
> now
> I realized after finishing my tests that this behavior is common for
> both omap3530/twl4030 and am3517/aic23. Moreover, the problem doesn't
> depend on the underlying file system - both NFS and ramdisk produce the
> same error.
> To make matter worse, if suspend/resume is tried while audio
> loopback is running, system just hangs. Even telnet to the evm doesn't
> work.
> So the audio capture path, from suspend/resume point of view, definitely
> needs some more time.
> I will continue debugging at my end. But pointers are always welcome.
[Aggarwal, Anuj] I think I found one possible root cause of the hang which 
is observed if suspend/resume is tried while audio loopback is going on.

soc_suspend() calls snd_pcm_suspend_all() which calls snd_pcm_suspend() 
for all the substreams in the pcm->streams[]. On debugging, I found that 
I am not able to come out of snd_pcm_suspend_all(). I think this API needs 
some fix as the comment also suggests:
FIXME: the open/close code should lock this as well

Could this be the root cause of this hang? Any pointers on what needs to be
fixed?
