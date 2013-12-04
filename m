From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP2+: USB Host bug fixes for 3.13 rc
Date: Wed, 4 Dec 2013 12:00:34 +0200
Message-ID: <529EFD42.9070507@ti.com>
References: <1386080748-17005-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6764644024946039439=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386080748-17005-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: michael@amarulasolutions.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, David.Laight@ACULAB.COM, sr@denx.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6764644024946039439==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OlG45Btx7612tT4vMH3sXPukUoLiuM8Sg"

--OlG45Btx7612tT4vMH3sXPukUoLiuM8Sg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-03 16:25, Roger Quadros wrote:
> Hi,
>=20
> This is a follow up solution to the original series in [1]
>=20
> The first patch fixes the OMAP4 Panda USB detection problems on 3.13-rc=
1
> with u-boot v2013.10.
>=20
> The remaining 2 patches are required if SOFTRESET needs to be done for =
the
> USB Host module on OMAP3 platforms.
>=20
> Patch 2 fixes the hwmod RESET logic to prevent multiple SOFTRESETs
> being issued to the modules. This multiple SOFTRESET was causing proble=
ms
> with OMAP3 USB Host module. On Beagleboard C4 this is seen as failure t=
o
> mount NFS root over external USB to Ethernet device.
>=20
> This might be the reason why HWMOD_INIT_NO_RESET was used for the OMAP
> USB host module in OMAP3 hwmod data and just carried forward in OMAP4
> and OMAP5 hwmod data as well.
>=20
> cheers,
> -roger

Tested on Panda and Beagle xM. Works fine for me.

 Tomi



--OlG45Btx7612tT4vMH3sXPukUoLiuM8Sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSnv1CAAoJEPo9qoy8lh71BcAP/AiVK9B3kkLA4l6o4jOpbq5+
HjZkW3vQMd6PgS1fdPy3Y3OLPF4uROVMXAxiEP0MTmeJz5b/WcxpGsqboO7qZsT3
/qYa4xceNyYsj0sOpc5r5wyB714GSgHI9DSrqAYRXdJmA9NMriipfoHo6oHMXsm7
7dC72AwWc9wcwnmzBGlwoXI+7llE9+Cj/jRoy3TI0ZLobivfKKl/EmrCVplAjAfz
LAdfHtQ5SVqwY3LOk2roUuAzlx8B//qgw6aBb7bo4XbqQOweNV7sk7DD9pBimESC
dF58KQsXgJIE0HAGSVOYIZ2yyEQo5Hex6y8BiiVdlvlVanRpTm1yASCtQMN0pRr/
+shNSLN5/8yOaZtn02KT3XyDrzc5y2KONB4d2pLgGHuJm0O+l1Z6JKwyk6W8rzIF
iVL/h0sCz8IVZblFl3Lg52hZWbp2BX2aFE6lIv/Y9ra1VvG5gDpFDWFm2MzGONqk
GFt9ZOYDAptg61O+pU4tpa9gZHgQEEFnn01phTHD+D2OqzTgmWi0EaZlVPWm0wIe
uydd0+RTGUgYhdjsUK5YL5MW9K/LwioeZiVS5c6G/cdcKWUEh7IO6RM3ohUhaSZ3
RXn6NmXBi2o+pgIt7UnnUv/QLN23qEB6WbzyTjFqeOJ3uwFJ/j49JkNzxMoZAXUd
RLgNB8rzgYAZVzPxAZXg
=Q/KQ
-----END PGP SIGNATURE-----

--OlG45Btx7612tT4vMH3sXPukUoLiuM8Sg--


--===============6764644024946039439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6764644024946039439==--
