From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] ASoC: simple-card: Update clocks binding for
 simple-card DAI subnodes
Date: Sat, 19 Sep 2015 11:42:25 -0700
Message-ID: <20150919184225.GR30445@sirena.org.uk>
References: <1441977482-29215-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rE45P3aZNSuYx5ND"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441977482-29215-1-git-send-email-jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--rE45P3aZNSuYx5ND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2015 at 04:18:02PM +0300, Jyri Sarha wrote:

> The updated binding provides a way to set clock-ID and direction
> parameters for DAI drivers set_sysclk() call back.

> I proposed something similar about a year ago, but Mark rejected that
> at the time. This RFC is to start that discussion again. This time
> before I do any code changes.

What's the use case again?  Can we address this by converting the
relevant drivers to the clock API (or improving their clock API
support)?

--rE45P3aZNSuYx5ND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/ayQAAoJECTWi3JdVIfQoPMH/REGqzKm/zlH1tR3M/nS+tpH
IT5NsRbtBx6g8pOfNM6HiYrEqxdpX+/FFm/+3WJ8HjT5OMlClWbCxMSakMVFwM9R
1Qk7jgx7bx+8b85EuGjCL7PqbDam3VKhJhCuS1JEMtYG6pXOSBKUEivGm/u6veAs
HXFSxc6N9Z77IbwLle7NqnOLjrElbVBfz2Aj9WafDD1v4ZpakKr4X6tqaqHxeeIc
iz75Tyg6m6onIkEUsQKdeTK4k9TU0bwVTVFJXscaHJiOxuF7cAb037KEdFWZuN3h
w4mCLkzoyRTt9we7gIAh1fbgEe6OhDeGFm3aEb9c/XgMWQtpsA9poUuwl3F4GGM=
=MyE+
-----END PGP SIGNATURE-----

--rE45P3aZNSuYx5ND--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
