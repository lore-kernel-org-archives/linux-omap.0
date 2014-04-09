From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2] i2c: omap: Disable default probing of i2c devices for
 omap i2c.
Date: Wed, 9 Apr 2014 14:37:02 +0200
Message-ID: <20140409123702.GA8157@katana>
References: <1397039808-28594-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397039808-28594-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2014 at 04:06:48PM +0530, Sourav Poddar wrote:
> I2c core supports defualt probing functionality for devices not registered through
> dt/board files. If there are any client driver registered, i2c core will try to
> check if there is any device present corresponding to the address supplied by
> the client driver. If the device is actually present and not registered, core
> will register it, else the device default probe will fail and we get a omap i2c controller
> specific timeout messages.
> For example, Using multi_v7_config on omap5-uevm, CONFIG_SENSORS_LM90 and CONFIG_ICS932S401
> is the driver which is enabled and gets registered. I2c core tries to find a valid
> corresponding device on each of the address supplied by registered driver,
> but could not find anyone. Hence, keep dumping the controller timeout speciic message.

This is exactly why I2C_CLASS_DEPRECATED was implemented. So, users
which are using classes can migrate away. But this needs time. Given
that I2C_CLASS_DEPRECATED is new in 3.15, I'd think setting classes to 0
(thus totally disabling them) should not be before 3.17. You don't need
to resend, I'll do it for all drivers I added this new class to when I
feel it is safe to do.

Thanks,

   Wolfram


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTRT7uAAoJEBQN5MwUoCm29ZAQALKOwZpWgt0+hqp8H+owyp8N
3lw4zNnkBG6qpdn8IAVNBhp0+G9v2y1KOf2D9V8wHM6amZleIyfLLHTC4+7V4//a
MBpIX5kheUvsWa1WxqRHCrelQQgqMZdpaw6eloc/tnd+cfIjCqs0ipzci37UcMXy
NKKSjfhahPhm6KSI8a3e2Dh+aSXjAC5fKAj+f3l9Z2Doon+iqAkd14IZYOciGuzt
AB3kVEh2+9RvzWKi+fQVLJJfA0LiBsJh1j0DCdxnsXeU9EbXeGneW1J0EuqeqKs/
XcjuAv1DR45uCfNhxZcylyqMtcmg1+gX32ak6yS3s6pic0Zynt4OTSvDc4EgXPcM
GUX1rXLgPwADgxSWiQg58EaYpT7j9dU1ffRIf7Ju8OixHxivo1ipjFvheUP/lp2k
jcvuL/BAsNAGl3Zdio8ybipP1AQOaypOS1qWxgPNO5gh+2KoCYt6WCyWF4G+Wahm
iKIz9DQ4hE+0vUfnfN8+plJDnX6DSZKTVcl3EdxUd17dX7L328mnMsSpi7gV2X0q
U4fvpCKRdbTlYVQt7ML7K+52w1t0amleEI6MaJm9y5EeutrwYCHfa2T8j8gpoyt5
//Qs8O6yebNGjztj4jSSjBMiBRaXvrIi+JHuxKledNifcoTszGq2XfOPXtoJwY6z
HEJqoIZXNesqPgBlneFA
=2vGR
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
