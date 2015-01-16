From: Felipe Balbi <balbi@ti.com>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Fri, 16 Jan 2015 10:46:31 -0600
Message-ID: <20150116164631.GI16782@saruman>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
 <20150115171924.GV11502@n2100.arm.linux.org.uk>
 <20150116162119.GK18552@atomide.com>
 <20150116163019.GW11502@n2100.arm.linux.org.uk>
 <20150116164105.GL18552@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33332 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbbAPQs1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2015 11:48:27 -0500
Content-Disposition: inline
In-Reply-To: <20150116164105.GL18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>

--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2015 at 08:41:06AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150116 08:33]:
> > On Fri, Jan 16, 2015 at 08:21:20AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 09:22]:
> > > > On Thu, Jan 15, 2015 at 07:28:39AM -0800, Tony Lindgren wrote:
> > > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 02:53=
]:
> > > > > > I don't think we've proven a link there.  While you're right th=
at it
> > > > > > causes the wrong interrupt to be claimed, I have two kernels he=
re,
> > > > > > both claim the same interrupt, one which is multi-platform and =
issues
> > > > > > that strange warning, and one which targets only OMAP4 which do=
esn't.
> > > > > >=20
> > > > > > There's something else going on which causes the bus errors whi=
ch we
> > > > > > haven't found.
> > > > >=20
> > > > > I think it gets triggered if you enable PREEMPT.
> > > >=20
> > > > That's something which we can try to prove... build running now with
> > > > CONFIG_PREEMPT=3Dy
> > >=20
> > > Looks like you now have the omap_l3_noc error appear for sdp4430 in
> > > your logs after enabling PREEMPT.
> > >=20
> > > I guess that means case closed for this one?
> >=20
> > I would still like to understand /why/ enabling preempt causes the erro=
r.
> > Changing the preempt configuration really should not change what happens
> > on the bus.  (Think about it.)  It's an indication that there is some
> > other error present.
>=20
> We have a wrong irq number caused by $subject. And the wrong irq
> gets triggered before the dma hardware is configured during dma
> init. And then we get the invalid access error from omap_l3_noc.
>=20
> > Unfortunately, the OMAP hardware appears to make it impossible to
> > determine what the access that caused the error was, so it looks like
> > it's pretty much undebuggable.
>=20
> Yeah would be nice to have more info from omap_l3_noc.

you can probably get more info by decoding all L4 instance errors. It's
just not implemented anywhere. In this case, we should decode l4cfg
which is who generated the error.

--=20
balbi

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUuUBnAAoJEIaOsuA1yqRECn8P/3pn1nCsjPyTmTmzFOB6XgO4
Qj8UhPGlU0gTjr4pHfqHDqLHDaD1ucdE+FoTZUFSKbchS2JsDTDBojJdIhqt/igz
p4D//5M5wdgIrZK35U2P2gJebc27VPRrm7gr3mCc4OSBR0xq49iIU5Yt6WQWhejT
oKLFu7a+aT4t4E4PbXxcTHfS0tq3eImw+XZRmQTb+yt7q2C7LANSicVA+ejvTxVN
ZSWylpDnJLhWpr1VvJhWcijHeBxSRVEJALF+C4A7eQSa3o+sFBVrHoC3XnZ83uwf
ilFZJAx3YAMPuSV38avJ8weQg+Y4j3LvfBD//gArGFh03iHQiJICwZPDU/x8ZV+m
3WLQHAXRvBgL42WCuceUq9lZnK6vf7FfHjO58NmOu2gNPeK5NAcx+1kMmyhCXFb/
3EzhD/yuqkGnwru+l8jFmM+TproEtS20I9EDiFRyEf0vcVxpUg+VMIG6a4Ny/bW6
lheGUmh1pJQNZjG+A8WoXccxe1yEKSzxI5YxKcwxcKI3s3aQuxwDsxyh1Ou5YR+d
MrgGzOz2vkgCYPRLZRxmwgquwGQEyAIiay+oYYU4xFUqDLc74mE4WB//I69qSpB8
x1I3KrGjaekhx/0iauhw+TAWd6loaYdynMSjdxsWHnlTj8ugIPa7so4OyxTBHhnl
9C+fkRUAH7Wts1UTaZTJ
=8W35
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--
