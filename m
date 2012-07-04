From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Wed, 4 Jul 2012 12:59:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207041257200.6760@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com> <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com> <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com> <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com> <4FF475E6.3060308@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-818724462-1341428374=:6760"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60174 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab2GDS7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 14:59:35 -0400
In-Reply-To: <4FF475E6.3060308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-818724462-1341428374=:6760
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt

On Wed, 4 Jul 2012, Benoit Cousson wrote:

> > @@ -1141,8 +1144,16 @@ static void _enable_sysc(struct omap_hwmod *oh)
> >  =09sf =3D oh->class->sysc->sysc_flags;
> > =20
> >  =09if (sf & SYSC_HAS_SIDLEMODE) {
> > -=09=09idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
> > -=09=09=09HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> > +=09=09clkdm_act =3D ((oh->clkdm &&
> > +=09=09=09      oh->clkdm->flags & CLKDM_ACTIVE_WITH_MPU) ||
> > +=09=09=09     (oh->_clk->clkdm &&
>=20
> This is crashing on OMAP4 due to a NULL oh->_clk that can happen on some
> hwmod.
>=20
> +=09=09=09     (oh->_clk && oh->_clk->clkdm &&
>=20
> Is fixing the issue.

Thanks, just made the change and pushed the patch up to=20
git://git.pwsan.com/linux-2.6 in the branch 'omap_fixes_c_3.5rc'


- Paul
--155748971-818724462-1341428374=:6760--
