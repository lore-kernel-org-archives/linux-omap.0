From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 18:25:36 +0000
Message-ID: <20170125182536.4egdvfn5v65e6dok@sirena.org.uk>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ysssc22lrccilafq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Furquan Shaikh <furquan@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>Lin
List-Id: linux-omap@vger.kernel.org


--ysssc22lrccilafq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2017 at 08:56:42AM -0800, Furquan Shaikh wrote:

> I understand that ACPI provides its own bindings to allow firmware to
> control power management and thus regulators have been a part of the
> firmware control. However, there are use cases where the kernel driver
> wishes to control the regulator to manage power to the device
> irrespective of the way regulator is passed in (ACPI/OF).

You're missing the point here.  What we're saying is that if you want to
do this using ACPI you should extend ACPI to support this directly so
where regulators need to be controlled by the OS there's a clear
understanding of how this interacts with the rest of the ACPI power
management.

> We need to support existing drivers and use cases for power management
> in both OF and ACPI environments (keeping in mind that suspend to idle
> bypasses parts of firmware) without needing to change all the drivers.
> How can we achieve this?

Consumers already don't know they're using DT, there's no reason they
should have any impact from ACPI either except possibly a bit of name
translation for ACPI's idiomatic naming conventions.

--ysssc22lrccilafq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliI7Z8ACgkQJNaLcl1U
h9AeUwf9G5svymYOJ8seoy4cwNyS+PJZo5IlLDI5aqED7v4bl4i43/cwObkcAcDM
VRuRsKUjLGdk16ERnz6j1mqwH6yGlnKQanrZkrSjxlex9pZZmhL8H08b+syGO5ko
r0Tuq9a2Iz/HkirSIZm+4+WH0eO6wi7/m1XV/F/HCE4QzUOR7fhNUeOacS9wqCiz
IKYVpxB7DgcL/lhA3PzhRGtTWSkPxBIES0Gk3NNEgC1vzRBAP3ULY8ZYJkYRtftA
eZeAGhrnFrF/AphTXuAl7X2pxis5ZAvFpK5gxjPT651PRjzcPiEh5YthdyldJYQi
dx3JQIzkk7uUnO/VHYVB2qc4M/ND7A==
=7Mqy
-----END PGP SIGNATURE-----

--ysssc22lrccilafq--
