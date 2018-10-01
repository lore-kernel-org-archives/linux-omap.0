From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND] twl4030_charger: fix charging current
 out-of-bounds
Date: Mon, 1 Oct 2018 07:55:37 +0200
Message-ID: <20181001075537.6f16ae2b@kemnade.info>
References: <20180917052035.12234-1-andreas@kemnade.info>
        <20180930201642.GC23554@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1EQi4yZsa3QO/o1S=wQrEYx"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930201642.GC23554@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, kishon@ti.com
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/1EQi4yZsa3QO/o1S=wQrEYx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sun, 30 Sep 2018 22:16:42 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2018-09-17 07:20:35, Andreas Kemnade wrote:
> > the charging current uses unsigned int variables, if we step back
> > if the current is still low, we would run into negative which
> > means setting the target to a huge value.
> > Better add checks here. =20
>=20
> Do you expect this to happen in practice? Too high current while
> charging seems bad, right?

I think you need a power supply delivering < 4.75V  and > 4.3 V without load
and still > 4.3 V (so that vbusunplug detection does not trigger) at 1.6A
(the maximal charge current) including loss in cables.
I think that is really rare. It is not the standard charger you find in your
cupboard. Could probably be a lab power supply with a good cable connection.

As a side effect of some other bug (I do none like this):
If some regulators are not enabled, voltage measurement can be wrong. And
then the regulators have to be turned on right in time for the charging to
start.

But I know one way to produce that behavior:
Without my "phy: phy-twl4030-usb: fix denied runtime access"
The following steps are possible to achieve that with the gta04:
1. put your device to suspend without charger connected
2. connect charger which could provide high currents.
   phy runtime will not be resumed, usb voltage measured will be very low
   (I remember something like 1.8V), so the power ramping up will be
   stopped immediately and that step-back will set current it to an
   erroneous value but it will not start charging
3. echo auto >/sys/class/power_supply/twl4030_usb/mode
   then the charging starts with the target current set in the last step.
>=20
> Cc: stable?

Rethinking it, it would be a nice idea, but I think the mentioned=20
"phy: phy-twl4030-usb: fix denied runtime access"
would even be more important to have in stable, since it fixes actual
charging problems. Well, if your device does not boot because it is empty
or if there is sometimes a kernel panic is no substancial difference to me.

Regards,
Andreas

--Sig_/1EQi4yZsa3QO/o1S=wQrEYx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluxttkACgkQfb1qx03i
kyQB9hAAx960ckXwHETStQVEcMvvDamrEfQYvcZddShX+Kh06PmqiepxhJ0Fy6gy
JfCc4SlCd89yiP6A75SB8A5XoegwEEKmYlT+FEgMducNlhqS3Bh6H3gvpEVPc0bV
WfhnX1mBzIiT4VIVusvDPQepmNc3bMu/BhZ0I5yb/SXAR4YlWwWYH+kjsj1s/SAH
FxAl+mjbRwSbK5b3zyx+DQXcbtSI0iHvqt41pBVNEYab5uOK7hO+vFAkzsYXbbzX
jSYKxl+V9mX8g+Yod/ibQ/uxXLr87Yg7tE4z2XWuJqmN+M0kR9yrxFEEDrw0kp5x
/C/X0Ake+HKtaO3IAfqFEP6vdjoIllYIf9+FD7E4f+KUQv/KcOnebEuwK8Xubgmh
1WaiMbq+HHXgikVyfkaA/XFgoqTFgUCYrMi1WcAZOaG7u5DfXOlWvhispqzl+H1x
ATmpV6QC9S2RT7JFegraBAeeLHBqb8ZUu6lhH6V4HdHrUUk4LNbASgOe+h7Yjakq
tQWGQ/cMwJQqAtQ9nsptTPw/ZlM2v3Nm5kmumWQDsAEzyE9Ws3ODEp5ZE0DBAEIO
CjZpzwgXCWCFxiw4qJdTLdHelvKA79DyvbZqNEWYkbz4XqawNFcKfhiAe0cPSySV
VDF/w9+TaM0nS+Cbjtyyj0tDW5oTaN8YbszHFyuAq/dqYdad4Bc=
=FZM9
-----END PGP SIGNATURE-----

--Sig_/1EQi4yZsa3QO/o1S=wQrEYx--
