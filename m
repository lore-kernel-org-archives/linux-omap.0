From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for
	2xxx devices
Date: Fri, 15 Oct 2010 10:13:49 +0300
Message-ID: <201010151013.49990.peter.ujfalusi@nokia.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
	<201010131131.49967.peter.ujfalusi@nokia.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D09A248@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D09A248@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Varadarajan, Charulatha" <charu@ti.com>
Cc: "Girdwood, Liam" <x0135381@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kamat, Nishant" <nskamat@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "ABRAHAM,
	KISHON VIJAY" <kishon@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 14 October 2010 17:51:15 ext Varadarajan, Charulatha wrote:

> > Yes, this need to be fixed, but it can be done later, it does
> > not need to be
> > part of the hwmod series.
> =

> Okay.

This problem there for a long time, and so far no one complained, or fixed =
it.
Probably there are no users for pollread/write at all, but I would not remo=
ve =

the functionality. It is better to fix them later.
 =

> > > 2. DMA transfers would also not work as it requires a patch
> > =

> > similar to [y].
> > =

> > Well, this patch was sent in 2008. nowdays we moved the OMAP
> > audio support to
> > ASoC, and there are no 'legacy' ALSA arm/omap drivers anymore.
> > In ASoC the cpu_dai and the platform drivers are separate things.
> > This allows us to use the same platform driver (omap-pcm) for
> > McBSp, McPDM (and
> > in theory we could have OMAP2 EAC) cpu_dai drivers without
> > duplicating code.
> > As a note: most of the features this patch was trying to
> > implement is already
> > done for the ASoC implementation, but if there is need for
> > new features, it has
> > to be done using the ASoC framework.
> =

> If we do this, would it not contradict the idea of keeping the door
> open for others to use the McBSP ports?

Why? If you add support for different sample formats to ASoC, it will not c=
hange =

anything.
 =

> If other users should be allowed to use McBSP ports, it is good to
> have DMA support in plat-omap/mcbsp.c itself and modify the asoc
> implementation to take advantage of the proposed new mcbsp
> design. If agreed, this shall be addressed later. Please let
> me know your thoughts on this.

What I mean is that later we could add DMA transfer functionality if there =
is a =

need, but at the moment I don't see any reason to do that.
Also moving the DMA functionality to plat-omap/mcbsp.c would require quite =
a big =

change in there, and as well in the ASoC code. On top of that we will broke=
 the =

sound/soc/omap/omap-pcm.c to be McBSP independent, and that is one of the m=
ain =

points here. We are using omap-pcm.c with McBSP and McPDM dai drivers. That=
 has =

to remain the same.
In the future we can implement DMA transfer capabilities to mcbsp.
I would not do this as part of hwmod either.
I think such an extension to the current McBSP code is only needed if/when =
we =

have other users for McBSP than audio.

> > > Coming back to the original question. Either we need to fix
> > =

> > the broken
> > =

> > > legacy mcbsp driver or move the omap-mcbsp driver completely to asoc
> > > layer. What do you say?
> > =

> > I would keep the partitioning same as it is now.
> =

> Okay.
> =

> > If there is a reason we can add bus driver functionality to
> > McBSP,
> =

> Can you elaborate? mcbsp driver is already following platform bus
> device model.

I meant adding DMA functionality to McBSP. I would not worry about this at =
this =

time.

> =

> > but at the
> > moment there is no need for that.
> =

> For testing any changes in mcbsp driver (including hwmod), we are
> relying on internal patches (dma/pollmode patches). Instead, if
> mcbsp dma support is available in the driver itself, it would be
> useful for bug fixing/development activities.

You should use audio (ASoC) for verification, for example Beagle, or other =

board. I would say that the audio support is solid on OMAP platforms, and t=
hat =

is the main thing which must work after hwmod conversion.

-- =

P=E9ter
