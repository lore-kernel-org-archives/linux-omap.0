From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/7] phy: ti-pipe3: use ti_pipe3_power_off to power off
 the PHY during probe
Date: Tue, 4 Aug 2015 11:06:31 -0500
Message-ID: <20150804160631.GH23659@saruman.tx.rr.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com>
 <1438701646-7876-3-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438701646-7876-3-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 08:50:41PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Previously omap_control_phy_power() was used to pow=
er

there is a slight functional change. You moved PHY power off from before
to after pm_runtime_enable(), clk_prepare_enable() and creation of the
PHY device. That ought to have a slight impact on how the driver
behaves.

--=20
balbi

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwOMHAAoJEIaOsuA1yqRECdkP/RLmFLYqXu40f37ywImNtAbp
e43HP8Gr5yL65G/nZfJ4MRgTKtTd544925znvKmTgJXHRrfUK5YyvotBVER53/4A
lxBNxA2Fg9y83M5Htrbwg360mf1go0YDllhG9H3QN/+/fA+up2Q4kGi7/mB/skuS
EzlU/W6Hvwl0CjVtehufAzBu32QJGnIekGt+CQkbCiKCAYGA07TA1XHaiXzV+MRP
nmRlV95oEf7yvkODThEz2CY+BOo45B9t1cFWphA0twd3Okwvj3OC48onDYXZqeDX
Z/B3bOBeZnpWket1/bJOzXnFdtSTUpzHHXWiZwDzeLG2DbVlO/WlLHYFVSmFqEPE
wlQt3dOzlBZHp7ud1tZ1ClPSs2JTH+7CTI7oJvnanFIGctS3mOxk0sWXzNg8F59/
zCCIBF7x33B9jSfONN7eI4tdcZYT3RafB5/ED+FsAF/tNduO8RRkBTIMYDaQSkEr
6hz/wdcACk+civZbyq6YHSeulaOkPRPa1uqflUotRnGA3i0psjDbaTifbo6mcWzf
6zbbc3eeitYfnRlQUU844vSQVtkju42Hjlz4GSuwsUfh1HH2R5Efi5qyDDNGY3fg
qGHUWzAMCfcNyhpKgdrvAFVGJEX/6tu/5SzdcNIBxhseTGCsFN5uWk1uwtMPgiGX
1tELllij30tX1OX8y+N3
=pwLB
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
