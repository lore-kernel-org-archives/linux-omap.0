From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 03/13] OMAP4: hwmod: Replace CLKCTRL absolute address
 with offset macros
Date: Thu, 7 Jul 2011 15:40:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107071537120.2647@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com> <1309554558-19819-4-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107070223340.30028@utopia.booyaka.com> <20110707182758.GA32199@google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1769027189-1310074855=:2647"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37945 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1GGVk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 17:40:56 -0400
In-Reply-To: <20110707182758.GA32199@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Benoit Cousson <b-cousson@ti.com>, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1769027189-1310074855=:2647
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Todd,

On Thu, 7 Jul 2011, Todd Poynor wrote:

> On Thu, Jul 07, 2011 at 02:25:23AM -0600, Paul Walmsley wrote:
>=20
> > -int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
> > +int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 =
clkctrl_offs)
> >  {
> >  =09int i =3D 0;
> > =20
> > -=09if (!clkctrl_reg)
> > +=09if (!clkctrl_offs)
> >  =09=09return 0;
> > =20
> >  =09omap_test_timeout((
> > -=09=09((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) =3D=3D 0) ||
> > -=09=09 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
> > -=09=09  OMAP4430_IDLEST_SHIFT) =3D=3D 0x2)),
> > +=09=09_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) =3D=3D 0 ||
> > +=09=09_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) =3D=3D 0x2),
> >  =09=09MAX_MODULE_READY_TIME, i);
>=20
> Suggest adding symbols for the constant IDLEST values, next to the 0x3
> value added for "[PATCH v2 04/13] OMAP: hwmod: Wait the idle status to
> be disabled".

Done.

> Would be nice to call _clkctrl_idlest() once.

Agreed.  That's now implemented by creating a new static function,=20
_is_module_ready(), that only does one read.

> Similar vague questioning of the API names as for the above-mentioned
> patch: this waits for the module slave to be ready, don't know if
> anything similar is needed for module masters or if it's important to
> keep this distinction.

I think I know the answer to this one, but would rather not speculate=20
without some hardware investigation.  Let's review this issue when Beno=EEt=
=20
returns.


Thanks for the comments, they are much appreciated.


- Paul
--155748971-1769027189-1310074855=:2647--
