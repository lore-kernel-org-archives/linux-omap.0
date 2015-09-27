From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for
 McASP3
Date: Sun, 27 Sep 2015 07:02:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1794738674-1443337346=:7947"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1794738674-1443337346=:7947
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter,

a few comments:

On Tue, 15 Sep 2015, Peter Ujfalusi wrote:

> McASP3 is used by default on DRA7x based boards for audio.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Paul,
>=20
> this patch is part of my earlier series and as Tony suggested I'll resend=
 the
> hwmod patch for you to review since I missed you from the TO in the serie=
s.
>=20
> The original series:
> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg119319.html
>=20
> Regards,
> Peter
>=20
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 41 +++++++++++++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-om=
ap2/omap_hwmod_7xx_data.c
> index 562247bced49..c38b7fa30c27 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1298,6 +1298,38 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod =3D {
>  };
> =20
>  /*
> + * 'mcasp' class
> + *
> + */
> +static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc =3D {
> +=09.sysc_offs=09=3D 0x0004,
> +=09.sysc_flags=09=3D SYSC_HAS_SIDLEMODE,
> +=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +=09.sysc_fields=09=3D &omap_hwmod_sysc_type3,
> +};
> +
> +static struct omap_hwmod_class dra7xx_mcasp_hwmod_class =3D {
> +=09.name=09=3D "mcasp",
> +=09.sysc=09=3D &dra7xx_mcasp_sysc,
> +};
> +
> +/* mcasp3 */
> +static struct omap_hwmod dra7xx_mcasp3_hwmod =3D {
> +=09.name=09=09=3D "mcasp3",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "l4per2_clkdm",
> +=09.main_clk=09=3D "mcasp3_ahclkx_mux",

I'd expect this clock to be something derived from mcasp3_aux_gfclk,=20
according to Table 24-408 "Clocks and Resets" of SPRUHZ6.  Could you=20
please doublecheck this?

> +=09.flags=09=09=3D HWMOD_SWSUP_SIDLE,

Is this needed?  If it is, please add a brief comment describing the issue=
=20
or bug that it's working around.

> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +};
> +
> +/*
>   * 'mmc' class
>   *
>   */
> @@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__=
hdmi =3D {
>  =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +/* l4_per2 -> mcasp3 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp3_hwmod,

So this is the low-speed control/register access port, where the MPU=20
writes to the McASP3 config registers...

> +=09.clk=09=09=3D "l3_iclk_div",

=2E.. and thus this interface clock doesn't look right for this port, since=
=20
it's most likely generated from the L4PER2, where this port is connected. =
=20
So it should probably be "l4_iclk_div".
=20
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};

There's another struct omap_hwmod_ocp_if record missing: the high-speed=20
bus-master port that the McASP3 uses to DMA audio data.  This port should=
=20
most likely be clocked with "l3_iclk_div" per Table 24-408 "Clocks and=20
Resets".  This port is also where the registers described in Table 24-555=
=20
"MCASP_DAT Register Summary 3" L3_MAIN column are exposed.  You've got=20
that address map range blocked out in your DT data reg property, and=20
associated with this device, right? 0x46000000?

> +
>  static struct omap_hwmod_addr_space dra7xx_elm_addrs[] =3D {
>  =09{
>  =09=09.pa_start=09=3D 0x48078000,
> @@ -3338,6 +3378,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_i=
fs[] __initdata =3D {
>  =09&dra7xx_l4_wkup__dcan1,
>  =09&dra7xx_l4_per2__dcan2,
>  =09&dra7xx_l4_per2__cpgmac0,
> +=09&dra7xx_l4_per2__mcasp3,
>  =09&dra7xx_gmac__mdio,
>  =09&dra7xx_l4_cfg__dma_system,
>  =09&dra7xx_l3_main_1__dss,
> --=20
> 2.5.0
>=20


- Paul
--843723315-1794738674-1443337346=:7947--
