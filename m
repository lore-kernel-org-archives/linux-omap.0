From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing MODULE_ALIAS()
Date: Wed, 15 Oct 2014 15:20:19 +0300
Message-ID: <543E6683.5040103@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com> <1413311335-25083-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tUhCXevdn4QJxJhl5mRNJSx7QbvnavL4L"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33887 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbaJOMUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 08:20:46 -0400
In-Reply-To: <1413311335-25083-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--tUhCXevdn4QJxJhl5mRNJSx7QbvnavL4L
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/10/14 21:28, Felipe Balbi wrote:
> without MODULE_ALIAS(), omapfb won't get loaded
> automatically.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/v=
ideo/fbdev/omap2/omapfb/omapfb-main.c
> index 9cbf1ce..b4b9244 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> @@ -2651,6 +2651,7 @@ module_param_named(mirror, def_mirror, bool, 0);
> =20
>  module_platform_driver(omapfb_driver);
> =20
> +MODULE_ALIAS("platform:omapfb");
>  MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
>  MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
>  MODULE_LICENSE("GPL v2");
>=20

Thanks, I've queued this.

Unfortunately it's somewhat based on luck if the automatic loading works
correctly. We can't add more displays after omapfb has been probed, so
all the panel and encoder drivers have to be loaded before omapfb.

We have two workarounds there, which help the situation a bit. First is
that if omapfb finds no displays, it returns EPROBE_DEFER. The second is
that if there are displays, but no main display (display0), then omapfb
returns EPROBE_DEFER.

So even with these workarounds it is possible that drivers for secondary
displays are loaded after omapfb, causing them to be ignored.

 Tomi



--tUhCXevdn4QJxJhl5mRNJSx7QbvnavL4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPmaDAAoJEPo9qoy8lh71PqgQAKNvz7YkITi4vduo+dtIKV45
unislLF7FV0Xc1K/gE1quq3e295C2e2sPen3ZibR/M+QJB5PoNdl65G7CCnL+T6p
kmLxYFdiXHZHju+Gfplq/8JTzCSMkU1/N0v2Q28dR8WS6uvONiBW8TADR1pa7ArB
QCHDLGnLEM+ZA8H0FMarUbDCDvNJJGhlhEr7dZrWx5pb+qh0WedkrRPToPZxKLwL
H337zBtt7zlsr9bDUcX56CY2oetr5AfJLWMx3Lxtsrd85Nggtca47nZHcU8FTiL4
lIRRSJTYucWjUYUQ+TbpewHNC+d0W2AXjlR77Bc5gdd1p1/JwzlVGQixCMQ7P40o
If73Gq2CQfzreXhPT7Z3bqhBH5l/IvCMihh9Vp9oBnLnWAURbV4haduk+yzVDElB
aneMt1oifym7BeicfzMhdbTKrjlWyeRZldQWXl5f9QMUNDmuCrefqw31l/lvapUE
vRB7ZA0f3UtHGfw1KOFKVGzJLAsmz0/7J9R7DA4IkAJDuqbk5h8R5IzbQxH1DWoB
+oZQwx4H7jqvOWwJWBOJrJu8VQ3BmPq628aIuTdt3DUpsh+NLOMr/u6Hci4BEFAG
/TPolP1GmpzlyUo3KbZzrPFRnj1Ga0bYqajUWB9cUcvDTZ482ejgsD0xPPIJTMeL
O0NVREBVEzfy1MEzWJK6
=69at
-----END PGP SIGNATURE-----

--tUhCXevdn4QJxJhl5mRNJSx7QbvnavL4L--
