From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx devices
Date: Thu, 14 Oct 2010 20:21:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D09A248@dbde02.ent.ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
 <201010061017.13908.peter.ujfalusi@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
 <201010131131.49967.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45748 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab0JNOv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 10:51:26 -0400
In-Reply-To: <201010131131.49967.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kamat, Nishant" <nskamat@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Girdwood, Liam" <x0135381@ti.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

=20

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]=20
> Sent: Wednesday, October 13, 2010 2:02 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org;=20
> Kamat, Nishant; Datta, Shubhrajyoti; Basak, Partha; Girdwood,=20
> Liam; jhnikula@gmail.com;=20
> broonie@opensource.wolfsonmicro.com; ABRAHAM, KISHON VIJAY
> Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database=20
> for 2xxx devices
>=20
> Hi,
>=20
> On Friday 08 October 2010 09:20:19 ext Varadarajan, Charulatha wrote:
> > Sorry I am confused.
> >=20
> > With hwmod implementation, there is a device register code for mcbs=
p
> > devices in mach-omap2/mcbsp.c and a probe in=20
> plat-omap/mcbsp.c. The base
> > address, dma info are not part of pdata and are available=20
> to the driver
> > only after probe. I do not understand how the=20
> multi-component design in
> > ASOC can avoid the new API.
> >=20
> > Also with this multi-component approach in ASOC, two device
> > registrations happens for a single mcbsp device with two different
> > rames ("omap-mcbsp-dai.id" & "omap-mcbsp.id"). Please=20
> explain if this
> > what is expected?
>=20
> I have given myself some time to think this over...

Thanks Peter.

> I think the best way forward is to provide an API from=20
> plat-omap/mcbsp.c for=20
> client drivers (like ASoC audio) to ask for the needed=20
> configuration (the things=20
> that is 'hard wired' in soc/omap/omap-mcbsp.c at the monent).
> Something like omap-mcbsp-get-config(id, &config);

Agreed.

>=20
> In this way we can keep the door open for other uses of McBSP=20
> if ever needed.

Okay.

>=20
> > > We still need to modify the ASoC drivers to make use of=20
> this platform
> > > data, but
> > > at least we are going to keep the door open for others to=20
> use the McBSP
> > > ports
> > > for other than audio.
> >=20
> > Agreed. But the current omap-mcbsp driver cannot work standalone fo=
r
> > OMAP3/4 due to the issues stated below:
> > 1. omap_mcbsp_pollwrite and omap_mcbsp_pollread functions=20
> access McBSP
> > registers as 16-bit. But in OMAP3/4, McBSP registers=20
> (DRR_REG and DXR_REG)
> > are limited to 32-bit data accesses and hence poll mode=20
> would not work [x].
>=20
> Yes, this need to be fixed, but it can be done later, it does=20
> not need to be=20
> part of the hwmod series.

Okay.

>=20
> > 2. DMA transfers would also not work as it requires a patch=20
> similar to [y].
>=20
> Well, this patch was sent in 2008. nowdays we moved the OMAP=20
> audio support to=20
> ASoC, and there are no 'legacy' ALSA arm/omap drivers anymore.
> In ASoC the cpu_dai and the platform drivers are separate things.
> This allows us to use the same platform driver (omap-pcm) for=20
> McBSp, McPDM (and=20
> in theory we could have OMAP2 EAC) cpu_dai drivers without=20
> duplicating code.
> As a note: most of the features this patch was trying to=20
> implement is already=20
> done for the ASoC implementation, but if there is need for=20
> new features, it has=20
> to be done using the ASoC framework.

If we do this, would it not contradict the idea of keeping the door
open for others to use the McBSP ports?

If other users should be allowed to use McBSP ports, it is good to
have DMA support in plat-omap/mcbsp.c itself and modify the asoc
implementation to take advantage of the proposed new mcbsp
design. If agreed, this shall be addressed later. Please let
me know your thoughts on this.

>=20
> > Coming back to the original question. Either we need to fix=20
> the broken
> > legacy mcbsp driver or move the omap-mcbsp driver completely to aso=
c
> > layer. What do you say?
>=20
> I would keep the partitioning same as it is now.

Okay.

> If there is a reason we can add bus driver functionality to=20
> McBSP,

Can you elaborate? mcbsp driver is already following platform bus
device model.

> but at the=20
> moment there is no need for that.

=46or testing any changes in mcbsp driver (including hwmod), we are
relying on internal patches (dma/pollmode patches). Instead, if=20
mcbsp dma support is available in the driver itself, it would be
useful for bug fixing/development activities.

> =20
> --=20
> P=E9ter
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
