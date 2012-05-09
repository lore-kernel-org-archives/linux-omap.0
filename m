From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 0/9] OMAPDSS: APPLY: Treat overlay manager timings as
 shadow registers
Date: Wed, 09 May 2012 14:51:29 +0300
Message-ID: <1336564289.3962.32.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	  <1336558256-26140-1-git-send-email-archit@ti.com>
	 <1336561991.3962.31.camel@deskari> <4FAA53EA.7040400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hSI7BqVd1VtZtq0gli72"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:41097 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756100Ab2EILvf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 07:51:35 -0400
Received: by laap9 with SMTP id p9so157843laa.8
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 04:51:32 -0700 (PDT)
In-Reply-To: <4FAA53EA.7040400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-hSI7BqVd1VtZtq0gli72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 16:54 +0530, Archit Taneja wrote:
> On Wednesday 09 May 2012 04:43 PM, Tomi Valkeinen wrote:
> > On Wed, 2012-05-09 at 15:40 +0530, Archit Taneja wrote:
> >> An overlay manager's timings (the manager size, and blanking parameter=
s if an
> >> LCD manager) are DISPC shadow registers, and they should hence follow =
the
> >> correct programming model.
> >>
> >> This set makes the timings an extra_info parameter in manager's privat=
e data .
> >> The interface drivers now apply the timings in instead of directly wri=
ting to
> >> registers.
> >>
> >> This change also prevents the need to use display resolution for overl=
ay
> >> checks, hence making some of the APPLY functions less dependent on the=
 display.
> >> Some DISPC functions that needed display width can also use these priv=
ately
> >> stored timings.
> >>
> >> Changes since v3:
> >>
> >> - Remove direct setting of go bit in dpi_set_timings()
> >> - Take some of the patches in "OMAPDSS: Misc fixes and cleanups" and m=
ake them a
> >>    part of this series as they are more related.
> >> - Don't have an initial set of manager timings in private data, only c=
heck
> >>    manager and overlay parameters once the manager is enabled.
> >>
> >> These patches apply over:
> >>
> >> git://gitorious.org/linux-omap-dss2/linux.git dev
> >>
> >> Reference tree containing this series:
> >>
> >> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git mgr_=
timing_and_fixes_2
> >>
> >> Tested on OMAP4 SDP and Panda.
> >
> > I did some quick tests on omap3 overo, worked fine. I'll merge to dss
> > master branch.
>=20
> Russ did some tests on more omap3 boards, the tree which he used has=20
> some slight changes comapred to what I have posted, but it's more or=20
> less the same.
>=20
> Could you add 'Tested-by: Russ.Dill@ti.com' if not too difficult, I=20
> missed out doing that.

Sorry, I could, but I already merged and pushed the series, so I can't
change it anymore.

 Tomi


--=-hSI7BqVd1VtZtq0gli72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqlpBAAoJEPo9qoy8lh71sFAP/3IJTqj2cslUCgFPJyA58Uo1
+YgMxKuRff3li2ylw2PuDRWOGNkaC1loOwMt49fIbWdcwu2ZM6WPWi7LXhrESGfD
dGzoc2IkGJkzFylgxTt/e+8bL0LFX94Tmdisd7tJE6GpCJDfg6DGc2EP1NoLSLwN
slt6F6S5DpcJ5watP1by3Dtt/Gc6+x8nkcNs4HXD3+1awMaJIJLWUT9sPPQg1uQH
6Nf5XQlJfxYlzefrXVeLlRdHbxkFenqLhYHcgmN4z2ruerUTdUwQaeior+gXXIRn
FoS36gmTn0iRmstqfgwS3aWFE18d5/5CYAHltssZSXHnWjpJhi3n3USuCmnUWOu1
0R/mx5Shz1KVtFtJ0P+rd0reDhEZ/mW6WxO05Ch9wUYMPjHQQNPibMkuAs+lNz8G
BQgZffO12ACcQpQpdBljUPPgVa84V32y9/8eh7YWu6q/+MTG3fl9WZArfu33ajXH
hYvbAa48B0/7Uky9bxBbFBHS1olRBJygeUFwi/boNPecL0f9KVdPuh8T+kHfb+8w
77BDbfcmTUj+gw64QRTj4UuzrBFDhm550MZMAT7Xz7Z/6gkIz3K1mHzfj6IdiS+d
ZrcMEzTWOV7Za8RBJky1KShpXmanKeD6rfSVQr3w3f9OYvKzJYJFk1YmL+lLF8tV
8slHEpmnqI2kc+4AtioB
=UHAv
-----END PGP SIGNATURE-----

--=-hSI7BqVd1VtZtq0gli72--

