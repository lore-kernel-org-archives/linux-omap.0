From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain
 data
Date: Tue, 9 Feb 2016 13:53:27 -0800
Message-ID: <20160209215326.GC27284@localhost.localdomain>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160208195704.GW19432@atomide.com>
 <56B95EF7.9080107@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B95EF7.9080107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2016 at 09:07:27AM +0530, Keerthy wrote:
>=20
>=20
> On Tuesday 09 February 2016 01:27 AM, Tony Lindgren wrote:
> >* Keerthy <j-keerthy@ti.com> [160208 01:19]:
> >>OMAP5 has 3 thermal zones cpu, core and multimedia.
> >>On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> >>and iva. Currently cpu, core and multimedia are being added via dt
> >>and the other 2 are getting added via kernel. Add the missing thermal
> >>domains in dt so as give the correct trip numbers, type and temperature=
s.

But the driver would add these default domains only if booted /loaded with
missing DT device entry, right?


--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWul/TAAoJEMLUO4d9pOJWHeoH/1KPkUre5jLcngs/kQabAOgz
uK3xPLPB0skUm0DByrUVadHbK0KTjP77aPg30o1K7F8igLUMt/uKFv49P60Cm28a
wSZCM7PrabGFfrj/PMxetBi5NVh/piZqP82rUAKypkamRh65RN9xGV4ea/s9ZtAZ
N+bZvF7PryF01nYKFmPeCjmUjy1brWDyO1vp1VkG0dqVjAI8XQRWyXjbAtFGW6hW
7rD1yOy80gyfYS0EMOTm117oEIewoiJnhOnWKzkMWHvFbXXNvgGlRHp8YnbVNNNB
EexaHqXv0KpC/b95UCs9jNu0acX7mS29qHPKFmwLNKpdKLtg+VDXwQ/snlDNXX8=
=4oEf
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
