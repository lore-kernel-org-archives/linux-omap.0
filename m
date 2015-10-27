From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] regulator: tps65217: remove tps65217.dtsi file
Date: Tue, 27 Oct 2015 13:21:48 +0100
Message-ID: <20151027122148.GA819@earth>
References: <1445850836-17863-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445850836-17863-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Georg.Soffel-k21M0aUVSxZWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 26, 2015 at 10:13:55AM +0100, Heiko Schocher wrote:
> remove tps65217.dtsi and adapt all boards, which
> used it.
>=20
> Signed-off-by: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
> ---
> Suggested by Mark Brown, see:
> https://lkml.org/lkml/2015/10/21/581
>=20
>  .../devicetree/bindings/regulator/tps65217.txt     | 78 ----------------=
------

why did you delete the binding description?

-- Sebastian

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWL2xYAAoJENju1/PIO/qa9YcQAKlWUHcVSVDf5WsrfJ+qQjsK
mPOPxhoOuMFZToyyXRjZATyjve2qTV5Mb0yxgxgQnHzomMEcqNFE6/wslUfFX9LI
4jqDqBs6w7g46fKiC2ZLXLI66BaJrVR9cZjgFGUo9h20lj+Z1/up0L/rzeKn/tWA
zdFQu2CAQXYbP9WnFoeIx9xAIOSEPNnpxbvF6MgEKSqAC5mIpuJPNNIFztL0wBYJ
u3nFgcL6u239HJQB0kdJkjcY85nxeL+t/2W4jefzoKWRaMbhMTWdMyiJNZ5OSaNM
Vc5XOnoRELMCf4mFK2SWMhPkT3HLzvkCsiJjiEmggmcknTZJLjrstX+UsUK3Uxst
O7hP98K34O7tTFh+mom14BMnQHy9/YW2Rnqnvg1iGVLoDKnf4W1a5gWeuSoZ28eo
VrX77CnZCtOSSfZ/qC7WJmZnhy+85aN8ui86dkIHFErfPxooc5ybH8+kkmm2XPPT
kDHMfyvf9BjmkwyL04Ty5dULgZyebcCP3+m7PhL9uTJyHmqSyXI+Ussynqk7tK0v
wUwVrdJy/kCe1RknpHZIe84qYnXkE20HCMI7Qi9Mf1leXfjWRB+oZ3VoR/w1Wc2R
H+964BC/V8gcco9wwwXeAXVjrDKNr7NYvZLRnFo+5K+k7kTNfKeNJUJzGZegcXjQ
k/4G6IX22vbAMM3MtSAV
=Kf/C
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
