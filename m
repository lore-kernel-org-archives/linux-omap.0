From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] palmas usb driver
Date: Tue, 28 May 2013 20:35:54 +0300
Message-ID: <20130528173554.GD15794@arwen.pp.htv.fi>
References: <1369405896-30246-1-git-send-email-kishon@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5480581547923333433=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1369405896-30246-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
Cc: george.cherian-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============5480581547923333433==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline

--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2013 at 08:01:33PM +0530, Kishon Vijay Abraham I wrote:
> This patch series adds driver for palmas usb which is used to detect
> attach/detach events of usb device and usb host.
>=20
> [PATCH v5 2/3] extcon: Palmas Extcon Driver which was sent previously
> is added in this patch series itself. The revision history is added
> in the patch comments section.
>=20
> A checkpatch warning "WARNING: static const char * array should
> probably be static const char * const"is ignored since it introduces a
> compilation warning.
>=20
> Graeme Gregory (2):
>   drivers: regulator: palmas: add an API to set/clear the switch bit on
>     SMPS10
>   extcon: Palmas Extcon Driver
>=20
> Kishon Vijay Abraham I (1):
>   usb: dwc3: use extcon fwrk to receive connect/disconnect notification


There were some comments to this series, what will happen with it ? Any
new versions coming ?

--=20
balbi

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRpOr6AAoJEIaOsuA1yqREfcoP/iObUJAcLsYrmg7OaERWUh8p
M8lHfHbyXIse62fAu9yIWyga1NTF3+uAdS8mzeEx/krWLm4sZwOWwoO6mvXyK7+O
k2nMeCEWSkIOzyrhAkpgiIFyUYvJvLta3GDlY3XSOl/SWYrGhR87wXiLOqQeA4N4
DL0WQ+/CoCBV8UH5rxPWdS1bTukmcbgWtwkX1NedQlaiaZ0oiVMl9ydJ5duZ0H1A
fphi3yq8l8hlTBVF+CR30H3v7xPosr3uBea4+YQY5tuB0ASX80tLBPlUicq3fjia
rf4bbId86nlFFEllXiBSmnIdN21q7mv0Ncmowu5HdhUar1iX4vWJdvc6EA/w9CtA
7tsSl913YViWk+LQbT15h6Imb7BbtXvodh3zTL6ceG+KHHtbLadGliJ1se3+y+Yl
sBGooYjMfZdGNdgusU7kSCgnA1VH6tp8xi3Y/OxvQA8nLu92QFLctpHalrudntu3
V6SX9m8S53ptvFUDnPQmOThQRWjMFzsBwYFmIDE7QegO4pNmGnGbS2wEVGgnMNUD
+6JBdsQthBL31IfVjjBf2eL+pqhd5Q5bXwjR1Gi6cabWEu0lhMdNi/7CusVBLSg0
oEF+77gDaf9Cs/+InwaNCHIPppZPJB6U+L+9i1KgvM3vMBhGJkCs0TVhfPULEWNk
NPpXGGg7Qt+Bfuqcz2bD
=kfuR
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--

--===============5480581547923333433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5480581547923333433==--
