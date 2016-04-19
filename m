From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 3/7] ASoC: hdmi-codec: Add hdmi-codec for external
 HDMI-encoders
Date: Tue, 19 Apr 2016 11:54:29 +0100
Message-ID: <20160419105429.GS3217@sirena.org.uk>
References: <cover.1459431292.git.jsarha@ti.com>
 <636486b25db48fa13ae640516cdebe7bcfea0d23.1459431292.git.jsarha@ti.com>
 <57160B9F.9090907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WkmTq0Xj5pNQBic9"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57160B9F.9090907-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--WkmTq0Xj5pNQBic9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 01:42:39PM +0300, Jyri Sarha wrote:

> There is now two acks (and a tested-by?) to this patch and reviewed-by
> to an earlier version (with very small change this this one). I think it
> would make sense to apply this one now, even if there are no users to
> the driver just yet. Then all the video side users could (at least in
> theory) implement the HW specific hdmi audio support with video side
> patches only.

> What do you think?

I applied it yesterday.

--WkmTq0Xj5pNQBic9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFg5jAAoJECTWi3JdVIfQg9IH/jEA7d1UFAO/vxk0CzmRR541
recG/2lb7Hm8rLTQE7YsZGAD4NqiY+3pCJqJ28t16sh3583ZhxXgj1/9dt8sREqP
mFfxOV/Lp1t9MUm2UFbryW9zpAGr7vxwwuifQnpL2isXFI68hOwEPyM6sbg4wjDv
p9IRNMlY4SGLlTSOl8bob5AsqVb3oQ+OIvPLlv3+A7QHHOml63IXeR4TwCOAES14
Fg/DLafvzusqdJ3CfJNh+eBrQ66g8GUSTv4KqmwQdb0hBqOal4malqbguU5dCkXH
TSEW1UYjwGE1V9tKOv19wFaTe0iKsvsAeBghNJ3NFt9aHxBic8+RTwO4NAS6HSY=
=/Fe+
-----END PGP SIGNATURE-----

--WkmTq0Xj5pNQBic9--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
