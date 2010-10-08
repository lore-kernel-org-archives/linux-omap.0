From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx devices
Date: Fri, 8 Oct 2010 11:50:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CF13384@dbde02.ent.ti.com>
 <201010061017.13908.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48686 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab0JHGUg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 02:20:36 -0400
In-Reply-To: <201010061017.13908.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kamat, Nishant" <nskamat@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Girdwood, Liam" <x0135381@ti.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>



> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Wednesday, October 06, 2010 12:47 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org; Kamat,
> Nishant; Datta, Shubhrajyoti; Basak, Partha; Girdwood, Liam;
> jhnikula@gmail.com; broonie@opensource.wolfsonmicro.com; ABRAHAM, KIS=
HON
> VIJAY
> Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx
> devices
>=20
> Hello,

Thanks for the quick response.

>=20
> On Wednesday 06 October 2010 10:01:28 ext Varadarajan, Charulatha wro=
te:
> > This patch series is targeted to implement mcbsp driver in
> > hwmod way and to make use of pm_runtime APIs.
> >
> > This patch series is tested on OMAP3 & 4 and yet to be tested
> > on OMAP2.
> >
> > There are few clarifications required so that the next patch series
> > can be implemented after aligning.
> >
> > 1. Audio layer is making use of mcbsp and it's dma base addresses a=
nd
> > is closely coupled with omap-mcbsp.
> > This can be handled either by
> > a. providing an API with which Audio layer can get these addresses.
> > (or)
> > b. move the plat-omap/mcbsp.c and mach-omap2/mcbsp.c to sound/soc/o=
map/
> > [1]
> >
> > Option (a) would only be a workaround to handle the situation. As
> > audio is the only user for mcbsp, option (b) is better. If option(b=
)
> > is agreed upon, the same can be addressed on top of the mcbsp hwmod
> > series.
>=20
> it is true that at the moment only audio is using the McBSP ports, bu=
t
> McBSP is
> really flexible, it can run for example in SPI mode, and it can be
> configured to
> use other serial protocols.

Yes.

> I would go with option c.
> Since ASoC is moving to multi-component (the conversion is already in
> linux-
> next), this means that the sound/soc/omap/omap-mcbsp, omap-pcm driver=
s are
> platform drivers.
> So if the plat-omap/mcbsp would register the platform device for McBS=
P
> clients
> (we have only ASoC client at the moment), and use platform data to pa=
ss
> the
> needed information to the McBSP client driver, than we do not need ne=
w API.

Sorry I am confused.

With hwmod implementation, there is a device register code for mcbsp
devices in mach-omap2/mcbsp.c and a probe in plat-omap/mcbsp.c. The bas=
e
address, dma info are not part of pdata and are available to the driver
only after probe. I do not understand how the multi-component design in
ASOC can avoid the new API.

Also with this multi-component approach in ASOC, two device
registrations happens for a single mcbsp device with two different
rames ("omap-mcbsp-dai.id" & "omap-mcbsp.id"). Please explain if this
what is expected?

> We still need to modify the ASoC drivers to make use of this platform=
 data,
> but
> at least we are going to keep the door open for others to use the McB=
SP
> ports
> for other than audio.

Agreed. But the current omap-mcbsp driver cannot work standalone for
OMAP3/4 due to the issues stated below:
1. omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access McBSP
registers as 16-bit. But in OMAP3/4, McBSP registers (DRR_REG and DXR_R=
EG)
are limited to 32-bit data accesses and hence poll mode would not work =
[x].
2. DMA transfers would also not work as it requires a patch similar to =
[y].

Patches [x] & [y] were rejected as there are no users other than asoc.
If it is not agreed to move omap-mcbsp driver to asoc layer, we need to
get the omap-mcbsp driver working as a standalone driver. Otherwise it
is of no use keeping the mcbsp driver in plat-omap.

Once [x] & [y] patches are upstreamed, audio layer needs to be modified
to make use of omap-mcbsp APIs rather than Audio layer calling dma
APIs directly to transfer data.

Coming back to the original question. Either we need to fix the broken
legacy mcbsp driver or move the omap-mcbsp driver completely to asoc
layer. What do you say?

[x] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19531.htm=
l
[y] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04085.htm=
l
>=20
> > 2. Sidetone feature is available only in OMAP3 (McBSP2&3) which has
> > different base address and sys configs compared to it's mcbsp port.
> > Hence the mcbsp is considered as a single device with two hwmods
> > for McBSP2&3 devices in OMAP3.
>=20
> Sounds fair enough.

Thanks.

>=20
> > 3. Autoidle needs to be disabled for sidetone before enabling the
> sidetone
> > feature. There was a design proposed by Kishon [2] to add an API in
> hwmod
> > to modify the autoidle bit but was not agreed upon. How do we handl=
e
> this
> > situation where the device has to disable or enable the autoidle bi=
t at
> > runtime?
>=20
> Yeah, this is really annoying problem. The McBSP ST should block auto=
idle
> from
> McBSP side, but it does not.
> If you can not get through the proposed API, we should consider to sw=
itch
> the
> corresponding McBSP port to NoIdle, when the ST is in use (and restor=
e the
> idle
> mode, when the ST has been disabled).
> When McBSP is in NoIdle the interface clock is not going to be gated,=
 so
> ST
> block will be running without a problem (ST needs the iface clock for
> operation)
>=20
> What do you think?

I think it might not be possible to handle this, as the clocks are the =
same for ST and mcbsp port. pm_runtime APIs are not called during ST en=
able/disable as clocks are already enabled while enabling mcbsp port. H=
ence the idle bit change cannot happen even if the oh->flags are modifi=
ed runtime during ST enable/disable.

> >
> > [1] https://patchwork.kernel.org/patch/225582/
> > [2] https://patchwork.kernel.org/patch/134371/
> >
> > We would resend the same patch series by including alsa mailing lis=
t
> > (alsa-devel@alsa-project.org)
> >
> > <<snip>>
>=20
> --
> P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
