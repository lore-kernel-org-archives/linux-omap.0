From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 3/5] arm: omap: introduce other PM methods
Date: Thu, 18 Oct 2012 20:06:40 +0300
Message-ID: <20121018170640.GB6641@arwen.pp.htv.fi>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-4-git-send-email-balbi@ti.com>
 <878vb3g14c.fsf@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43855 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932702Ab2JRRMP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:12:15 -0400
Content-Disposition: inline
In-Reply-To: <878vb3g14c.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 10:07:31AM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > current omap_device PM implementation defines
> > omap-specific *_noirq methods but uses the
> > generic versions for all other PM methods.
> >
> > As it turns out, if a device decides to implement
> > non-runtime PM callbacks, we might fall into a
> > situation where the hwmod is still idled which
> > will generate an abort exception when we try
> > to access device's address space while clocks
> > are still gated.
>=20
> Please explain in more detail how this could happen.

just follow the patchset. If I implement system suspend and I'm not
focefully calling runtime_* methods, who will be there to call
omap_device_enable() ?

--=20
balbi

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgDcgAAoJEIaOsuA1yqRETCIP/ifeThxUk1pGVo41CY4O4GIe
/uJrTeO5ZJw3go8h54CWBtCgitmy5uuQq6QfOswm9MWD8yESIwPndjUrLg8ervBP
qIHHSc/wBGCmO7TlaCeW+cMpCMj/io9EqyuzMs4oLBv3K/AFM0PRLGZ61Ecdxsnc
gOpSUc3KSBF7odlHTDn0d1Z2g8zNRfBJYSwVXXmv7YB0zSMSyhIv2PNcSiSuOUnB
bgK4eHkobfm2s4lW8Mb0GgirgzbAVz0tqPEmxSACT3Pn8Qc62iLqa6SGGbSzwTiX
lvfG/Nv8IZI4nRqLScYnaGOo3VHtamLlXetQaRh9TkNp3+ZSwcUJZKgmjZdWPzVc
78SQUC/oxcXLHOGnk5OFRHj1Bu3BxZWnAQWNkLnPGIoymA6/4CjmC663OwMiThLG
mBASClPrzg9/QAYL3YussBvn/zb1oQHpYhq74gN6QQWm8M57/JaxJhM+REn5nB5F
8ySc93U1OkhNAekaAsJXk/KWgbbbHwjOpqEHHyFKzPIvib9tRx7j+ISC8v74y7qq
aqbqcHb7aXW3EJldoLDKxDoowjZtMETHeKmRcobZpNn/OKNbX/SCQ0/fPauQ2vbR
azdUpvL6tfQY5OtCDRmRiAfsXL4m1jqkRdtwk55vi9vukGwLu8lWBzJ6AMkHw0rB
ERA6a+++LeHJcEM5wb8V
=Qs5f
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
