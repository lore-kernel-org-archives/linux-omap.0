From: Felipe Balbi <balbi@ti.com>
Subject: Re: debug needed: twl4030 RTC wakeups: repeated attempts fail on
 Beagle
Date: Thu, 23 Aug 2012 14:33:19 +0300
Message-ID: <20120823113317.GK30710@arwen.pp.htv.fi>
References: <87d32yd1l4.fsf@ti.com>
 <CANQgH-a9uiaUnR+G2Y_zzvvS3+Yh-O3b-afkZDsNkQFBWNN+9g@mail.gmail.com>
 <20120822184211.GA29041@arwen.pp.htv.fi>
 <50361245.1040504@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="08ATZu8fEq0x2T3M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:51046 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755448Ab2HWLhV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 07:37:21 -0400
Received: by lbol12 with SMTP id l12so434961lbo.30
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 04:37:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50361245.1040504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: balbi@ti.com, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Russ Dill <russ.dill@gmail.com>


--08ATZu8fEq0x2T3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 04:51:41PM +0530, Shubhrajyoti wrote:
> On Thursday 23 August 2012 12:12 AM, Felipe Balbi wrote:
> >> >  	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
> >> >  		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
> >> > @@ -1266,6 +1267,15 @@ static int omap_i2c_runtime_resume(struct dev=
ice *dev)
> >> >  		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> >> >  	}
> >> >=20
> >> > +	while (!(omap_i2c_read_reg(_dev, OMAP_I2C_SYSS_REG) &
> >> > +			SYSS_RESETDONE_MASK)) {
> >> > +		if (time_after(jiffies, timeout)) {
> >> > +			dev_warn(dev, "timeout waiting for controller reset\n");
> >> > +				return -ETIMEDOUT;
> >> > +		}
> >> > +		msleep(1);
> >> > +	}
> >> > +
> >> >  	/*
> >> >  	 * Don't write to this register if the IE state is 0 as it can
> >> >  	 * cause deadlock.
> > That's weird. i2c has SYSS_HAS_RESET_STATUS set, so hwmod framework
> > should be checking that for us. And, in fact, SYSS_HAS_RESET_STATUS is
> > set on all *data.c files.
> Felipe just like writing to sysc reset.
>=20
> writing
>=20
> omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
>=20
> [...]
>=20
> omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>=20
> is also a reset() and the hwmod is not aware of that.
>=20
> 1.Hardware reset: A system bus reset (PIRSTNA =3D 0).
>  A device reset causes the system bus reset.
>=20
> 2. Software reset: A software reset by setting the
> 	SRST bit in the I2C_SYSC register. This bit has exactly the same
> 	action on the module logic as the system bus reset.=20
>=20
> 3.  Partial reset or controller reset. The I2C_EN bit in the I2C_CON
> 	register can also reset a part of the I^2 C module. When
> 	the system bus reset is removed (PIRSTNA  =3D 1), I2C_EN =3D 0 keeps the
> 	functional part of I^2 C module in reset state and all
> 	configuration registers can be accessed.
>=20
>=20
> Since the case 3 is true in my case I am checking and hwmod is not aware
> of this.
>=20
> This read-only bit indicates the state of the reset in case of hardware
> reset, global software reset (I2C_SYSC.SRST) or partial software reset
> (I2C_CON.I2C_EN).
>=20
> I am checking for case 3.

aha, ok. Very nice finding :-) I wasn't aware of that. Maybe that's all
we need then ?? But why only on a few boards ? probably some
timing-related behavior, who knows ;-)

--=20
balbi

--08ATZu8fEq0x2T3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNhT9AAoJEIaOsuA1yqRE6HsP+wR5yxvqRxfScjjEGqT2rQkt
SdpLL8Dtc0+WtAhbJB5HXmoWiLgSdV57ACllrt3+KUocN+i82VVD+UoKPINulxvx
dL6zCh97GKk0Efe4m6sU50Y7RQlRhA72a9AMAvJ4ZqIeCrnj2jbYf5DNsSfZOMsl
QK86MagWAdx6IMBk2aCOdCwMPI1gFrocfHSfKLvtaXMhxaaKuGH0HnZ0IpMZckmf
nqhM9cSxciZp1qT0j79QL7fks44ckE016D0M3zfNXt7x5tAdPSWkqIyUj3xJ8kD0
EK3ix5LJfOtUMeJkhMwWFkVG5oJ0rOt3RekWODo0UtcX94oftu/wp2cDdc0RKcf3
Se0dDic0tzgZtrX4CDVxf0k2H8Uiy2LZcd9yUDYxFRMZqHAgINci38PyQOyFLpCB
f98i2y/tP7XlYJDQh9bqOdYqCMl237mWNbw0Z41NjtFJxeiJTqk7OuUw+DK4igoU
VZd7rjzXKghDTdtlBg1IpaS7x/T9XdRTiJ/VE4VaP2deMrBD0Zx+UPtl7jycj1DB
Ysym4WvGQsSBQVC7eMjFFu9OB8bRB+r5yAfPBhga7dTt19bUsiO4myVcwibdkzxc
qIbAgARV3AtZqlYrh4XTd9jd9anrAD9W8yjs5YQWfK5fVE6X9j1Kn880NVFk5Rv3
Z14sjLZvSHBUKCXMpmEl
=s3dB
-----END PGP SIGNATURE-----

--08ATZu8fEq0x2T3M--
