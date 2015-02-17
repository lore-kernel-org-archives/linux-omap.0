From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 5/5] usb: dwc3: add Fujitsu Specific Glue layer
Date: Tue, 17 Feb 2015 13:26:12 -0600
Message-ID: <20150217192612.GH31167@saruman.tx.rr.com>
References: <1424151697-2084-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <1424151697-2084-6-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WR+jf/RUebEcofwt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424151697-2084-6-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sneeker Yeh <sneeker.yeh@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

--WR+jf/RUebEcofwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 01:41:37PM +0800, Sneeker Yeh wrote:
> This patch adds support for Synopsis DesignWare USB3 IP Core found
> on Fujitsu Socs.
>=20
> Signed-off-by: Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
> ---
>  .../devicetree/bindings/usb/fujitsu-dwc3.txt       |   33 ++++
>  drivers/usb/dwc3/Kconfig                           |   11 ++
>  drivers/usb/dwc3/Makefile                          |    1 +
>  drivers/usb/dwc3/dwc3-mb86s70.c                    |  206 ++++++++++++++=
++++++
>  4 files changed, 251 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/fujitsu-dwc3.txt
>  create mode 100644 drivers/usb/dwc3/dwc3-mb86s70.c

what's the possibility that fujitsu will make another SoC with dwc3 in
it ? I wonder if we should use a slightly more generic name here:

dwc3-fujitsu.c ?

--=20
balbi

--WR+jf/RUebEcofwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU45XUAAoJEIaOsuA1yqRECfoP/10GrYrRzao73S0qOtQx+nVf
pt1otS03H3tudlrFWcuwfcgUFx6WxXeW+SEF6RV2WiIpONYrGiT+lmXbkciLz78f
Hy+i6lS7GXEAbJf/dY0ZSCVxnXSwuaoQ09kQDFWn4D9TE75yH9XR8OdRt2sUeRwL
8YWB8cBpApo7Utzo+lHFm2PTBebvpoCc/QbjZFcP4KMozUHp9Di+yR7I2LJWSm/t
MpbMRfVjiqfkS13srsEfVmQ7/X9qZpG3ISb0UCO/o5h71CumBVse4eibCa3HsKsr
srCkHX40TO97J+DQVwf0pVXzYR2BW8nbZd+FTkmUz2ginvb9sxiTlEtK6opGrsa4
TO5Yc3kEMYtIPeestBSwo1rhtl+0V5XiyiFo7DBBaj/M2QJ51qtQuTaadLArRbmm
b2Kcilmvj1belJRIM7bJWLiq7HMt7CU19H5XTNqzYXhzHifgTRCN8/DxwAS/oJpl
0sBu5J5EVow8kxaYRL9GC6Iv2i2YZHGUN//Hd6mm/5BT5vQYfz6xLQxRIFERx1S6
Z7N//BKFTz1FmY9CVLTcl10KWO/yQqhtb3Fmoh0q/vgLfMDYtV7jkDPPXBfI1x4J
N5VYRB3j3bxy6xuL/Dx774U5nEGdqCBu3iE0O2OFMHIu6GFp+PrEaWaEyB20VtXi
j5cUev1O7H903gSib0FP
=Jf5A
-----END PGP SIGNATURE-----

--WR+jf/RUebEcofwt--
