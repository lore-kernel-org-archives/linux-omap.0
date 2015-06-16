From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
Date: Tue, 16 Jun 2015 17:08:29 -0500
Message-ID: <20150616220829.GB4313@saruman.tx.rr.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <1431115050-23693-2-git-send-email-balbi@ti.com>
 <20150616214032.GA4313@saruman.tx.rr.com>
 <CAJZ5v0hO+Rbcyq8Gcpecdw9rGW1Qdhrmj6X6TVtRpLOxQKW+=g@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55231 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbbFPWL3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 18:11:29 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hO+Rbcyq8Gcpecdw9rGW1Qdhrmj6X6TVtRpLOxQKW+=g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 12:04:07AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 16, 2015 at 11:40 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, May 08, 2015 at 02:57:30PM -0500, Felipe Balbi wrote:
> >> by adding the missing MODULE_ALIAS(), cpufreq-dt
> >> can be autoloaded by udev/systemd.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >
> > looks like this wasn't applied anywhere. Viresh, can you apply this
> > patch please ?
>=20
> I've overlooked it, sorry about that.  Applied now, thanks!

Thanks Rafael.

--=20
balbi

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgJ5dAAoJEIaOsuA1yqREumMP/3n7CDwAsV3Irdr7PRalsoN5
9GF44FVT24IRV21rc+VduiJEIcWfQ8aIoM5ekGpSjTIFkZzIYy3WQTo3uxXPumcd
IARjLTaD0h9vSRwATwFVUpJTXxNplucTcu/jqzznLaqP24VuvHmHLUJQ0zH0rM1d
dCs6wv0aGHkuYY4XUvmDKYF7x9PS6AD9vq/Iaq/gOUY05x7uv7wVfyqgP29dyVuo
xBLYqhtXu88Ide8GPOJztzxdZL1ep8aIuQKEI7Kx+Y0ZhyE4rSdyyYWdufI6AN3k
ssjKsxD3LiiwCp7mzwnD+pe+144/GMiiJ8d3OzC3L6zWHnbVvfzQBiVHSn4EF/3u
tUi+I5S42HZwaWCiI77LjeoEUsdv9wfmVwrag3vplNgzXPelOLjFfkw8GXpIRMnv
inBTdibiAn5aqdkCqETifMfLReT/K2+QbHzaSjdbGaSdkytcNHpKY8Lx8fXi4Y3Y
ijf3wNG1eB+Oy3A0DwDbWPZuAjHPlWwdgQ6+UDTPzenvobZXkp1D5VAVCRyZzfs5
jnNWSrnTCNrL9V8okmqhdgFdSJdR1C09zq5lZWHQggENytGl85XKTIxgqs2yCVyS
www6NCK3nnCVlBnIHY0Advpd5RmguqC/BtyqL8EBYwzLdI4C0PWJz2i0IrZYV/gn
Nt5Yg1qTALpvU+WfSZjX
=LbIZ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
