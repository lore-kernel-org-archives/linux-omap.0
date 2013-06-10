From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
Date: Mon, 10 Jun 2013 17:49:05 +0100
Message-ID: <20130610164905.GJ1403@sirena.org.uk>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
 <20130610103131.GR31367@sirena.org.uk>
 <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2474091246976937344=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============2474091246976937344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2013 at 11:16:59AM -0500, Nishanth Menon wrote:
> On Mon, Jun 10, 2013 at 5:31 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Wed, May 22, 2013 at 01:18:34PM -0500, Nishanth Menon wrote:

> > So, the biggest problem here has been patch 4 (having to have a hack to
> > deploy this stuff is a bit worrying) plus the general not having a real
> > driver thing.

> Patch #4 in this series was a hack as it was not properly split up and
> organized as a proper DTS series -it was meant as a proof of concept -
> not entirely meant to indicate the remaining 1-3 patches were hacks
> :).

The way it reads is that you're building up to a hack - if what you've
done isn't enabling a sensible solution there might be a problem with
the earlier steps.

> I think you mean http://marc.info/?t=137059249100003&r=1&w=2 series. I
> will dig into it. if it is possible for Tegra and OMAP to use the same
> framework and strategy to deal with these kind of h/w blocks, all the
> more better.

Not just better, if each system doing this sort of thing needs to
reinvent the wheel something is going wrong.

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtgN+AAoJELSic+t+oim98t8QAIbdDPOytS2PBZV+slQte48S
3LpjVuPFHLZTWpS0bW9keYEVXBgyqln6BQIkytwLhcJyUORgksPBEr2XOr+ezW4n
1LOeRmHVE27h9Bb3XO5PBu/Br5VDA2u6Q6wOCCFPNyThsMeIgpMsM+EPzMNz5enW
v1z7CvI8tHElxUT54eV1KqKHzpHzOvb9hqo7pFip9aqYI8jzBMxvnwpMJot3ggL5
lp8f9Tt02lyBypK8OHrH/cASJnhNB2nq9dlUEbpRCIMZAQIu3rmDCRcAjRV9jG4v
hoYoSjJ3NDXMECMNFDyAACS3CjDw4UClZbNY3tWUi1I8VzOBnU1j3J7cP1OMMQxx
tVQbSG/t19uQkIUgX2+TvCzPeDXTb1FUt2wtnoeG9Ujrg3PtNDIg1CTwTRt01s7N
tMVAT5VZqi/iwAFpFY/zSlklD0rC1JmXt1lrySlJU00ifZk64EIPWFR4kk2c5tEF
Ofv7exg5tUGJKASrza66IeFBCdQQrSAS5yZSUVR+goJvlzKjG3pDyVlmPBx8I058
gKh8+jfGZwd+B4JymJR45ZwUDFXDWbOJCqEts/Lcygfb5WcFL9eQloztYKqbX5qb
ZP2WDKNhrPls2RgV6mN+eHk86sKHN8CdjXySljLjLZfmVRSLw8OgrvdjcwrrnBPY
Of0TKf/k8D4j56IGhqaL
=B8U0
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--

--===============2474091246976937344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2474091246976937344==--
