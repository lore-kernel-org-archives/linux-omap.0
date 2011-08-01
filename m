From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Mon, 1 Aug 2011 11:52:52 +0300
Message-ID: <20110801085251.GF31013@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-4-git-send-email-khilman@ti.com>
 <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
 <20110728055346.GA11921@foobar>
 <4E315C9F.1030801@ti.com>
 <CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
 <20110729134932.GA2258@foobar>
 <20110729140515.GV31013@legolas.emea.dhcp.ti.com>
 <CAOMWX4e0CODd8YT4LC2zHdGhzzZpOqRc0CU8roV-Pw1VTx5XCw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZsxMXj7gRnSZQ7B8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52959 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752031Ab1HAIw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 04:52:57 -0400
Received: by fxbb27 with SMTP id b27so4738527fxb.4
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 01:52:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMWX4e0CODd8YT4LC2zHdGhzzZpOqRc0CU8roV-Pw1VTx5XCw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: balbi@ti.com, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--ZsxMXj7gRnSZQ7B8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 06:07:17PM -0500, Menon, Nishanth wrote:
> On Fri, Jul 29, 2011 at 09:05, Felipe Balbi <balbi@ti.com> wrote:
> >
> >> +}
> >> +EXPORT_SYMBOL(omap_hwmod_name_get_odev);
> >
> > maybe EXPORT_SYMBOL_GPL() ?? Not sure we want non-GPL code to access
> > this ;-)
>=20
> Sure.. but is this the way we want to go? if yes, I can post the
> series in a formal way to the list.

I would expect so, but if there are concerns of other non-GPL drivers
needing this, you can at least use:

EXPORT_SYMBOL_GPL_FUTURE();

this would allow you to catch non-GPL drivers accessing this symbol.

--=20
balbi

--ZsxMXj7gRnSZQ7B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJONmljAAoJEAv8Txj19kN1njgIAJOGgevV0HNBkUar++7amyGI
+XcNfWCf8SOqGjLOfPXB6i7OO7QrHUHE1aLGGpuTT9+p0X/H29RP6vU+XXYWFPwL
2mmlPR4uKUz1CTYoF2taKH4iX37+j1X1QdzVDbe24Bfo8jXC+fNfOfHWTPYvbuaq
LVR5LDiW4rqEOUBXgyf9ix5VS95AAzMCTYzhhoU/0kK2hkDVy9x71p4RZMpoXFyj
EWFb0p76euLuVpXTF3Cpl77dka04TdQ9H8JZlixA0q8aAu7D2se5S2a/+IPeJya9
OIfunzb70pKeKS9E2843YbsXo48/AWajgor7lzCEoSsCfbmrfldcfhYEvolmgTw=
=y+gM
-----END PGP SIGNATURE-----

--ZsxMXj7gRnSZQ7B8--
