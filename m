From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Charging status for N900/RX-51 with bq27200
Date: Thu, 15 Feb 2018 21:41:53 +0100
Message-ID: <20180215204153.ztdal3qhtmgi7sjo@earth.universe>
References: <581dcb51-f469-61c9-e023-62ac535bc41a@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="epatvcpwpj5qbrqd"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <581dcb51-f469-61c9-e023-62ac535bc41a@wizzup.org>
Sender: linux-pm-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--epatvcpwpj5qbrqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Merlijn,

On Thu, Feb 15, 2018 at 12:53:32PM +0100, Merlijn Wajer wrote:
> On my N900, with kernel 4.15-rc6 (I realise it's not the very latest),
> the (charging) status of the battery is confusing or plain wrong:
>=20
> When no charger is connected, this is reported:
>=20
> # cat
> /sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0055/power_supply=
/bq27200-0/status
> Not charging
>=20
> When a charged is connected, this is reported:
>=20
> # cat
> /sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0055/power_supply=
/bq27200-0/status
> Charging
>=20
> The odd part here is "Not charging" -- on all my other devices, a device
> that is discharging is reported as "Discharging", not as "Not charging".

"Not charging" is reported, when the battery is neither charged, nor
dis-charged. It's supposed to be used when a charger is connected
without charging the battery.

> [...]
>
> The N900 reporting "Not charging" when it is in fact discharging
> confuses userspace, such as UPower.

It's a bug.

> I am not particularly versed in the N900/RX-51 drivers, but from a
> quick glance this line looks suspicious [1].
>=20
> Cheers,
> Merlijn
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/power/supply/bq27xxx_battery.c#n1673

Basically the bq27xxx driver assumes, that charger is connected.
I guess the problem is, that the N900 devicetree does not specify,
that the bq27xxx is supplied by the charger, so
power_supply_am_i_supplied returns -ENODEV.

This can be fixed by adding the following to the N900 DT:

&bq27200 {
    power-supplies =3D <&bq24150a>;
};

But there is also a bug in the bq27xxx driver, that should cope
with no charger being specified. The following patch should fix
the issue. I currently don't have my N900 with me. Could you
give it a try?

-- Sebastian

--------------------------------------------------

=46rom 47642af85cc9ffc829b5f478e71b1751a98e2659 Mon Sep 17 00:00:00 2001
=46rom: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Date: Thu, 15 Feb 2018 21:28:40 +0100
Subject: [PATCH] power: supply: bq27xxx: support missing supplier device

power_supply_am_i_supplied() can return negative error
codes. In this case we should assume, that no charger
is connected and the battery should be marked as
DISCHARGING instead of NOT_CHARGING.

Reported-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index d99981542a46..7ce60519b1bc 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1670,7 +1670,7 @@ static int bq27xxx_battery_status(struct bq27xxx_devi=
ce_info *di,
 			status =3D POWER_SUPPLY_STATUS_FULL;
 		else if (di->cache.flags & BQ27000_FLAG_CHGS)
 			status =3D POWER_SUPPLY_STATUS_CHARGING;
-		else if (power_supply_am_i_supplied(di->bat))
+		else if (power_supply_am_i_supplied(di->bat) > 0)
 			status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
 			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
--=20
2.15.1

-- Sebastian

--epatvcpwpj5qbrqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqF8I4ACgkQ2O7X88g7
+ppuQA/9FNK0NYqMCOfPrDFw5D5mPib9JRc3oLE2CUElI2iQL+tENWxd4RAwkdrc
sfyUsDoalcQjv7WL72T0E5JwijiPbXDrUvHkRYWs/oog3pIBgwu3dvQjcL9p+q+5
pDrcIvsRDgrLt3M+0zeVb9X0lFQg6UrCHBSCBpFemWHPZjdgabxBr5qwYC2lvx2j
MLYidDdw4JQoigwQl6tgCqEbeh9JLzp/TSIsPpA9Okh1r1TtuHQ5IxznCewztly+
K2vJb9YhpvrQ8iDgSBGS4BXM5tInjeSK3a5jbJgZrsI98heC6EC7D/Soc3XDbqqX
7XRnPU7l8/wVdxlokcfbXCBDzXgTSIb94nL5MXzceelcjgWv4B6J2xLdfVJP7C3R
WX9RvUCTFB/ttoZZSW0eInp6yaE/+t1lNJlPjAyM8JVER8J5MPOFKqo5WWZxlhqr
eFWL5U2IAul5uJhK5SeR8GUuQqwyyIHuVkyeclIigOFoWIcmzw21V2IDw5z3Lc53
XuDRoUM1/q3WrW+K+XwrKjb4h94dx74h7iNf/jgu9Qk5fCJ4+0T1dOcpqpbLxE1Q
cZN+UXfzC1ahyyCk4KqSChdneP5dcBJc9OhTL5p2lr2udjSWqK57SJLlx9NABl+/
XHLpWFbFMlbxgSZjQSLU0wuFa3xBvYwPBRYB2ZFpCnUc3WuIRKc=
=v4Lb
-----END PGP SIGNATURE-----

--epatvcpwpj5qbrqd--
