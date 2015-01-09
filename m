From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] treewide: Convert clockevents_notify to use int cpu
Date: Fri, 9 Jan 2015 12:34:56 +0100
Message-ID: <20150109113452.GF16465@ulmo>
References: <1418254133.18092.22.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418254133.18092.22.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 10, 2014 at 03:28:53PM -0800, Joe Perches wrote:
[...]
>  arch/arm/mach-tegra/cpuidle-tegra114.c |  4 ++--
>  arch/arm/mach-tegra/cpuidle-tegra20.c  |  8 ++++----
>  arch/arm/mach-tegra/cpuidle-tegra30.c  |  8 ++++----
[...]

Acked-by: Thierry Reding <treding@nvidia.com>

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUr7zcAAoJEN0jrNd/PrOhrsAP/iWqYSubPYR6Plip5QDe/QoP
9bcbtfr5b+PsC/H1evIRrWKNo5E68ZZNJpA4FfPSGs1NAqqfl0/7fG1s6j2E38dG
UWwLGFQ/tzRJht0SzbehEIef8ZZ0w2Y9dmVoriQoQq0FjHJqbG3zf2tsPFkztIvI
+zaOSc/FHTH6lN2fjqbySFT6+NF32Hx4IoO4pKrp2upqMh7LiWaAt6h6RE8Xb84o
3eu0Ooyqc8g1vHmZu4vGB7eQsHHF3l3DBEdKLrnXaJXd92RlzQFy/rhoN2A+rClr
kadKPbfH8HV4ENG1l5j2fPhzx/rsZMI1KLgKssm1xbGF8tPUromdroL3VuayI+y8
WEO2LoXUb3RH5zh6QarQvZyCPzDba5s33sk8Z03NoazTtp1ldAE29UAORrzfdEFq
YCDExJsxFZwYT1bkTvlMKjeL22SAh3LKiJuTCerqGvRZkAwVZnmdsTmnxjcotWRC
SZvIJjoAbkanqyUZN7Jrz6Txl37ZPET6dZxFcqLXDoiPfAJ3H3rYVp8d6fSejcH5
N2x8wGwwkWLQScxRVRv0aQsERpT6UHfYyADVBMPIKz2OhRXoy0nCSdFtB7KsY43r
FxeOEM9JQvuuIiH/NsoNR19613E7pboA00siPF8QPyIE93JB9rSIQgqkK4SbbnL0
Iumq7l9GgNhbA6mm931L
=XFHi
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
