From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 2/7] usb: dwc3-omap: use of_platform API to create
 dwc3 core pdev
Date: Thu, 25 Oct 2012 17:19:44 +0300
Message-ID: <20121025141944.GF16564@arwen.pp.htv.fi>
References: <1350307680-24938-1-git-send-email-kishon@ti.com>
 <1350307680-24938-3-git-send-email-kishon@ti.com>
 <508946FC.7090704@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4921655480669072335=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <508946FC.7090704-l0cyMroinI0@public.gmane.org>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============4921655480669072335==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline

--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 04:04:44PM +0200, Benoit Cousson wrote:
> On 10/15/2012 03:27 PM, Kishon Vijay Abraham I wrote:
> > Used of_platform_populate() to populate dwc3 core platform_device
> > from device tree data. Since now the allocation of unique device id is
> > handled by of_*, removed the call to dwc3_get_device_id.
>=20
> Just for my understanding: How are these devices organized exactly?
>=20
> Do we have : omap_wrapper -> dwc3-omap -> dwc3-core ?

omap_wrapper =3D=3D dwc3-omap, so it becomes:

dwc3-omap -> dwc3-core

--=20
balbi

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiUqAAAoJEIaOsuA1yqRE/kcP/07hQMsC45EW6YHymHu5x4cD
wmUq5XivfkYzu9vM2TsnNBEjn8AzHqXQgXMorvT6XEDQukyE6p9k/maGtTdG/SxH
dKbIpiZLnMUJ1Zzbr0TB6ye2l7y1HJuvnd0/ieojsjOEHfKgNTauxes+4Pi4DWjm
OrIbAY9fUOLVHk3kR0+MAcTTIuZ4tqm3CmInAHHG3h8NBx2Um8rbHr8E4/KK8SqV
pkP+leF1V0HrpMtFGejmuFsBDlax/4xWEcbiShScwBbuplaMw7JFSFBLmwxbNv/e
rOWmOVSu7LQRwvLIfPV4gbvveDY3OLZL5XXjyKJ+LkzYPcw092y9DKaDD4CDSWLN
Az+t3Y7yW2/wq0uw22ELAbEZXRGTt3+TDi3TH/xECIKH3uzBNhpzg76SDMt1RFrp
ctdBGiYp0fa62ti+oWtW93psYBR9a6P/hcoRG5kD3dc6X2nSo/JDY+upV2fFblPu
cGO626GH6ApR9qi0KkbSKqx+N4L7CHjyw/SrExBcBnwLsUt35Ae2OnkWZmP64JhJ
mEitOAdOBJGluGWv9WDoSwCaC7ujYiGSZZedgrrZrCbLKKaD0H7ueLpbJfQg3g3q
/VSkDrhcnnkf3Rzc+wf6bf5GRggowaRIRlH3jp1D8jZ4u6IR7yep0X0gJVNwumpl
yOQ3t7pJy+0qH6E0IrSO
=EIey
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--

--===============4921655480669072335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4921655480669072335==--
