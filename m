From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
	fix
Date: Fri, 20 Nov 2009 09:51:13 +0200
Message-ID: <200911200951.13181.peter.ujfalusi@nokia.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	<bd7b27490911182334r7b9b4682o29a094e8ee521bc5@mail.gmail.com>
	<2ee9e08d0911191148x9da6112s960a283a7cffea7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2ee9e08d0911191148x9da6112s960a283a7cffea7b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Wang,
	Jane" <jwang@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 19 November 2009 21:48:26 ext Anuj Aggarwal wrote:
> [Anuj] Yes, w/o audio, it goes into suspend neatly.
> After going through the entire patch series "[PATCHv5 00/20] OMAP
> ASoC changes in DMA utilization", which I missed earlier, I found that the
> sysfs entry dma_op_mode can be toggled among element/frame/threshold,
> by default which is element hence not allowing the mcbsp driver to go into
> idle state. I changed that at run time and after that I am able to hit
> the suspend
> state while playing back audio (at least the log doesn't
> show that the system is not able to hit suspend).
> My question is: is sysfs the only way to choose threshold or can it be ma=
de
>  as default? I could not see that happening in the code so thinking of the
>  possible reason of choosing not to do so. Because the user who wants to
>  hit suspend will not like to issue driver specific commands. Any specific
>  reason of not doing that by default?

It is not selected as default on OMAP3, since it is a new feature, and we d=
on't =

want to change the behavior of the audio. If the reports are positive regar=
ding =

to the threshold mode, than we can make it as default on OMAP3, at least th=
at is =

the plan AFAIK. =

In some cases the element mode is desirable over the threshold mode, and =

probably there are additional modes can be implemented for other cases, hen=
ce =

the sysfs interface is really useful feature.

Back than there were quite a bit of discussion here about the threshold mod=
e: in =

the original series the threshold mode was the default, but we decided to n=
ot to =

do that before others have the chance to test it. We have been using the =

threshold mode without issues internally, so it should be really stable, bu=
t it =

is still a new mode, which can break other implementations.

So please test the threshold mode in your HW, and report if it is working t=
here =

OK, if we have enough positive feedbacks, than we can make it as default.

-- =

P=E9ter
