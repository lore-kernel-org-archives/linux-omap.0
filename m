From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
Date: Fri, 8 Jul 2011 14:58:43 +0300
Message-ID: <20110708115842.GJ4820@legolas.emea.dhcp.ti.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
 <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
 <4E16EECF.7030102@mvista.com>
 <20110708115521.GA5783@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8zu1PYoF5C4kwccn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58899 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752189Ab1GHL6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 07:58:48 -0400
Received: by mail-bw0-f45.google.com with SMTP id 12so2047325bwd.32
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 04:58:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110708115521.GA5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Jan Weitzel <j.weitzel@phytec.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--8zu1PYoF5C4kwccn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Fri, Jul 08, 2011 at 04:55:21AM -0700, Tony Lindgren wrote:
> * Sergei Shtylyov <sshtylyov@mvista.com> [110708 04:45]:
> > Hello.
> >=20
> > On 08-07-2011 14:04, Jan Weitzel wrote:
> >=20
> > >Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> > >---
> > >  arch/arm/mach-omap2/Kconfig  |    5 +++++
> > >  arch/arm/mach-omap2/Makefile |    4 ++++
> > >  2 files changed, 9 insertions(+), 0 deletions(-)
> >=20
> > >diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > >index 19d5891..c6a2d43 100644
> > >--- a/arch/arm/mach-omap2/Kconfig
> > >+++ b/arch/arm/mach-omap2/Kconfig
> > [...]
> > >diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefi=
le
> > >index b148077..e81b594 100644
> > >--- a/arch/arm/mach-omap2/Makefile
> > >+++ b/arch/arm/mach-omap2/Makefile
> > >@@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+=3D board-omap4p=
anda.o \
> > >  					   hsmmc.o \
> > >  					   omap_phy_internal.o
> > >
> > >+obj-$(CONFIG_MACH_PCM049)		+=3D board-omap4pcm049.o \
> >=20
> >    You need to first add board-omap4pcm049.c, and only then wire it
> > to the Makefile. You could do both in onme patch though...
>=20
> Yes looks like this should be just one patch for everything.

Are you or are you not taking now board files ? We have one which was
left out due to a comment from Russell stating that no new board-files
would be accepted until the move to device tree was completed [1]

[1] http://marc.info/?t=3D130199607500006&r=3D1&w=3D2

--=20
balbi

--8zu1PYoF5C4kwccn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOFvDyAAoJEAv8Txj19kN1sX0H/2/nj6G8UAq17Rm9q8hqktkB
ySrJ6F9mIdX+8j1yemAJ8B8b56sCB1jDHTlt6bozlgQMeeBzd7vGintCdem07F7H
YAzs4XhE0oiC39xQ4KyjY0WCxen01CiWmYGFv9HdXfKZPR9ulc9jwPWNuvkHPo7K
tJp3nk9cgivihlXT35TnrJHihvxq2Kd2ocHOgBOt41/3MS/Dstvn2XmLv3o+ng1R
GXcHtw2W68cHxDkKNkID7XOVa5TxfTYnPH+U8MqjQc1hyaxOoqGlY7KZjU3FgHqQ
FdzUyzfhW5jboWguGaBnYISsoHpS0FxaKgBawqTneJdaJcBpXrEMjthbxZoz4xw=
=6uZ5
-----END PGP SIGNATURE-----

--8zu1PYoF5C4kwccn--
