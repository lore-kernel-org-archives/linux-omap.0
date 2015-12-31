From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Thu, 31 Dec 2015 22:14:07 +0000
Message-ID: <20151231221407.GF16023@sirena.org.uk>
References: <568088B4.6090207@ti.com> <1451342963.14631.13.camel@collins>
 <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk>
 <1451500639.14341.6.camel@collins>
 <20151231214007.GC16023@sirena.org.uk>
 <1451599146.9673.2.camel@collins>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4369672345729596225=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1451599146.9673.2.camel@collins>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============4369672345729596225==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iBipwI8N6cjWJAiJ"
Content-Disposition: inline


--iBipwI8N6cjWJAiJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 31, 2015 at 10:59:06PM +0100, Paul Kocialkowski wrote:

> I understand, thanks for pointing this out. Well, for my use case, there
> is no use in disabling the chip at any point as it powers the external
> mmc.

Presumably someone might decide not to use the MMC in some case (perhaps
only mounting it when explicitly needed in order to save power for
example, or the MMC subsystem might figure out a way to power down an
idle MMC block device).

> Would you agree to have the enable pin handled directly (and by that, I
> mean enabled once, when requested, as I first suggested in the patchset)
> in the driver then?

That's probably fine, or do it via runtime PM (the framework is fairly
simple to use, I'll probably go add support in the core for it in the
next day or two as this seems like a sensible use case).  I can't
remember if this device is a MFD or not and I'm just on my way out the
door.

--iBipwI8N6cjWJAiJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWhaivAAoJECTWi3JdVIfQBTwH/0c97iPmjv0ncNLyJswoLHqH
RR8JvifjbS7jtarqTON7EfCHu2P4ChZKCEsTUpph5h5T95lQUj6Z8BGscgCUlkXG
TB2sxJzf+8kQecbleQmbXYG6FjyK4s0oK8Dm0f/m3m5LdRXoosMSy11gJ6eLrGmI
ydei7K8T1YZU7tEdDSV4qB1iRaKLl3YDD7Pd/UUk6GVq7SIJXbzO+U43R8t9GnI4
KYw6R92LgbkKBN6MFKCHdzNeooxhIiwF2lIiiccJTAIvIGnNoFzbxkFapK+nvWhn
cisUfBnWxAkEAmlImyX2xwygNON56NOvmdHYqKnbs1jV2ybG60qJLfxhv80BzXw=
=Yj1A
-----END PGP SIGNATURE-----

--iBipwI8N6cjWJAiJ--


--===============4369672345729596225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4369672345729596225==--
