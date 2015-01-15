From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] ASoC: simple-card: Enable and disable DAI clocks as
 needed
Date: Thu, 15 Jan 2015 11:46:00 +0000
Message-ID: <20150115114600.GW3043@sirena.org.uk>
References: <1421176594-2117-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f4arffV+Mc+T1KhS"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421176594-2117-1-git-send-email-jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--f4arffV+Mc+T1KhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2015 at 09:16:34PM +0200, Jyri Sarha wrote:
> Call clk_prepare_enable() and clk_disable_unprepare() for cpu dai
> clock and codec dai clock in dai statup and shutdown callbacks. This
> to make sure the related clock are enabled when the audio device is
> used.

Applied, thanks.

--f4arffV+Mc+T1KhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt6h4AAoJECTWi3JdVIfQ1JYH/jptlGaARNY7XtKYOR2waMjW
6ADXv7265eMFyGmgQFmsZDrcXc2ILC1Qx3CDv6O9nRRPNC6RMFo70YxSXdpVtq2+
BC6LkAeKFZYVxB239Ze5w2+SdHsAsY2a4TBBzoAvMJSrBNGsFX7e/7MWZnlKmOMg
a/ejQu7TMrjbcTD+yMIrc1P+9iFS+3OknDtdlUsRY8PZiYeuITTYtRr/DB9o1b5u
4ZkY/GowPo1cgdRI0hdmgw+zJJ2BV3evq6kcxKM6rJZQlFOqYXUbh/VH+Xfu2eVn
Ds+ziqTBLcMy+Q3EkJP2L/PwkU54jfrjibQpyenwIolxYkYNKl2fFswphxtniM8=
=C4v/
-----END PGP SIGNATURE-----

--f4arffV+Mc+T1KhS--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
