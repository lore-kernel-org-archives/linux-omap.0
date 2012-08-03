From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 09/11] drivers: usb: musb: Add device tree support for
 omap musb glue
Date: Fri, 3 Aug 2012 16:34:32 +0300
Message-ID: <20120803133431.GK8269@arwen.pp.htv.fi>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-10-git-send-email-kishon@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4521807135921983775=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1343639400-28725-10-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============4521807135921983775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bX/mw5riLlTkt+Gv"
Content-Disposition: inline


--bX/mw5riLlTkt+Gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 30, 2012 at 02:39:58PM +0530, Kishon Vijay Abraham I wrote:
> Added device tree support for omap musb driver and updated the
> Documentation with device tree binding information.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

This looks good and I think I can take this without any dependencies
again. Correct ?

--=20
balbi

--bX/mw5riLlTkt+Gv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQG9NnAAoJEIaOsuA1yqREZBsP/js9p/cI/Hbjf+ikzVwMf4rJ
ZjXmUQxX+IxSZF3cT0z6Fl9CHXPvfDXoHYcuUq73DcUKAMxUrlpalMGGvbPwhmHb
7+46RqEfRFxD66pb20qEew+hV7cF+Q0j4kZPQs+jWwaGJojhWOAqAdkHGIcVIr6s
Vn9P3Rj92ItIUQW9xZcnoIsiGL+0SaoBhE/LFHujJM9TU4hFkWQAn+twAuJMTL8Q
GAEHeLXjEa5OIuHC8yuE8zDeP1ztBoo9UpLyczMdSiqc4HNmDkTHcaC+cePSR3nu
EkbeIsTzn2mQQwMeL0kj7RizHMlktoWKryGbrh3UeELi3mvJapPTCeQkvldnd54r
/JYiNx85p/QGGj9HOua2BQWdHxmbI2noGr4KhKWnwKwBt8ItYqHCOJqquvESvVgW
tax6OfsLTuKD/dnYM+vHe3Q3EUGFMFADZVGuXfPpQi7jUWCRNWkNBBWhhDpPNDQ9
W9HSmYhE72apEVwwLtYifVmL/RGUHHAzHHJRaX3R9MAH7qqmQdT3/WZz4UpMH1xU
oubMI18FhAMrEp6x/5X0iTXKfotLr08HPB1r0ahTDkLSoNNh1JLJQO2I7uzMNkYI
YHrQfIG0inHMX1pwD42ncz9XBEcyoj88SmYwCiBDsrKZV2S7cg6vhji7euJIHn/u
L8y6uN1wFnqLWom/Ynx2
=gadd
-----END PGP SIGNATURE-----

--bX/mw5riLlTkt+Gv--

--===============4521807135921983775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4521807135921983775==--
