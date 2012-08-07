From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3: USB: EHCI broken on 3.5?
Date: Tue, 7 Aug 2012 09:10:35 +0300
Message-ID: <20120807061034.GJ8468@arwen.pp.htv.fi>
References: <WC20120731124207.4902F1@terrafix.co.uk>
 <87sjbz7ufs.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56854 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159Ab2HGGOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 02:14:10 -0400
Received: by lahc1 with SMTP id c1so1165762lah.26
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 23:14:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87sjbz7ufs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2012 at 11:21:27AM -0700, Kevin Hilman wrote:
> Hi Joe,
>=20
> "Joe Woodward" <jw@terrafix.co.uk> writes:
>=20
> > I have a GUMSTIX Overo AirSTORM (AM3703-based).
> >
> > When running a 3.4 kernel the USB host works just fine!
> >
> > However when switching to 3.5 I get a few new warning messages and USB =
host no longer works.
>=20
> As usual, thanks for the bug/problem reports.
>=20
> EHCI is broken in many ways in v3.5.  Since the maintainers were not
> fixing the problems (specifically the PM problems which broke PM for the
> rest of the SoC too), I requested it be disabled by default in
> omap2plus_defconfig.
>=20
> Kesheva sent out a large revert patch, and Russ Dill sent out an
> alternative set of 2 patches that were more targetted fixes, but I lost
> track of the final resolution there (if any.)

Alan Stern asked to wait for his patches first...

--=20
balbi

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQILFaAAoJEIaOsuA1yqRErUIP/2xvQQDMHCW04t/cZ8JIaXs+
nUBESE03CZ40oUifCf7/k15DTaHZOi28QM5C2O3J82xA+/AxO2QKtEVoGMsDrYb4
1KO0Z45q5YdIVvbtWhqkKNXmM9POR+H9JG0xSkBVSF+SkksP1lMtsqFv2SSLa2c1
nDt1/dS7rFl2/YYriRTeRq2eSNV2Y7lrjDKTiUhfHhHCGQOj3Kbiebks8JGOHMLu
hPIMBwHteRBrwXTHhIkRsEQs2HRBSwYLkY0c93YvpDX43pD1MA/WNLYUD/9oilXJ
DBiiv3MRNNBV5sIKCCg2EiakTPPXhcY+iCB78RqHUs2agRDOQNnFDZe3AxbHq/vG
nNPpJcwz2EA8kxuNMDm/gSEpvx6QUUpk+dxZuKq/LGUqrhIH0TPyeOB58DuciU5P
KjJIBSDaOAQ8dM1UzBTu6v8lH+SrYt+73aMxShzdJSaewnHQRgECyL32aXUI5qSy
kwkO+Mw/sJsnirmUiXGSFCeWcIHCMPp12ZIuHCEb9+Qc88S6pT9f/94oIqpMT8mW
Cw60wuj5amS4ip5yu00XtGTe4RFioTvxCYxPt4rW1DTiVC1f91jPI64/kFBvtDDH
AXK090ScZq6OvTB17JVNSsAo60fliT9WuQtLUIn4apNZoKTvBE6LfPvGUn0uY8XY
dQb+Nbe2RBUxukdD01ap
=Hts+
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
