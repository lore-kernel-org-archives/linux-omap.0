From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 07/46] usb: dwc3: gadget: add ep capabilities support
Date: Tue, 4 Aug 2015 11:09:48 -0500
Message-ID: <20150804160948.GJ23659@saruman.tx.rr.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-8-git-send-email-r.baldyga@samsung.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8398830895221987623=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1438351258-31578-8-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: nicolas.ferre@atmel.com, robert.jarzmik@free.fr, m.szyprowski@samsung.com, devel@driverdev.osuosl.org, cernekee@gmail.com, michal.simek@xilinx.com, stern@rowland.harvard.edu, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, leoli@freescale.com, johnyoun@synopsys.com, linux-geode@lists.infradead.org, haojian.zhuang@gmail.com, andrzej.p@samsung.com, linux-omap@vger.kernel.org, petr.cvek@tul.cz, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linuxppc-dev@lists.ozlabs.org, daniel@zonque.org
List-Id: linux-omap@vger.kernel.org

--===============8398830895221987623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Content-Disposition: inline

--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 04:00:19PM +0200, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2feed9e..bd4c3db 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1715,6 +1715,19 @@ static int dwc3_gadget_init_hw_endpoints(struct dw=
c3 *dwc,
>  				return ret;
>  		}
> =20
> +		if (epnum =3D=3D 0 || epnum =3D=3D 1) {
> +			dep->endpoint.caps.type_control =3D true;
> +		} else {
> +			dep->endpoint.caps.type_iso =3D true;
> +			dep->endpoint.caps.type_bulk =3D true;
> +			dep->endpoint.caps.type_int =3D true;
> +		}
> +
> +		if (direction)
> +			dep->endpoint.caps.dir_in =3D true;
> +		else
> +			dep->endpoint.caps.dir_out =3D true;

you can avoid the branch for the direction:

		dep->endpoint.caps.dir_in =3D !!direction;
		dep->endpoint.caps.dir_out =3D !direction;

--=20
balbi

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwOPLAAoJEIaOsuA1yqREeMsQAIPG7g/oNsMI+/wgc4MgLGj4
PRHvg9RnBfZaeh0OoXPyA+YPZPVzl9NMNhv2+Y1fs57Kxs/vGRtDZHzBWLd+8ttd
sOm5xEFxy/Y386OSe1R9B0lSv2bdQhQylXML4kLH5T9qkxMobNVKZa1Ao1OYHCBe
DHCeAa8qZqTyP3cW8sFScXKiIonDJQ0NMnYHC2Pu8YHTCWjltPEpj12Y2kA3uiKZ
dUNMyvYMqhqzmTui3s3Wvyv/2YnA3/KVz8obu2b+tfGUTXMsZ3qtGAcboq9gknd8
GwcRQ+RpVYfu5nuLhsbkD8Osw6qiWguETcsavxLxrrCh+DRfJUkVIQ/rhOdO/+hq
WMLVgRjBxp0NHbq/ftXMAdrQuNTF8b3oEyH6MXIXwVhNc3R453HqbuswaWNl1bzg
cElNL7IytQVF0ksLF2R6nBQrnHnMmdK+j1QpJZiL98ea6Z942a5ykawHhsJ2XL0M
Q5VpSfL98+4Awg9YX0fdao6R7HbyDklMEmkEb2q99wXlf8vOGQQIWN5WTPLFtmfp
+h2+Pw2Q7R+pPn0sg284eqctA0LTiOYPakzKcXMVMRhx3NuRhzzDDVydhROsg40F
kcuKLSFR/ZHGh798vqpU/22cENVimjYHIlHPvJuM53uOP8rslntxg1octhrYRToF
Eyx4MQPzIbkUZ6OlAWgL
=Zeuq
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--

--===============8398830895221987623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============8398830895221987623==--
