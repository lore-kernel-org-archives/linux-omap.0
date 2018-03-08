From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Thu, 8 Mar 2018 07:16:44 +0100
Message-ID: <20180308071459.310d0ba2@aktux>
References: <cover.1512114576.git.hns@goldelico.com>
        <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
        <20171222124427.GI3374@localhost>
        <20180109184347.28ba0a6e@aktux>
        <20180112144647.GA5992@localhost>
        <20180112194022.7da1e726@kemnade.info>
        <20180118064736.GH3286@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//GnIge=aWUzMu=J_ndxszsL"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180118064736.GH3286@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--Sig_//GnIge=aWUzMu=J_ndxszsL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 18 Jan 2018 17:47:36 +1100
Johan Hovold <johan@kernel.org> wrote:

[...]
> >=20
> > So to avoid having hardware information spread all over the table at le=
ast
> > these information would need to be in devicetree. But that also all fee=
ls
> > like a hack and hard to maintain. =20
>=20
> Having the device described in the device tree is certainly desirable,
> not least for chip identification. And with a GPS framework in the
> kernel with a well-defined interface, implementing power management
> would be straight forward.
>=20
Hmm, devicetree without in-kernel drivers, do we have anything like that
somewhere? I thought that was a big no-go. But maybe I am wrong.

> I'm just not convinced that the proposed tty interface is the right
> interface for this. User space would still rely on gpsd for the GPS
> protocols, and would also ultimately be managing power by killing gpsd
> or whatever daemon that would otherwise be holding the port open.
>=20
> Something like the generic power sequences that has been discussed
> elsewhere might be a better fit for this if all you want to do is power
> on and off on port open and close (and on suspend/resume). There really
> isn't anything GPS-specific in the current proposal (besides the
> suggested tty-device name).

So a bit like that mmc-powerseq stuff we already have?
>=20
> But sure, that wouldn't be sufficient to deal with the
> unknown-power-state problem with the device in question.
>=20
Maybe there could be a kind of active flag set by the tty if
there is traffic, so that active flag could be used in these
power sequence stuff? But then again the tty layer has to be extended
which would probably also cause a lot of ruffled feathers.

Regards,
Andreas

--Sig_//GnIge=aWUzMu=J_ndxszsL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlqg1UwACgkQfb1qx03i
kySUIRAAm+s1rDjwjMbnM/1njhhr3ul5v6ns3xiRWFYUCB9H16i/ts2OheXAj304
udSxZ1eMoY8mVnl9bvao7MY5k1xPR+tcHHG0cVNlR7ZvIpcfrao/10ljXSe52IlW
jZvO/9h7caocZT6AzqynwoctjClEj8Ck59FJfVM934utY7GDnPhWkFdADQdkPygB
zUtzDIj3RiWNKiMxq6QSzPF0PnEPTDKmpgIJjfmDTXxfxT/KfPaQCr2PanXAjI/L
rKADGmTfpMYF+x3bPcCHDLBytg3NZvYFYEp2EdKyBWzOrA9EVqzCqH8VqJ6cHbFZ
JePoNdy7bcoFNIG6i17iGCqCeSgG+fyrebXVEIY00f0NEXFiilGk5fdVEw8cZrhe
EJZHU+KbJFC598cTgZ7sP1btCFfs5Z3O5JDVQKwe4uAdkm0g+FmW+fWhxH8pLWXB
qMSX1NJ0GSlNBhUfJJ4/5Ud0Ft5RcltsiR4JuVbVixcjc5XFnr89EXm7CXEh1kne
RqS02zpvKIYUbWD1BQ53mj6l1j1SlTM78/ispS+bKN07aPWq72Q9E7s0Nuy6Xr21
99Iax7Eos6QmPLD5/CE+8C1Fj/BOKqjIcdDpjk8+jZ4nh2RtI/E500LvaqnlOxg1
YmQKZB0Epdm9ObZdm0KHtpNCrejTye0xt2BI251wwjg+bnikZHc=
=PAIm
-----END PGP SIGNATURE-----

--Sig_//GnIge=aWUzMu=J_ndxszsL--
