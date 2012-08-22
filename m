From: Felipe Balbi <balbi@ti.com>
Subject: Re: debug needed: twl4030 RTC wakeups: repeated attempts fail on
 Beagle
Date: Wed, 22 Aug 2012 21:42:14 +0300
Message-ID: <20120822184211.GA29041@arwen.pp.htv.fi>
References: <87d32yd1l4.fsf@ti.com>
 <CANQgH-a9uiaUnR+G2Y_zzvvS3+Yh-O3b-afkZDsNkQFBWNN+9g@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:39893 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753413Ab2HVSqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 14:46:15 -0400
Received: by lahc1 with SMTP id c1so812548lah.26
        for <linux-omap@vger.kernel.org>; Wed, 22 Aug 2012 11:46:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANQgH-a9uiaUnR+G2Y_zzvvS3+Yh-O3b-afkZDsNkQFBWNN+9g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Russ Dill <russ.dill@gmail.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 22, 2012 at 08:36:31PM +0530, Datta, Shubhrajyoti wrote:
> > The real mystery is why this happens on Beagle and Beagle-xM, but none
> > of the other OMAP3 boards (at least the ones I have.)
>=20
> Looks like some  race/ timing issue.
> However I am not sure what is a good way to synchronise the i2c
> requests from a client from an isr and
> the device disable / runtime resumed.
>=20
> However on merging the clean up series
>=20
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg73870.html
>=20
> Didn't see the above mentioned issue.
>=20
> but there were some error's like timeout.
>=20
> This may be because the controller was not fully enabled.
>=20
> SYSC in case of I2C not only reflects the reset status from sysc
> reset( register is reset)
> but also controller enable ( controller reset ).
>=20
> On checking the reset after controller didnt see the time out issue.
>=20
> patch below.
>=20
>=20
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 9aefd36..b35afa4 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1254,6 +1254,7 @@ static int omap_i2c_runtime_resume(struct device *d=
ev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
> +	unsigned long timeout =3D 10000;
>=20
>  	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>  		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
> @@ -1266,6 +1267,15 @@ static int omap_i2c_runtime_resume(struct device *=
dev)
>  		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>  	}
>=20
> +	while (!(omap_i2c_read_reg(_dev, OMAP_I2C_SYSS_REG) &
> +			SYSS_RESETDONE_MASK)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_warn(dev, "timeout waiting for controller reset\n");
> +				return -ETIMEDOUT;
> +		}
> +		msleep(1);
> +	}
> +
>  	/*
>  	 * Don't write to this register if the IE state is 0 as it can
>  	 * cause deadlock.

That's weird. i2c has SYSS_HAS_RESET_STATUS set, so hwmod framework
should be checking that for us. And, in fact, SYSS_HAS_RESET_STATUS is
set on all *data.c files.

When you wrote that patch, did you check that reset hasn't completed
yet ? I mean, was reset still asserted at that time ? If instead of your
patch, you just wait longer for reset to complete, will it work ?

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 6ca8e51..7a39c72 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -156,7 +156,7 @@
 #include "pm.h"
=20
 /* Maximum microseconds to wait for OMAP module to softreset */
-#define MAX_MODULE_SOFTRESET_WAIT	10000
+#define MAX_MODULE_SOFTRESET_WAIT	50000
=20
 /* Name of the OMAP hwmod for the MPU */
 #define MPU_INITIATOR_NAME		"mpu"


If it does, then reset takes longer to complete on those particular
boards and it would be nice to know why, but one step at a time :-)

--=20
balbi

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNSgDAAoJEIaOsuA1yqREv+oP+gPHxTFzcqMaXfsElBEpuFuH
vBcogWKIoL/rVZxKpk9IrzhOa/CXr/dZqvkwD/1hkxd0+lAX5W5/brQ+O3gfSj9S
yoa2O9pgetO/e0/puW6a93KjuMcUDb07K+z0Z6F/rzaUmuyMYgDyYSD8kZRbkhtr
2nUhXNVuyFR2a69GR2wao+9yDfUR9zjw0vlhumj+ZWz3xskjLwtuulD04m7BzzyW
gpcvJh2R0G66fVrb5Na7s1weCS2GN9YU7WHT+kVCFSZ8SKaArPwPsTAbWMaEN6KX
4c6pdjhfH46mQAl2NHMNg56zBkbg+umBnu4hJAf+4FXYsbvhF9vRr1kNUWL4f9z/
8PRshHYsOqOs+dbbAHzB/OT3igJ3UjEJ3SpUvWOScJXaBtOiI8/NruWouI2i43wx
HSy27HPNjDbSlNTy/ewlaZDiD0rTPZIDbFX5gGjg9eHjnMmrvN+Z5sOypiR8ck17
nPym1Fhd8TzYOqkMhAYWaDTgo0ZrfV7aRYT6TEpQ4XZdccgl5ZdBHuo+LJN2H0hV
M62LVmWRJRL6pd3dJea8D8nN6iFSCs8rkvSOeZdmg+0bB1dXGhtEYbxhJQhmOo4E
Q6fs3+8a0yYMzws0lulHgJkSIy08s4iHEkPqSwoZtcDcChPucZrEWDdCsCsFLG5o
xYA2rMrZV26KsDpQvj9N
=xD05
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
