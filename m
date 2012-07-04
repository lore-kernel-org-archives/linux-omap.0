From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Wed, 4 Jul 2012 13:05:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207041302401.6760@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com> <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com> <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com> <4FF468DF.10108@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-865564482-1341428709=:6760"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36141 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab2GDTFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 15:05:10 -0400
In-Reply-To: <4FF468DF.10108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-865564482-1341428709=:6760
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt

On Wed, 4 Jul 2012, Benoit Cousson wrote:

> > From: Paul Walmsley <paul@pwsan.com>
> > Date: Wed, 4 Jul 2012 05:22:53 -0600
> > Subject: [PATCH] ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync=
 timer
>=20
> [...]
>=20
> > @@ -1208,8 +1219,13 @@ static void _idle_sysc(struct omap_hwmod *oh)
> >  =09sf =3D oh->class->sysc->sysc_flags;
> > =20
> >  =09if (sf & SYSC_HAS_SIDLEMODE) {
> > -=09=09idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
> > -=09=09=09HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
> > +=09=09/* XXX What about HWMOD_IDLEMODE_SMART_WKUP? */
>=20
> What do you mean here?

We're not programming IP block target idle modes to smart idle + wakeup on=
=20
OMAP4.  We're only programming them to smart idle :-(


- Paul
--155748971-865564482-1341428709=:6760--
