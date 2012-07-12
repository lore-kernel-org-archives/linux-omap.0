From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] Fix sprz319 erratum 2.1
Date: Thu, 12 Jul 2012 15:19:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207121518240.25585@utopia.booyaka.com>
References: <4F4289C2.90707@kynesim.co.uk> <alpine.DEB.2.00.1202241419580.23504@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1000895476-1342127949=:25585"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42701 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932989Ab2GLVTi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jul 2012 17:19:38 -0400
In-Reply-To: <alpine.DEB.2.00.1202241419580.23504@utopia.booyaka.com>
Content-ID: <alpine.DEB.2.00.1207121519190.25585@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Watts <rrw@kynesim.co.uk>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, beagleboard@googlegroups.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1000895476-1342127949=:25585
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1207121519191.25585@utopia.booyaka.com>

Hi,

On Fri, 24 Feb 2012, Paul Walmsley wrote:

> cc'ing beagleboard list, Kevin
>=20
> Hi Richard,
>=20
> thanks for the patch.  A quick question for you or anyone else who is=20
> experiencing this problem.
>=20
> On Mon, 20 Feb 2012, Richard Watts wrote:
>=20
> > There is an erratum in DM3730 which results in the
> > EHCI USB PLL (DPLL5) not updating sufficiently frequently; this
> > leads to USB PHY clock drift and once the clock has drifted far
> > enough, the PHY's ULPI interface stops responding and USB
> > drops out. This is manifested on a Beagle xM by having the attached
> > SMSC9514 report 'Cannot enable port 2. Maybe the USB cable is bad?'
> > or similar.
> >=20
> > The fix is to carefully adjust your DPLL5 settings so as to
> > keep the PHY clock as close as possible to 120MHz over the long
> > term; TI SPRZ319e gives a table of such settings and this patch
> > applies that table to systems with a 13MHz or a 26MHz clock,
> > thus fixing the issue (inasfar as it can be fixed) on Beagle xM
> > and Overo Firestorm.
> >=20
> > Signed-off-by: Richard Watts <rrw@kynesim.co.uk>
>=20
> Funny, I just had a conversation with Kevin Hilman about needing to put=
=20
> the DPLL rate rounding code back in for the OPP tables.  This looks like=
=20
> another reason why...
>=20
> Could you, or anyone else who is experiencing this problem on a board wit=
h=20
> a 26MHz oscillator try a quick test for me?  I'm a little curious about=
=20
> the (M, N) of (443, 12) that SPRZ319E is recommending.  Could you see if=
=20
> your USB problems are also solved by using (480, 13) ?
>=20
> ...
>=20
> Here's the rationale.  Walking through the estimates here based on=20
> SPRZ319E, (443, 12) results in a frequency error of -166,667 Hz at the VC=
O=20
> output.  This is 174 ppm below the desired target rate of 960MHz.  But=20
> (480, 13) results in no frequency error.
>=20
> The downside of using (480, 13) is that the PLL update interval increases=
=20
> from 461 ns to 500 ns (+9%).  But if the long-term drift of the DPLL is=
=20
> downward, then starting at a -174 ppm error has removed 35% of the total=
=20
> margin (+/- 500 ppm).  This might be too na=EFve, but a downward drift,=
=20
> seems likely given that gate delay increases as temperature increases.
>=20
> Mainline is currently using (120, 13) which results in a VCO output=20
> frequency of 240MHz -- this presumably results in increased phase noise=
=20
> compared to (443, 12) and (480, 13) per SPRZ319E. =20

Just a quick followup on this.  Have you or anyone else out there tried=20
this change?  Alternatively does someone out there have a test case that=20
is simple to reproduce? =20


- Paul
--155748971-1000895476-1342127949=:25585--
