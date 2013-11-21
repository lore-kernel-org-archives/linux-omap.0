From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Fix eMMC on n900 with device tree
Date: Fri, 22 Nov 2013 00:17:52 +0100
Message-ID: <20131121231751.GA9772@earth.universe>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
 <1385059866-10646-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:35598 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754626Ab3KUXSC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 18:18:02 -0500
Content-Disposition: inline
In-Reply-To: <1385059866-10646-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, Nov 21, 2013 at 10:51:06AM -0800, Tony Lindgren wrote:
> Looks like we need to configure the regulators and use the pdata
> quirk to make eMMC work with device tree.
>=20
> It seems that mostly vmmc2 is used, and only some earlier revisions
> like the macro board used vaux3.
>=20
> Note that we can add support for the macro board later as needed
> by including the common n900 .dts file and configuring the vaux3
> instead of vmmc2, and adding support for the smc91x Ethernet.
>
> ---
>=20
> Can you guys please test this on production n900 devices?
>=20
> I've tested it with my old macro board where I had to patch in vaux3
> instead of vmmc2. I think there's some confusion in the legacy code
> comments, or else I'm confused. In any case, vaux3 works for the macro
> board, and I suspect that the production versions have vmmc2.
>=20
> If this does not work and vaux3 as regulator works, please also dump
> out the system_rev from your board.

The good news is, that I got eMMC working :) The bad news is, that it
did not work with your patch :( I included my DTS nodes below. The
phone is HW/System revision 0x2101.

I have a second N900, which has HW revision 0x2204. I did not yet test
the patch with this phone, but legacy code also seems to use vaux3 for
it. Seems like we need two n900.dts files?

--- DTS nodes working on the 0x2101 board ---

&omap3_pmx_core {
	mmc2_pins: pinmux_mmc2_pins {
		pinctrl-single,pins =3D <
			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk */
			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd */
			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc2_dat0 */
			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1 */
			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2 */
			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3 */
			0x134 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat4 */
			0x136 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat5 */
			0x138 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat6 */
			0x13a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat7 */
		>;
	};
};

&mmc2 {
    pinctrl-names =3D "default";
    pinctrl-0 =3D <&mmc2_pins>;

    vmmc-supply =3D <&vaux3>;
    vmmc_aux-supply =3D <&vsim>;
    bus-width =3D <8>;
    non-removable;
};

-- Sebastian

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSjpSeAAoJENju1/PIO/qawmUP/0TwNvomoNlOM4IV9rhkX6oY
kRLhH2uJ+lpLihUEKHORrRIrircRe+A+57XOMw/y4em00/wKcERQzGCn6he5fpyo
oad1oYGm8v4sPatob/1Gjy9viWiNW/y1eW+/oOrI7+eZElXvW4O09BGlXJU5wFYy
IaBq6Q6mBtS7w5/olcH+0mIuXFEnrGW6v7fK53F6EjMsbjHYE9I8fU51WDrJ1W/I
+GVQ6TDiv4BUTQjQKhc2MBTz9yMAjB5FovnrNB/0UE13AdeAxp1E7h6w3sO9eoUV
5EzCL4riC044llsgmZih8yTh2H7yDSyIDRBt55YURZCTR+LuhmG7L/HCQqH73kvY
GPKiWV+gqTKuTIQosbnO7Kt8OSHseJLGWQ3u7XSzWC+dZQMzNE0XlH5H3ItA1Enl
l+ZQ4d/rLnLwxpH63AgQ/a6udvV89xH/pdH6G6Ra1M0NymY6TWqFZJzD3HKCw523
VCl1nQgFcEIKMHriL3O/avq50KAqb0KZ4tVhjVGLlR2pK4JWF4GLX4zYOD4bw7/G
HW7dE7djguf/Rgew6Opv/hNpxawGsEzjY0nQmm0a178C+YgKfSHOGAbxiifiZ7hR
NaKljLDCyBlLA8KVqaV2E0/R4InQScXZz/X1E1J+I5s9u2tRsMemflDrb0+L8b8N
8Ildt5oxA/t/MkWvtRld
=zzN8
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
