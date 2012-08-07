From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 13:27:14 +0300
Message-ID: <20120807102712.GP8468@arwen.pp.htv.fi>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
 <20120807084815.GK8468@arwen.pp.htv.fi>
 <1344330329.4091.16.camel@deskari>
 <20120807091415.GN8468@arwen.pp.htv.fi>
 <1344331672.4091.22.camel@deskari>
 <20120807093207.GO8468@arwen.pp.htv.fi>
 <1344333436.7216.32.camel@lappyti>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+W7ryvxEk4RRyt+P"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36496 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999Ab2HGKat (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:30:49 -0400
Received: by lahm15 with SMTP id m15so2190082lah.31
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 03:30:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344333436.7216.32.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>


--+W7ryvxEk4RRyt+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 07, 2012 at 12:57:16PM +0300, Tomi Valkeinen wrote:
> On Tue, 2012-08-07 at 12:32 +0300, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Tue, Aug 07, 2012 at 12:27:52PM +0300, Tomi Valkeinen wrote:
> > > On Tue, 2012-08-07 at 12:14 +0300, Felipe Balbi wrote:
> > >=20
> > > > Or you could use the driver_data field on the platform_device_id and
> > > > of_device_id structures for that. Something like:
> > > >=20
> > > > static const struct platform_device_id dss_id_table[] __initconst =
=3D {
> > > > {
> > > > 	{ "omap2-dss", omap2_dss_features },
> > > > 	{ "omap3-dss", omap3_dss_features },
> > > > 	{ "omap4-dss", omap4_dss_features },
> > > > 	{ "omap5-dss", omap5_dss_features },
> > > > 	{} /* Terminating entry */
> > > > };
> > > >=20
> > > > then, on your probe, you just need to copy id->driver_data to your =
own
> > > > structures so you can reference them later. No need for cpu_is_* or
> > > > soc_is_* or machine_is_* anywhere.
> > > >=20
> > > > On your platform_code, wherever you create the dss device, you need=
 to
> > > > fix up the name though. The platform_device name should match
> > > > platform_device_id name, not platform_driver name.
> > >=20
> > > I've thought about that, but we need versions even for different OMAP=
 ES
> > > versions.
> > >=20
> > > So in the device tree data we couldn't have the DSS nodes in a, say,
> > > common omap4 file. We'd need separate DT files for each OMAP ES versi=
on.
> >=20
> > you can overwrite attributes on your board dts file, right ? Meaning
> > that e.g. omap4.dtsi would have:
> >=20
> > dss1: dss@xxxx {
> > 	compatible =3D "ti, omap4-dss";
> > };
> >=20
> >=20
> > then on omap4-based-board.dts:
> >=20
> > &dss1 {
> > 	compatible =3D "ti,omap4-based-board-dss";
> > };
> >=20
> > or something similar. Isn't that doable ? Benoit, would this work on
> > DTS ?
> >=20
>=20
> Yes, they can be overridden, but I think it's still quite difficult to
> manage. DSS is modeled with multiple blocks, also in DT data. So you'd
> need to override multiple entries.
>=20
> And it'd also require a new dts file for each version of your board with
> different ES version.
>=20
> Also, I don't really see why this information would need to be present
> in the DT data (especially as it's not simple). It's all trivially found
> out in the code, by using cpu_is & soc_is.

Fair enough. I just think we should remove all cpu_is_* and soc_is_*
=66rom drivers.

--=20
balbi

--+W7ryvxEk4RRyt+P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIO2AAAoJEIaOsuA1yqREZsEP/RaUkLCVYWdASsID2xJIZf6N
P7ULu/6aJF3qZ2HwVHQfk3v6uJwBOKhWV+ZobJsfww4S3FWwFlaujbhPH5C8E7V7
+OczQPFDRj8weofcTa/ssNnLm4CC0cSGCwgouUv1ajji/qJ5X3XWGxzOsVS+7ywm
c+sXx1Pf3lp7Nse7Pe/7ZqKMln9bMSDSErvRqL7LANi8diIoLqXaNJlYxbZAjIad
HaSZe093v0bABeIwmr+PzVH9lrsW3eGICtauaiSEbrgLpMK8Tmm0S8BqKZWa3O9d
ZTp/0TS9650VZLxel106DqiWtwfOkzXouzOluhf2QWl1Ma8SaCHMnxKvZ2S4eVrY
3GT1Lb+HpJ49blxdBubfWToh/7gm2ZZCZ3LJZDNR+ztoZmM4NVzxW+1sWDn6r/ha
ZMQ3coPbPyhqjFj26h5wS82iq6TqGec8Jy6EQy8Co1XbmjZWDLSqDEJ3nNvUMEhx
vN7tIBhnlML4QFTp43ZnrAu6bX9vfMA/Fe8P3NelcyKPQq4Xz5fFZQJgPHkYaz0x
FyNAiZxln7BKzeiD4PnxMCB11RjLqOi//a7/wKMAnQ3EPCX5XGAZhjGE2IsdtjwF
2/NVFEisfo0OM0Xwn4bPEmMGC/btwgQKXIsHa007f9g3kwiAnDaE/wrPOU7FgJXq
p7hw7S03t2PTnD9Jq0gV
=DK66
-----END PGP SIGNATURE-----

--+W7ryvxEk4RRyt+P--
