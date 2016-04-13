From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail
 state
Date: Tue, 12 Apr 2016 20:11:27 -0400
Message-ID: <20160413001127.GX13577@bill-the-cat>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
 <570D56FE.2070408@gmail.com>
 <20160412203431.GU5995@atomide.com>
 <570D6B7A.3050203@gmail.com>
 <CAL_Jsq+B67np4qcwJ2m1yz3TOzYgb7ZQtRH+vhANm9Snw5QnzQ@mail.gmail.com>
 <20160412222732.GL5995@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4uMdeSyPFwfKNOAv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160412222732.GL5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--4uMdeSyPFwfKNOAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 03:27:32PM -0700, Tony Lindgren wrote:
> * Rob Herring <robh+dt@kernel.org> [160412 15:22]:
> > On Tue, Apr 12, 2016 at 4:41 PM, Frank Rowand <frowand.list@gmail.com> =
wrote:
> > >>> Status of "fail-sss" is meant to indicate an error was detected in
> > >>> the device, and that the error might (or might not) be repairable.
> > >>>
> > >>> So the difference I see is state vs hardware description.
> >=20
> > The question to ask is are we indicating the "operational status of a
> > device"? If yes, that is the definition of status and using it would
> > be appropriate.
> >=20
> > IMO, I think we are.
> >=20
> > >> OK thanks for the clarification. I don't see why "fail-hw-incomplete"
> > >> could not be set dynamically during the probe in some cases based
> > >> on the SoC revision detection for example. So from that point of
> > >> view using status with the "fail-sss" logic would make more sense.
> > >
> > > If the probe detects that the device should only be power managed
> > > based on the SoC revision, then it would simply be one more
> > > test added at the top of probe.  The patch would change from:
> > >
> > >    if (of_device_is_incomplete(pdev->dev.of_node)) {
> > >
> > > to:
> > >
> > >    if (of_device_is_incomplete(pdev->dev.of_node) || socrev =3D=3D XX=
X) {
> >=20
> > I think Tony meant the bootloader or platform code would do this and
> > tweak the DT. We don't have much of a standard API for revision
> > checking, so drivers don't check SoC revisions generally.
>=20
> Yes bootloader may need to set these based on the SoC revision.
> There are already many boards with multiple SoC variants
> available. Would like to hear Tom's comments on this one as
> well from the u-boot point of view.

So, the first part of it is that any "smart" bootloader will have to
tweak the DT.  A "dumb" bootloader will just pass along a pre-corrected
DT.  In fact, some of the problems are going to probably still have to
be solved by passing in a correct base DT, given that not all changes
are run-time detectable.  But from my point of view, the important part
is that it won't matter what vendor the SoC is from but that we can say
fdt_fixup_hw_incomplete(blob, compatible) or something like that.

--=20
Tom

--4uMdeSyPFwfKNOAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDY6vAAoJEIf59jXTHXZSwg0P/0IFloCGU2FONLMrchcKEX0M
je0Cr10bLW17B21bGHu1OuvXFXsm+LjDooC0TbdGCNTgmxTk1Z+wFkZCkYfEShZk
XuJp4ZGQH5ukF2TMlvbTAb4LRDjjEzpJPLTGLdsddzs2i3Tb7x2i4FYI6sfNh0/9
O4JuUwPV/P1+FsMcMdm2yIxJJWZkVby4Lxs45iuPsgxF+xOkmG7ut/VxRopE7f/F
bws5Fgd4Qt4AV1nb54KvFJ4yQTCaBvpnlqHpVHx6BYpA1WpF1+DOByf0aAbmRhna
TSVe0EYLT/mBlGQqWP22ox9intmx75uzMSWTwVKo/ysj5cbVN10rAayfXBgVq2st
IG79d+KiZtj9xSUSHf4RM7B1QjPhBFG9Denb6XKhQ9vIVytAUO8fAF5cDhhM3zij
8huENvUNTWs1xsuXphSSIt98dYZQ//cqclxm1HCf1OdVp38yuIvboOGmmn/hmAiZ
zSjxwsGGfoUfINytYxD52YLnUQRin55Fit7//T3ltt+Y+qzW6Tnom8aIqQThtIVN
Na9hp9u7rA24x1BButX4ZBUa+e+bx/hCJZQGFOcMYFToJh5uf0RPaCM/7KF0jQQd
oLYKHbbLvHhWgDPoRpR2Rmevq61Cp9EJHYvYvqTOTa1iDcre8lLYuUX5vnz++3vY
7b8f8uE/z25979/ZeVKo
=plfF
-----END PGP SIGNATURE-----

--4uMdeSyPFwfKNOAv--
