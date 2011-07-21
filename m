From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: replace pr_* prints with dev_*
Date: Thu, 21 Jul 2011 20:43:07 +0300
Message-ID: <20110721174306.GD32058@legolas.emea.dhcp.ti.com>
References: <1311269976-4035-1-git-send-email-khilman@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57510 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678Ab1GURnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 13:43:14 -0400
Received: by ewy20 with SMTP id 20so1812190ewy.2
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 10:43:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311269976-4035-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2011 at 10:39:36AM -0700, Kevin Hilman wrote:
> For consistency in kernel printk output for devices, use dev_dbg(),
> dev_warn(), dev_err() instead of pr_debug(), pr_warning() and
> pr_err(), some of which currently use direct access of name from
> platform_device and others of which use dev_name().  Using the dev_*
> versions uses the standard device naming from the driver core.
>=20
> Some pr_* prints were not converted with this patch since they are
> used before the platform_device and struct device are created so
> neither the dev_* prints or dev_name() is valid.
>=20
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

BTW, I tried applying this to today's linus/master, but it fails
(rejects below), are you depending on some other changes ?

--- arch/arm/plat-omap/omap_device.c
+++ arch/arm/plat-omap/omap_device.c
@@ -242,28 +239,27 @@
 	if (!clk_alias || !clk_name)
 		return;
=20
-	pr_debug("omap_device: %s: Creating %s -> %s\n",
-		 dev_name(&od->pdev.dev), clk_alias, clk_name);
+	dev_dbg(&od->pdev.dev, "Creating %s -> %s\n", clk_alias, clk_name);
=20
 	r =3D clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
 	if (!IS_ERR(r)) {
-		pr_warning("omap_device: %s: alias %s already exists\n",
-			   dev_name(&od->pdev.dev), clk_alias);
+		dev_warn(&od->pdev.dev,
+			 "alias %s already exists\n", clk_alias);
 		clk_put(r);
 		return;
 	}
=20
 	r =3D omap_clk_get_by_name(clk_name);
 	if (IS_ERR(r)) {
-		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
-		       dev_name(&od->pdev.dev), clk_name);
+		dev_err(&od->pdev.dev,
+			"omap_clk_get_by_name for %s failed\n", clk_name);
 		return;
 	}
=20
 	l =3D clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
 	if (!l) {
-		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
-		       dev_name(&od->pdev.dev), clk_alias);
+		dev_err(&od->pdev.dev,
+			"clkdev_alloc for %s failed\n", clk_alias);
 		return;
 	}
=20

--=20
balbi

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKGUqAAoJEAv8Txj19kN1HYkIAJC9sIsA15gnTP9dU6J1c2Jl
Uw/Z6mx0Vlr257IcUYpWt3mUrEhxs4k8Hc7L5PbbZ06aitz482jdsnJq7pWKq6V+
AV9dNRLed4ri1iI7gk0a/ggU2hg+oTEsdWl7H/ydKXLKbFP0nQOYk7viNBaAxZQa
CxxGtgUdPs7iORzZVzkJUYiOdg+cAbc4N62gkv8pOSxBasmCvv6bg1AeeQqYKiM2
A2KshK1FOBZihbG0o/g77nwQA/AvhAEV9fTHWN2gA24xeRM6t+DtHzVGT1oNhZHq
GNqdolWeplp93vaDQh0++QIw1A0M4PD0s3Fxf/IvJc9X+xmi6NXboGUoD85TlwY=
=tBD5
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
