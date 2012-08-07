From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 12:32:09 +0300
Message-ID: <20120807093207.GO8468@arwen.pp.htv.fi>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
 <20120807084815.GK8468@arwen.pp.htv.fi>
 <1344330329.4091.16.camel@deskari>
 <20120807091415.GN8468@arwen.pp.htv.fi>
 <1344331672.4091.22.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gqEssfNGWsEa4HfM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:60786 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170Ab2HGJfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 05:35:44 -0400
Received: by lagy9 with SMTP id y9so1252474lag.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 02:35:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344331672.4091.22.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>


--gqEssfNGWsEa4HfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 07, 2012 at 12:27:52PM +0300, Tomi Valkeinen wrote:
> On Tue, 2012-08-07 at 12:14 +0300, Felipe Balbi wrote:
>=20
> > Or you could use the driver_data field on the platform_device_id and
> > of_device_id structures for that. Something like:
> >=20
> > static const struct platform_device_id dss_id_table[] __initconst =3D {
> > {
> > 	{ "omap2-dss", omap2_dss_features },
> > 	{ "omap3-dss", omap3_dss_features },
> > 	{ "omap4-dss", omap4_dss_features },
> > 	{ "omap5-dss", omap5_dss_features },
> > 	{} /* Terminating entry */
> > };
> >=20
> > then, on your probe, you just need to copy id->driver_data to your own
> > structures so you can reference them later. No need for cpu_is_* or
> > soc_is_* or machine_is_* anywhere.
> >=20
> > On your platform_code, wherever you create the dss device, you need to
> > fix up the name though. The platform_device name should match
> > platform_device_id name, not platform_driver name.
>=20
> I've thought about that, but we need versions even for different OMAP ES
> versions.
>=20
> So in the device tree data we couldn't have the DSS nodes in a, say,
> common omap4 file. We'd need separate DT files for each OMAP ES version.

you can overwrite attributes on your board dts file, right ? Meaning
that e.g. omap4.dtsi would have:

dss1: dss@xxxx {
	compatible =3D "ti, omap4-dss";
};


then on omap4-based-board.dts:

&dss1 {
	compatible =3D "ti,omap4-based-board-dss";
};

or something similar. Isn't that doable ? Benoit, would this work on
DTS ?

--=20
balbi

--gqEssfNGWsEa4HfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIOCXAAoJEIaOsuA1yqREh/YQAJIIvfXvn/dTtqJcmAljnGm0
gnYf2hrMGOHbAKJRom9DfTWA92xpVCpua9wuvxGsH2jA3YG1qH8+e914UF/gQ66t
16PSaFSckKpADLEPRqtISHRBmZu2G16DGL+Zac4CaEbuVWOGVghQ8oVsJ0AwC1yR
2f52Rcr8fj7YdotJAKPGFcLSnkZykWgdEo0OFgX/FYdSFUvriMsrAThI1cr78qd7
Jk3P5h4RXksAJfwnErtaMHMu//4Z8zQIostDTvkb/Q9Pwd+SMAe5RT0Bvg8zm/zr
oiUVefCP9vgLUd7H02sxFrhfAZeKPl5jqj7rUKPEOP9rtJxlF31mOUhPUU59IdZB
Q59oYaMKinUhMWFEspMUUqQQhqyEO7dxT0/xniREaQdL8ujR47xWTsrCTaaNQzPp
w7D1xrWCsjeRY+xM6GT8HpvfK2Vm956SdkRoUdN7k6Kbq8/xu64oL+GS42MrsTLw
/RbKYlOyiWYSmrBuQA7eosEMK9ASedLONFguN1jT8n6RSwnrQeAPKcUZyMGICLRW
3vWpDhKNTyOgUatWduvurnKQ9UFlfzcow9OZU25LOIE6vVdxFth5z1Eq/Zmgk56c
ejthhQ5TT9PRKIqHQhCYDK4sX/SIiJNotNW2Y03MoaRarjjzG6Wk1tBPElNCVNPa
uHH9LV6j3YTsOXCnmdv0
=vtRX
-----END PGP SIGNATURE-----

--gqEssfNGWsEa4HfM--
