From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 08:33:28 +0300
Message-ID: <20120913053325.GC6504@arwen.pp.htv.fi>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <874nn2vpv9.fsf@deeprootsystems.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <874nn2vpv9.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2012 at 03:27:22PM -0700, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>=20
> [...]
>=20
> >
> > This is the cleanup only series.
> >  =20
> > Tested on omap4sdp and 3430sdp.
>=20
> It would be extremely helpful if you would describe how this was tested.
> And for me, it would be a source of extreme joy if you described any PM
> testing.
>=20
> I gave this some additional PM testing on 3430/n900, 3530/Overo,
> 3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda.
>=20
> I tested v3.6-rc5 which passed all PM tests and then added this series
> (by merging the i2c-embedded/i2c-next branch.)  PM tests then fail.
>=20
> At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
> off) during idle. =20
>=20
> The easy way to notice this is to see that even when no i2c transactions
> are happening, the runtime PM status for omap_i2c.1 is remains 'active':
>=20
> # cat omap_i2c.*/power/runtime_status=20
> active
> suspended
>=20
> Of course that means that clocks are never gated during idle, and CORE
> will never hit retention.
>=20
> I noticed it because my PM tests detected that the CORE powerdomain was
> not transitioning to retention (or off) during idle.
>=20
> To reproduce, simply enable UART timeouts so CORE will hit retention:
>=20
> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
>=20
> and check the core_pwrm state counters:
>=20
> cat /debug/pm_debug/count
>=20
> wait > 3 seconds for the UART autosuspend timers to kick in.  At this
> point, CORE should be transitioning to retenion in idle (determined by
> noticing that the RET counter for core_pwrdm is increasing.)

I just ran same tests on pandaboard and i2c is suspended actually,
though no power domain transitions to RET. Do we not have retention
while idle on pandaboard ?

See below for a few results... First I ran this script to set everything
up:

#!/bin/sh

echo "mounting proc"
mount -t proc none /proc

echo "mounting sysfs"
mount -t sysfs none /sys

echo "mounting debugfs"
mount -t debugfs none /debug

echo "UART autosuspend delay"
echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms

echo "check omap_i2c.* status"
cat /sys/devices/platform/omap_i2c.*/power/runtime_status

echo "check CORE pm counters"
grep "^core_pwrdm" /debug/pm_debug/count

Then I triggered a few i2c transfers by reading regulator status through
sysfs:

# cat /sys/class/regulator/regulator.*/status
[  507.469299] omap_i2c omap_i2c.1: omap_i2c_runtime_resume
normal
normal
off
off
normal
normal
normal
normal
normal
off
# [  509.010711] omap_i2c omap_i2c.1: omap_i2c_runtime_suspend
cat /sys/devices/platform/omap_i2c.*/power/runtime_status
suspended
suspended
suspended
suspended

notice the prints I've added... I don't know what could go wrong only on
Overo that i2c doesn't suspend. Can you add this debugging patch just
for me to see if, at least, omap_i2c_runtime_suspend is being called ?

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c78431a..ac61664 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1238,6 +1238,8 @@ static int omap_i2c_runtime_suspend(struct device *de=
v)
 	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
 	u16 iv;
=20
+	dev_info(dev, "%s\n", __func__);
+
 	_dev->iestate =3D omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
=20
 	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
@@ -1277,6 +1279,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	if (_dev->iestate)
 		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
=20
+	dev_info(dev, "%s\n", __func__);
+
 	return 0;
 }
 #endif /* CONFIG_PM_RUNTIME */

this is on top of Wolfram's for-next branch, btw. Maybe you should also
add:

CONFIG_I2C_DEBUG_CORE=3Dy
CONFIG_I2C_DEBUG_ALGO=3Dy
CONFIG_I2C_DEBUG_BUS=3Dy

to your .config just in case.

cheers

--=20
balbi

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUXAlAAoJEIaOsuA1yqREkxwQAI+sTgAJHJF2cMRFK8bA1Dtq
PqZK5asMIPBQG0/MnMU6MFR0qF9hU5WIL8BvH/biO5wtT/2QyECAJScuKZPhD/SK
NL22ueWfFnPlof0L49Val38tfai125wb2Gqo39llleVomp4VsncVG1aUilWNaVxu
RJ+TA1J/QQrgzb5RT1rKKU9+D+26Jm273e3psXjRFUElfF7RnBD1kaEZ0sVKerTx
SxHasUSHdI5i8XV/PoGKSsL+tEaN2I3OW/ygsFuN8EZGrfgyRNLqUQY9UhOdhPP9
80i4ioPS7SJjVB1BfsL8NiQyFzHhK2EhuFTP/jW6L1Y+gjIt40BNt+Pp+VpUhPDB
dKCEpxLc7qmxQmoG20/xByl1k//gtKaIehwiX85Fx93LO81zj1DPPOjHOi+lYFo6
XykbfSrWoPTKto+WrG1Re8cLtchA+QbWG0zHohgJi+UP7yOenVzZpuXx5a/3GovY
2hBhFmyMjCE4mKaI5WxwkG/ZXHKyLDNDaHWATqyCIZhjeIFn1GZfa4Aabv48ekSy
qBMzMoB+kq43CGc3BUeG1LmHEgj81/pzo+fIj4x1bIX17EMOTEYGU/2efgPvHetR
IXb/3euFtwxnDKG/EdAGwI/d5zXnPRFyeRaCTjYPeB62XOvvV3x2faT7MizQFOPF
MsT1ypn2aoJzVQ0ds3Cu
=bVgX
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
