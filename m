From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 8/9] wlcore: sdio: get clocks from device tree
Date: Tue, 2 Jul 2013 18:35:26 +0300
Message-ID: <20130702153526.GI7013@arwen.pp.htv.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-9-git-send-email-coelho@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8599259430700509657=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1372776948-24840-9-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
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
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============8599259430700509657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline

--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 02, 2013 at 05:55:47PM +0300, Luciano Coelho wrote:
> @@ -294,6 +316,8 @@ static int wl1271_probe(struct sdio_func *func,
>  	/* Use block mode for transferring over one block size of data */
>  	func->card->quirks |=3D MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
> =20
> +	sdio_set_drvdata(func, glue);

is this move really necessary ?

--=20
balbi

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR0vM+AAoJEIaOsuA1yqREC0QQAJ6PUt5wCGYot1Z9OVllgCWy
4JvzQJKqDKB9TtP7/OpCJFjWiwxRmC/Vg6FxKwpetCOwFJW9sWPbgBjUWuyVKyZj
R3pZM2h6oCiJdOxMdoAlmrNC8IswXksivnjN/PEmUJUYDMKcSVWqo+v/ssk+2gYg
fyfSRgoPef2KbL9xDnRuft30CNRa8QaiaF+tpM0M9QLqlsmB2Mf/QjmXfcf5Gh+O
eMFCGNsfjZKrkMhZZo4QzeZUkA3fM0jGhI6EmmocOdW9I51mFn2Zg9+mrZdREd/e
Hf+3nZZ+KtusXrtzcQfP8mu5kTD+mzET/dvklKp4d2xQdc2zLiDl11lQDqgxs889
e7Oly32DHFMMyKgyOEnnOHt9AExR2mZ7qJs8/2Xf6DHK0wSaK9864n1mlSC6XuDT
izvKmNnk7kNY1ZPCwHa9yt85FPlcH8mq0l1TmH3Z10HS/NpTtOzyZ+PGyPs4c6FC
SjbiB71LRie3gAY43wTETKCFXQ/RGvNE110v6sVHH350orMTg+hGd+mwrtx+ovj7
5qvlWxAZ64QVpiAFDxl7F2L8pDnU80L+D8a6FcGoKU1PPtO2FNmkP+x6fe96Q2zg
4SCewk9i6SblMV0Rk8vSlBh0cVUrsP9rYJBe/QsnizC6bIUi9oqunIlP9zcSheX5
RDl7TCEZjO/o9oIvABby
=h1mL
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--

--===============8599259430700509657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8599259430700509657==--
