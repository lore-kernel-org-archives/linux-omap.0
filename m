From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for
 McASP3
Date: Fri, 2 Oct 2015 09:07:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1510020854390.11596@utopia.booyaka.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com> <560BB434.6080308@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-995284589-1443776169=:11596"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <560BB434.6080308@ti.com>
Content-ID: <alpine.DEB.2.02.1510020856190.11596@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-995284589-1443776169=:11596
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1510020856191.11596@utopia.booyaka.com>

Hello P=E9ter,

On Wed, 30 Sep 2015, Peter Ujfalusi wrote:

> On 09/27/2015 10:02 AM, Paul Walmsley wrote:
> >>  /*
> >> + * 'mcasp' class
> >> + *
> >> + */
> >> +static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc =3D {
> >> +=09.sysc_offs=09=3D 0x0004,
> >> +=09.sysc_flags=09=3D SYSC_HAS_SIDLEMODE,
> >> +=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> >> +=09.sysc_fields=09=3D &omap_hwmod_sysc_type3,
> >> +};
> >> +
> >> +static struct omap_hwmod_class dra7xx_mcasp_hwmod_class =3D {
> >> +=09.name=09=3D "mcasp",
> >> +=09.sysc=09=3D &dra7xx_mcasp_sysc,
> >> +};
> >> +
> >> +/* mcasp3 */
> >> +static struct omap_hwmod dra7xx_mcasp3_hwmod =3D {
> >> +=09.name=09=09=3D "mcasp3",
> >> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> >> +=09.clkdm_name=09=3D "l4per2_clkdm",
> >> +=09.main_clk=09=3D "mcasp3_ahclkx_mux",
> >=20
> > I'd expect this clock to be something derived from mcasp3_aux_gfclk,=20
> > according to Table 24-408 "Clocks and Resets" of SPRUHZ6.  Could you=20
> > please doublecheck this?
>=20
> I can not explain this. If I change the main_clk to "mcasp3_aux_gfclk_mux=
"
> then I can not access to McASP3 register at all.
> I don't see anything popping out in the clock data, nor in other places.

OK thank you for testing that.  Maybe just add a brief comment along those=
=20
lines in the hwmod data, above the structure record declaration?

> >> +=09.flags=09=09=3D HWMOD_SWSUP_SIDLE,
>=20
> Not sure why this has been added, I can not find any pointers regarding t=
o
> this and everything is working w/o this flag. Will remove it in v2.

OK thanks. =20

> >> @@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_=
1__hdmi =3D {
> >>  =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> >>  };
> >> =20
> >> +/* l4_per2 -> mcasp3 */
> >> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 =3D {
> >> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> >> +=09.slave=09=09=3D &dra7xx_mcasp3_hwmod,
> >=20
> > So this is the low-speed control/register access port, where the MPU=20
> > writes to the McASP3 config registers...
> >=20
> >> +=09.clk=09=09=3D "l3_iclk_div",
> >=20
> > ... and thus this interface clock doesn't look right for this port, sin=
ce=20
> > it's most likely generated from the L4PER2, where this port is connecte=
d. =20
> > So it should probably be "l4_iclk_div".
>=20
> There is no "l4_iclk_div" for dra7xx. Looking around the file all other s=
cript
> generated data uses "l3_iclk_div" for IPs under dra7xx_l4_per2_hwmod.
>=20
> Tero: do you know the reason for this?

Sounds like from your followup E-mail that the clock name to use in the=20
kernel is "l4_root_clk_div", which sounds fine to me.  (Haven't looked=20
closely at the clock data, though.)

> >> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> >> +};
> >=20
> > There's another struct omap_hwmod_ocp_if record missing: the high-speed=
=20
> > bus-master port that the McASP3 uses to DMA audio data.  This port shou=
ld=20
> > most likely be clocked with "l3_iclk_div" per Table 24-408 "Clocks and=
=20
> > Resets".  This port is also where the registers described in Table 24-5=
55=20
> > "MCASP_DAT Register Summary 3" L3_MAIN column are exposed.  You've got=
=20
> > that address map range blocked out in your DT data reg property, and=20
> > associated with this device, right? 0x46000000?
>=20
> Yes, the McASP3-dat port is not used ATM. This is over the L3 interconnec=
t and
> due to a feature we can not use it with sDMA (constant addressing is not
> supported through L3 interconnect for DMAs).
> We could use eDMA, but there are complications regarding to that.
> At the moment we are using the sDMA through the L4 interconnect address s=
pace.

OK thanks for the explanation.  The hwmod code prevents links from being=20
registered if no initiator 'users' are listed, so sounds like we should=20
leave it out for now.  Could you add a brief comment, similar to your=20
paragraph above, in the data, in case others wonder about the L3 link?

After those changes are made, feel free to add my ack.


K=F6sz=F6n=F6m,

- Paul
--843723315-995284589-1443776169=:11596--
