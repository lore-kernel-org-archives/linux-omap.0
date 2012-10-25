From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: make reset a seperate function
Date: Thu, 25 Oct 2012 13:55:16 +0300
Message-ID: <20121025105516.GH21217@arwen.pp.htv.fi>
References: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com>
 <1351160586-12306-3-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351160586-12306-3-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 03:53:06PM +0530, Shubhrajyoti D wrote:
> Implement reset as a seperate function.
> This will enable us to make sure that we don't do the
> calculation again on every transfer.
> Also at probe the reset is not added as the hwmod is doing that
> for us.

since you're touching registers which supposedly only hwmod should
touch, you ought to Cc Benoit to make sure he knows what's you're doing
here. I'm adding him to Cc

> @@ -592,7 +597,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (timeout =3D=3D 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		ret =3D -ETIMEDOUT;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
>  	}
> =20
> @@ -603,7 +609,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
>  			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
>  		ret =3D -EIO;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
>  	}
> =20
> @@ -621,7 +628,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  			return 0;
> =20
>  		ret =3D -EREMOTEIO;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);

eventually we need to try to forcefully trigger these errors above
(nack, overflow, underflow and arbitration lost) and try to make sure if
actually need to reset the controller all the time. I find it really odd
that we're always resetting the IP in every error condition without
actually trying to figure out what's wrong with the driver (if there is
something wrong with the driver, of course).

--=20
balbi

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiRqUAAoJEIaOsuA1yqRE4PoP/1GhrX7pCy1DfE+wXeWfMlp3
19hCchDMXRByw+llz5x+lr773ubU9W9XjS2Oz0fyYuJgIPPK6ZP66ngx+c+2t3Ja
H3oxgu2p8eDhwkE+Oq2drhlSAHfGhXsE7IYzH/LgxeV7PFkEoL3bY2kkvsIb6nA1
1UDOnM1JFgDPbAfGyBFgP3K3t9j+nt9C1y6Px72NH/CMFZkmN2p4iGZeZPjzHRJt
GDG2zR1iVUdgT4FgW0K+d/irOEK9frxre4Au52loUKb+grpJVlMQ7EmMHf+WDbsy
7AJ1L0BnjYXxuniAVwzFXT7dbV4J5qNysacZqrZ4SMWGvkWk7fHnyVYJ2EJYb5+g
89J+7lGk8PuJs+a9LKYjfEOSvgJoP8DVJ7zN7waoSXbLqVZGmOQdU9Y+T+UP85Zy
koWML9X2abHAMNBRJayzzSgf/mud+LOqMaZQpHD33a5Xm02QE6zLYvV8Klo91Bf2
K7dJgFL5fHRLFZtIz1FI99hC8cV9/Db3eXP8wkOyootJ6rR1jzjrQU1u7SNigEqF
btzxPvQ2iAPxdKNZytwnYv8PIMuSzlw+zHTMq6vnh6JiM9naQkd8YTlItd64Aa0j
t6Ma+NoBxTNC6QdJId9g6tfSTlqGMDV6ILyLaIpYdMYXjZDjr2TyqA6KG7+UxEy2
snLkOH1TdJPsGzDtCNRb
=us0/
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
