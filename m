From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 07 Aug 2012 12:57:16 +0300
Message-ID: <1344333436.7216.32.camel@lappyti>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	 <20120807084815.GK8468@arwen.pp.htv.fi> <1344330329.4091.16.camel@deskari>
	 <20120807091415.GN8468@arwen.pp.htv.fi> <1344331672.4091.22.camel@deskari>
	 <20120807093207.GO8468@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-nvv+WN0ihDfn7eKAJwFf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37989 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752316Ab2HGJ5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 05:57:21 -0400
Received: by lagk11 with SMTP id k11so1011574lag.30
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 02:57:19 -0700 (PDT)
In-Reply-To: <20120807093207.GO8468@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>


--=-nvv+WN0ihDfn7eKAJwFf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-07 at 12:32 +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Aug 07, 2012 at 12:27:52PM +0300, Tomi Valkeinen wrote:
> > On Tue, 2012-08-07 at 12:14 +0300, Felipe Balbi wrote:
> >=20
> > > Or you could use the driver_data field on the platform_device_id and
> > > of_device_id structures for that. Something like:
> > >=20
> > > static const struct platform_device_id dss_id_table[] __initconst =3D=
 {
> > > {
> > > 	{ "omap2-dss", omap2_dss_features },
> > > 	{ "omap3-dss", omap3_dss_features },
> > > 	{ "omap4-dss", omap4_dss_features },
> > > 	{ "omap5-dss", omap5_dss_features },
> > > 	{} /* Terminating entry */
> > > };
> > >=20
> > > then, on your probe, you just need to copy id->driver_data to your ow=
n
> > > structures so you can reference them later. No need for cpu_is_* or
> > > soc_is_* or machine_is_* anywhere.
> > >=20
> > > On your platform_code, wherever you create the dss device, you need t=
o
> > > fix up the name though. The platform_device name should match
> > > platform_device_id name, not platform_driver name.
> >=20
> > I've thought about that, but we need versions even for different OMAP E=
S
> > versions.
> >=20
> > So in the device tree data we couldn't have the DSS nodes in a, say,
> > common omap4 file. We'd need separate DT files for each OMAP ES version=
.
>=20
> you can overwrite attributes on your board dts file, right ? Meaning
> that e.g. omap4.dtsi would have:
>=20
> dss1: dss@xxxx {
> 	compatible =3D "ti, omap4-dss";
> };
>=20
>=20
> then on omap4-based-board.dts:
>=20
> &dss1 {
> 	compatible =3D "ti,omap4-based-board-dss";
> };
>=20
> or something similar. Isn't that doable ? Benoit, would this work on
> DTS ?
>=20

Yes, they can be overridden, but I think it's still quite difficult to
manage. DSS is modeled with multiple blocks, also in DT data. So you'd
need to override multiple entries.

And it'd also require a new dts file for each version of your board with
different ES version.

Also, I don't really see why this information would need to be present
in the DT data (especially as it's not simple). It's all trivially found
out in the code, by using cpu_is & soc_is.

 Tomi


--=-nvv+WN0ihDfn7eKAJwFf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIOZ8AAoJEPo9qoy8lh71wF4QAKEG69I0FguIhrGyAY9HrOOH
6LwMIV07VSpwtvXUuNlTOgcpSYsX2JSUi8/QIpCiGmll4QPs+Bd/wC1OmIKgRVfZ
FKUTxs+rfd6P7rqo6W9ttKICkvSefd+35g4wSREZvfkrRNgi8dg4FGkZtIJCvh4Z
g2vs9JpDm0bbMnluXhEiGszy18CKsFp4HuaRcFJl2YCf+AV2zO7kuluwZxiqAAOw
6qR5VFFxE9+GVGRVrTkfBzwzpiI8G3XHR1D98R40IzqfnpmbuVMpaWwFAKrINcba
lbC9BVHYsdXDwhsTFJMm4glT4mu00lcg9LN+BH3SWU+ZE2UAFwIvS6cq0GWEUR4B
BzfOwvaZSgEVB+MvLzZeEqrmOuP6gdHFpmMQiEoNBmCcXheAroL2g0VZCNPGu3+W
DKE5u78hRy9fyIIZcTRRAA6bz3XPoOVw1XhEAyWaghQXx29A0/5yw8ahgRq+zPgm
XA2YCyQ1ax9IG6x6+FhBtTKE4R9Ngp/ZElzLbUaoae3XzBJhwepIYqBQTY7DdIoY
gqDNIZlK5KawbOLkLehSi3P8oy2fNv701Vtyn0J3gbytess8C3c3W25ZBjSifv3b
pUlmD6JvxB5I5fVg7g4uU3nuCIl3SCkUDEkRgch2VCGno79lo9UbSABJGgN36obp
KOmAz5c+ThkmFs1c1Fk0
=BzOE
-----END PGP SIGNATURE-----

--=-nvv+WN0ihDfn7eKAJwFf--

