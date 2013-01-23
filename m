From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: OMAP: devices: create device for usb part of
 control module
Date: Wed, 23 Jan 2013 13:24:22 +0200
Message-ID: <20130123112422.GF29258@arwen.pp.htv.fi>
References: <1358777308-2409-1-git-send-email-kishon@ti.com>
 <1358777308-2409-3-git-send-email-kishon@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0875166743167326036=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1358777308-2409-3-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============0875166743167326036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline

--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 21, 2013 at 07:38:26PM +0530, Kishon Vijay Abraham I wrote:
> A seperate driver has been added to handle the usb part of control
> module. A device for the above driver is created here, using the register
> address information to be used by the driver for powering on the PHY and
> for writing to the mailbox.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

Tony ? Without this we won't have the control module driver.

--=20
balbi

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ/8hmAAoJEIaOsuA1yqREIvYP/j2I79PlB/krUKdUObwk1GJC
bZ/iM9t2xPxdjNs5DtKBow0FyEsUDIzOUVs2XsKRInuEPHgGhoJg5tdsPbnoYprQ
bX9eZshPgW39GXDQGO2KvJDFLoMI2O3O0Ud5sFmIBvFc/EwuF0JttSCYl7KvlSc8
Ul1JjptDy2BYwqdZ09ppfueKkwaHxWZX952V/k7pkV7Nsd4w8JiV7vNiXoxmmbyt
Y6arAnhZADS+qjPnRkmB8yCWPN0hmRu8eJaK1fh25fmEXiFiYvZ0J1rgq8rbfBoC
IqDbUP0Gs85XtKrwLBZlBvSt5wN0EXjPLsgZOI/gaBnpteqj+fZWqlpt0Q/JHNNN
W883S49/SjAQxQjOnXuCLr8qm5S3IaDDtNgtbB+sWxGcdd4tDGIYSvM8r9JjQ+xk
cdTtp/HQdx2rnJrgISUvW/Vsvv5P0+zV5MZYTqjzo71NGwXH+wbxFpMM+dYG6Yty
liKQjMcXrh5D5h/Of+o2pM5KnRD4CjANomVu4dq+09ZUKBlotIlbPWgg7Uabf1+j
/fPPbGOlHPozn4W3UKsf4yI9upnX84Cf+PQvCe1ouVttBWu5ynE9aTzaXD1hXIoS
d5pz3IjUe4A2qnOW4GJwFkMXXjTLmreftV+Aa85gldsIrMdDhJEv21Kdv6dDURaX
HH1B5evD0ymZkiv3Ndvw
=sCR7
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--

--===============0875166743167326036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0875166743167326036==--
