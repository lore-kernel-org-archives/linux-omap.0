From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: AM3505/3517 support
Date: Wed, 6 Jul 2011 14:24:18 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D91AB0A@dbde02.ent.ti.com>
References: <4E121485.6060700@8d.com> <20110705111952.GG5783@atomide.com>
 <4E132143.7040802@8d.com> <20110706065605.GK5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44544 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab1GFIyi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 04:54:38 -0400
In-Reply-To: <20110706065605.GK5783@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, July 06, 2011 12:26 PM
> To: Rapha=EBl Ass=E9nat; Paul Walmsley
> Cc: linux-omap@vger.kernel.org
> Subject: Re: AM3505/3517 support
>=20
> * Rapha=EBl Ass=E9nat <raph@8d.com> [110705 07:30]:
> > On 05/07/11 07:19 AM, Tony Lindgren wrote:
> > > * Rapha=EBl Ass=E9nat <raph@8d.com> [110704 12:51]:
> > >>
> > >> The am3505 is apparently so similar to the 3430 that it=20
> was treated as such=20
> > >> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1).=20
> There are however a
> > >> few differences that need to be addressed. I have=20
> therefore created a new
> > >> CHIP_IS and patched clocks, hwmod and power management=20
> related files
> > >> consequently. My system now boots until it complains=20
> that it is unable=20
> > >> to mount its root filesystem.
> > >=20
> > > Can you please describe where you need CHIP_IS for=20
> am3505? It seems that
> > > your patches just enable the same CHIP_IS_OMAP3430=20
> features for am3505 too?
> >
> > Actually it's only needed for the 3505/3517 specific UART 4=20
> which should
> > not be registered on real OMAP3430's. (see struct omap_hwmod=20
> > am35xx_uart4_hwmod; in omap_hwmod_3xxx_data.c)
> >=20
> > But there are also cases where OMAP3430 hwmods must not be=20
> registered
> > on AM35xx. For instance, omap3xxx_timer12_hwmod since timer12 does
> > not exist general purpose AM3505's.
>=20
> Sounds like we should be able to handle both uart and=20
> gptimer12 the same way
> as we'll be handling the hwmod reset for special cases like=20
> gptimer12 for
> secure mode. So addding Paul to Cc.
>=20
> Basically we can have a am35xx specific arch_initcall that=20
> sets the special
> flags for these devices like noreset, disabled or unavailable.
>=20
> In this case we would just set some devices as unavailable on am35xx.

[sp] AM35x is already supported in the kernel. Specifically for the
     changes being discussed, see this commit:

    commit 3cc4a2fc2ed7727828f410ab092111cb56cefd61
    Author: Ranjith Lohithakshan <ranjithl@ti.com>
    Date:   Wed Feb 24 12:05:55 2010 -0700

    AM35xx: Add clock support for new modules on AM35xx

    I believe this patch already contains most AM35xx specific changes
    related to clocks.

> =20
> > > I'd rather see us improve the code so we can support=20
> am3505 properly without
> > > a need to patch all over the place..
> > Maybe instead of having one big array of hwmods registered for
> > all CPUs in omap_hwmod_3xxx_data we could have a separate
> > one for am35xx (and maybe, eventually others) such as:
> >=20
> > static __initdata struct omap_hwmod *omap3xxx_hwmods[]
> > static __initdata struct omap_hwmod *am35xx_hwmods[]
> >=20
> > ...and maybe also a 'common' array.

[sp] I did sumbit a similar patch making 2 arrays, but Paul
     has sumbitted an updated patch that seemes to do away
     with need to make 2 arrays.
     http://marc.info/?l=3Dlinux-omap&m=3D129983254729228&w=3D2

> >=20
> > The init function would then register the appropriate hwmod=20
> array(s). The only=20
> > thing I don't like is that for this to work we would have=20
> to keep setting=20
> > CHIP_IS_OMAP3430 even on AM35xx CPUs. But maybe we could=20
> change the behaviour of
> > omap_hwmod_register to trust the caller and accept the=20
> hwmods without looking=20
> > at the omap_chip member. By doing this I think we could=20
> drop all the=20
> > .omap_chip =3D OMAP_CHIP_INIT(...) instances.
> >=20
> > Otherwise I think the current approach, despite the size of=20
> the initial patch,
> > has at least the benefit of being explicit and less=20
> confusing than (ab)using the
> > CHIP_IS from a different CPU.
>=20
> Well let's see how far we can get with passing the special=20
> case flags with
> omap2_init_devices(). Initially we can call that from the=20
> board-*.c file
> that should get your board booting. Then we can add the=20
> am35xx specific
> arch_initcall.
>=20
> Regards,
>=20
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
