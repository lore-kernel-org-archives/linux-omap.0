From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Tue, 5 Jun 2012 18:28:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206051737000.30737@utopia.booyaka.com>
References: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com> <4FC4C4FA.1070403@ti.com> <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2028444165-1338941945=:30737"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58813 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab2FFA2I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 20:28:08 -0400
In-Reply-To: <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
Content-ID: <alpine.DEB.2.00.1206051822530.30737@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2028444165-1338941945=:30737
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1206051822531.30737@utopia.booyaka.com>

Hello Beno=EEt

On Tue, 5 Jun 2012, Paul Walmsley wrote:

> On Tue, 29 May 2012, Cousson, Benoit wrote:
>=20
> > So in fact, I'm wondering if a new flag is needed. We can potentially=
=20
> > apply that if idlemodes =3D=3D (SIDLE_FORCE | SIDLE_NO).
> >=20
> > We need to check which IP will have that to ensure that does not add=20
> > any side-effects.
>=20
> I guess that means me :-)

I looked at a few TRMs.  Based on that incomplete survey, the above=20
behavior would probably work for existing chips.

But it seems perverse to assume that it is generally safe to set an IP=20
block to force-idle while it's being used.  That seems really dependent on=
=20
the IP block's integration.

So in terms of a general fix, the flag approach seems safest to me in the=
=20
long run.

The other advantage of using a flag is that it indicates that this is a=20
hardware workaround; something that it would be nice to fix in future=20
chips.


- Paul
--155748971-2028444165-1338941945=:30737--
