From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for
	2xxx devices
Date: Wed, 13 Oct 2010 11:31:49 +0300
Message-ID: <201010131131.49967.peter.ujfalusi@nokia.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
	<201010061017.13908.peter.ujfalusi@nokia.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
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

Hi,

On Friday 08 October 2010 09:20:19 ext Varadarajan, Charulatha wrote:
> Sorry I am confused.
> =

> With hwmod implementation, there is a device register code for mcbsp
> devices in mach-omap2/mcbsp.c and a probe in plat-omap/mcbsp.c. The base
> address, dma info are not part of pdata and are available to the driver
> only after probe. I do not understand how the multi-component design in
> ASOC can avoid the new API.
> =

> Also with this multi-component approach in ASOC, two device
> registrations happens for a single mcbsp device with two different
> rames ("omap-mcbsp-dai.id" & "omap-mcbsp.id"). Please explain if this
> what is expected?

I have given myself some time to think this over...
I think the best way forward is to provide an API from plat-omap/mcbsp.c fo=
r =

client drivers (like ASoC audio) to ask for the needed configuration (the t=
hings =

that is 'hard wired' in soc/omap/omap-mcbsp.c at the monent).
Something like omap-mcbsp-get-config(id, &config);

In this way we can keep the door open for other uses of McBSP if ever neede=
d.

> > We still need to modify the ASoC drivers to make use of this platform
> > data, but
> > at least we are going to keep the door open for others to use the McBSP
> > ports
> > for other than audio.
> =

> Agreed. But the current omap-mcbsp driver cannot work standalone for
> OMAP3/4 due to the issues stated below:
> 1. omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access McBSP
> registers as 16-bit. But in OMAP3/4, McBSP registers (DRR_REG and DXR_REG)
> are limited to 32-bit data accesses and hence poll mode would not work [x=
].

Yes, this need to be fixed, but it can be done later, it does not need to b=
e =

part of the hwmod series.

> 2. DMA transfers would also not work as it requires a patch similar to [y=
].

Well, this patch was sent in 2008. nowdays we moved the OMAP audio support =
to =

ASoC, and there are no 'legacy' ALSA arm/omap drivers anymore.
In ASoC the cpu_dai and the platform drivers are separate things.
This allows us to use the same platform driver (omap-pcm) for McBSp, McPDM =
(and =

in theory we could have OMAP2 EAC) cpu_dai drivers without duplicating code.
As a note: most of the features this patch was trying to implement is alrea=
dy =

done for the ASoC implementation, but if there is need for new features, it=
 has =

to be done using the ASoC framework.

> Coming back to the original question. Either we need to fix the broken
> legacy mcbsp driver or move the omap-mcbsp driver completely to asoc
> layer. What do you say?

I would keep the partitioning same as it is now.
If there is a reason we can add bus driver functionality to McBSP, but at t=
he =

moment there is no need for that.
 =

-- =

P=E9ter
