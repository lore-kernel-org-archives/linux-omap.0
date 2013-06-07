From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Let users disable "Probe an I2C bus for certain
 devices"
Date: Fri, 7 Jun 2013 23:28:17 +0200
Message-ID: <20130607212817.GA3047@katana>
References: <1370367222-19353-1-git-send-email-grygorii.strashko@ti.com>
 <20130604174900.GA2992@katana>
 <51AF63C7.9070007@ti.com>
 <20130607090623.GC3428@katana>
 <51B1B19E.1050200@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51B1B19E.1050200-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> That sounds good to me - I can prepare patch for i2c-omap.c.
> But, there is still an open question regarding *i2c-gpio.c* which,
> actually, a source of biggest part of delay.

Why should the DEPRECATED flag not work with i2c-gpio?


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRslBwAAoJEBQN5MwUoCm2Jr8QAKphuWx9RwNuq8XpwRt7l2Am
YjV6Ut6u2ktei5eH6W7lL9VQF3iqj7t2iPwHnxxUzwzfKXtha3jwlHaYBddwCSP4
9gNnx+ROz34BkuagJRl+WYNHoAPh54Ie07FSUbcy+E5bLLk7ADDlUpOzkGj1HnrK
YvbsWgsnuR9dwo0qx2PFi6bchsW7P7AOCiNZO/Fx0rGLjbIV3rAGxkuqAGfDCzh+
SOuBtYT/vIFyC+IKa92P7USQwVD1leHWe5q5mqln+NTNHtSLhDmJWOoe7MiHBPOw
Zd0h/csYJ3s0gd7F1y9qeZ5epujpfFvjuxA00rRB/us/I1SiRqOPM339o3c/T3Bm
0ycgzqBqq1DBVOBGm6w6EwT7qPHF1eFMLiiaiKTAGM9eoAgkbyiPHrfRoo/2B0HI
oqtEgsrHqZnb6Xf1syJQ3vmVXfzfoVq4prY991riK9zDYo41X3mppXr2mLTb8iRD
CgH9Ln6SAjFOzULudCOedtovuvOCRsY77LWRtg12MFbthslcmjCryMBQ8M4sQ5oQ
PXtVfAae2bZuuXgu+JlDiNRhoaNuhVOBEfcBdMBRMCWbz4UrX6tSmrhrDncRN+SZ
55FIvafzKew2OqelbeA9kFvzf24roCQ9cYGp5LaifwPRr7QIdlKbj9XuyEirbZAz
7uAhsgpz0BqIBifbI204
=LTy1
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
