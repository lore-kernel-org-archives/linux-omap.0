From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Thu, 15 Mar 2012 11:27:36 +0100
Message-ID: <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56229 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2COK1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 06:27:46 -0400
Content-Disposition: inline
In-Reply-To: <201203150922.06379.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Arnd Bergmann wrote:
> On Thursday 15 March 2012, Nicolas Ferre wrote:
[...]
> > +	i2c1: i2c@1 {
> > +		...
> > +		dma-request =3D <&sdma 2 &sdma 3>;
> > +		dma-request-names =3D "tx", "rx";
> > +		...
> > +	};
>=20
> This is slightly different from how the proposed pwm binding works that
> Thierry is working on, which uses an arbitrary property name instead of
> requiring the use of a specific property but then allowing to give names
> in another property.
>=20
> I don't care much which way it's done, but please try to agree on one
> approach that is used for both.
>=20
> The one you have here is already used by reg and irq, while the other
> one is used in gpio.

I think we can just use pwm as the fixed property name. Or alternatively do
something along the lines of the regulator bindings, where we use "-pwm" as
the suffix for specifying PWM devices. For instance if a named PWM is
requested, the OF support code would look for a <name>-pwm property, while
requesting an unnamed PWM would simply look at the pwm property.

When it comes to the labelling of PWM devices, I don't think both variants
are exclusive. Currently the PWM framework uses name of the user OF device
node for the PWM label. That is, if I have the following in the DTS:

	pwm {
		...
	};

	backlight {
		compatible =3D "pwm-backlight";
		pwm =3D <&pwm 0 5000000>;
		...
	};

Then the PWM will be labelled "backlight":

	$ cat cat /sys/kernel/debug/pwm
	platform/tegra-pwm, 4 PWM devices
	pwm-0   (backlight           ): requested enabled
	pwm-1   ((null)              ):
	pwm-2   ((null)              ):
	pwm-3   ((null)              ):

So if we decide to explicitly allow specifying names, then we can always add
a pwm-names property (or <name>-pwm-names respectively) to use as label and
fallback to the user OF device node name if that property is not present.

Thierry

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9hxBgACgkQZ+BJyKLjJp+cfgCeNPt89SdKIe6UAhmqp5mI0Oqh
Jc0An3FhxpkeYt/UchwC1OVoVvz7Waj7
=SNUB
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
