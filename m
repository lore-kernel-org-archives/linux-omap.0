From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Tue, 5 Jun 2012 16:55:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
References: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com>
 <4FC4C4FA.1070403@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="155748971-1332993319-1338936933=:30737"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FC4C4FA.1070403@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: khilman@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1332993319-1338936933=:30737
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Beno=EEt

On Tue, 29 May 2012, Cousson, Benoit wrote:

> On 5/25/2012 11:56 PM, Paul Walmsley wrote:
>
> > This patch is effectively a workaround for a hardware oversight.  A
> > better hardware approach would have been to implement a smart-idle
> > target idle mode for this IP block.  The smart-idle mode in this case
> > would behave identically to the force-idle mode.=20
>=20
> I'm not sure to follow you here :-)

I should rewrite that paragraph.  It is not as clear as it could be.

> force-idle is almost equivalent to smart-idle, so it is the right=20
> workaround when smart-idle is not implemented.
>=20
> In force-idle idleack =3D idlereq. Whereas in smart-idle idleack =3D idle=
req=20
> if internal /OCP activity is completed.

It would be nice if the hardware people just implemented smart-idle on=20
all IP blocks.  Section 3.1.1.1.2 "Module-Level Clock Management" of The=20
OMAP4430 TRM Rev. vAA states:

"Smart-idle mode is the preferred mode of operation, while forced-idle and=
=20
no-idle modes are intended for debugging purposes."

Then no flags or software workarounds would be needed, except for=20
debugging.

> So in fact, I'm wondering if a new flag is needed. We can potentially app=
ly that if=20
> idlemodes =3D=3D (SIDLE_FORCE | SIDLE_NO).
>=20
> We need to check which IP will have that to ensure that does not add any =
side-effects.

I guess that means me :-)

> BTW, please note that the current idlemodes flags are wrong for the=20
> counter 32k. I've just figured out that fixing the STANDBY flags for=20
> some OMAP5 IPs. I'll add that fix in my WIP OMAP4 hwmod data cleanup for=
=20
> 3.6.
>=20
> Something like that:

Okay will queue up a fix for 3.5-rc.

> >   =09=09=09.context_offs =3D OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
> >   =09=09},
> >   =09},
> > +=09.flags=09=09=3D HWMOD_ALWAYS_FORCE_SIDLE,
>=20
> I'm confused by the location and the value, both linus/master and=20
> lo/master branches does already have a flag for the counter_32k:
>=20
> /* counter_32k */
> static struct omap_hwmod omap44xx_counter_32k_hwmod =3D {
>         .name           =3D "counter_32k",
>         .class          =3D &omap44xx_counter_hwmod_class,
>         .clkdm_name     =3D "l4_wkup_clkdm",
>         .flags          =3D HWMOD_SWSUP_SIDLE,
>         .main_clk       =3D "sys_32k_ck",
>         .prcm =3D {
>                 .omap4 =3D {
>                         .clkctrl_offs =3D OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL=
_OFFSET,
>                         .context_offs =3D OMAP4_RM_WKUP_SYNCTIMER_CONTEXT=
_OFFSET,
>                 },
>         },
> };
>=20
> So the patch should be slightly different, I guess ?
>=20
>  =09.class          =3D &omap44xx_counter_hwmod_class,
>  =09.clkdm_name     =3D "l4_wkup_clkdm",
> -=09.flags          =3D HWMOD_SWSUP_SIDLE,
> +=09.flags=09=09=3D HWMOD_ALWAYS_FORCE_SIDLE,
>  =09.main_clk       =3D "sys_32k_ck",
>  =09.prcm =3D {
>=20
>=20
> This is the same issue for OMAP3 data.
>=20
> What base branch are you using?

The wrong one, evidently.  Will ensure this is fixed.


- Paul
--155748971-1332993319-1338936933=:30737
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--155748971-1332993319-1338936933=:30737--
