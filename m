From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Thu, 25 Aug 2016 19:14:30 +0200
Message-ID: <20160825171430.GM2856@katana>
References: <20160525141119.14486-1-rk@ti.com>
 <20160525141119.14486-2-rk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DXTueXWT3Da08pik"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525141119.14486-2-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikumar Kattekola <rk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--DXTueXWT3Da08pik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> The omap i2c controller (at least on dra7x devices)
> doesn't have  start/stop (STT/STP) support for slave mode
> so event  #5 is not implemented in the driver.

I think you can deduce that. If a new {READ|WRITE}_REQUESTED slave event
comes in when you had *_PROCESSED events before, there must have been a
STOP on the bus inbetween.

> +		if (stat & OMAP_I2C_STAT_XRDY) {
> +			i2c_slave_event(omap->slave, I2C_SLAVE_READ_REQUESTED,
> +					&value);
> +			omap_i2c_write_reg(omap, OMAP_I2C_DATA_REG, value);
> +			i2c_slave_event(omap->slave, I2C_SLAVE_READ_PROCESSED,
> +					&value);

This looks fishy. READ_REQUESTED is only sent after the address phase.
Have you read the documentation (Documentation/i2c/slave-interface)?
Please say if it was unclear.

> +	/* As of now, We dont need all interrupts be enabled */
> +	omap->iestate = OMAP_I2C_IE_AAS | OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY;

This looks even more fishy. Are you disabling the master interrupts?
That's a no (unless there are HW constraints). Your driver should be
able to switch between master and slave depending on what happens on the
bus.

For more guidance, here is my talk at ELCE 2015:
https://www.youtube.com/watch?v=JdQ21jlwb58

Regards,

   Wolfram


--DXTueXWT3Da08pik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvyd2AAoJEBQN5MwUoCm28FAQAI6Z/XY7WOE8MP9oZGs9x2pf
vmxNM50Q66Did4j94gj8UrS9tLP++3cd22Wa/NEfn3CNZR5OvImW5VAac+Yt7qXM
R8rPuVzH00uDTO+O0KZh6eB8OqkY4zA7BzV6XthWk7eeIaqrt05pQPzcNbn0Qez2
Dt7rgSZTDcHfldZGp1InkcG+AZ31q75WtEZamFFktxeVQsjRODRQhfdwOy21ey5J
kCDB7seZP41YQngTaI7KRNN5LPSH6TRnMixCJsv7OGMeLaSD8YCgRT+8QS/rySng
tMYGdL5twJlCdOCMfnodLtvCb4HRpn3MaKetTPQ1Krf/Qn+7Kg7GcMRXmeeQvvkM
gnEKKfRg7SlGyNuaSYbRbimEFleXpnBHqRe2o+UBlV1xod29dqECSgB1tU8A2VOh
Or6R7DeBMaxHMz/+RA12s/XvIo4RP0mr03iW8yMxWksVT+ptmhwJCtbmbwYLdx2p
g5KxngegRAVE8nBhZtjAmnvEweQWCMb+62yyPK5mCGgWO+bbvTeOvZ11DxXzz24n
bmlnJuSo3hMP3OlUXedftpGe41p/zPOsHxGhATrGAbGKucEI21L0EFOTpDPqVXD3
w9ROEj+HPfQXd4X1rpjdNje3ZgPQR1OBH2y+TuSzNyUX16RvSYhjAP5jOAKBvvta
7Zsw+HE+zhC9Yp4DLoFk
=ReR6
-----END PGP SIGNATURE-----

--DXTueXWT3Da08pik--
