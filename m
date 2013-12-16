From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 0/2] usb: fix controller-PHY binding for OMAP3 platform
Date: Mon, 16 Dec 2013 15:29:18 -0600
Message-ID: <20131216212918.GH12896@saruman.home>
References: <1387209225-11520-1-git-send-email-kishon@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0758101830684558018=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387209225-11520-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, marek.belisko@gmail.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, hns@goldelico.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0758101830684558018==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline

--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 16, 2013 at 09:23:43PM +0530, Kishon Vijay Abraham I wrote:
> After the platform devices are created using PLATFORM_DEVID_AUTO, the
> device names given in usb_bind_phy (in board file) does not match with
> the actual device name causing the USB PHY library not to return the
> PHY reference when the MUSB controller request for the PHY in the non-dt =
boot
> case.
> So removed creating platform devices using PLATFORM_DEVID_AUTO in omap243=
0.c.
>=20
> Did enumeration testing in omap3 beagle.
>=20
> Changes from v2:
> * Fixed the commit log
>=20
> Changes from v1:
> * refreshed to the latested mainline kernel
> * added musb_put_id from omap2430 remove.

Tony, how do you want to handle this ? You want me to provide you a
branch which we both merge ?

cheers

--=20
balbi

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSr3CuAAoJEIaOsuA1yqREC0YP/R7P/n5V6R0lELGcGUKIRjtL
08SAdLef33pjgvO7Pns2KcFO2xwdkWHG13KpWqhHWzvDjYt9iLGSqUpUGRWFK9UI
4mfez+A7LWGmz/MQ/RtOKwpJhnXVcGZY8Lf3mCxTiAOa9Hs25aVjhgO9nUDqqz8u
avaEA+m99uDf+3JDIb1zFk4Wq7+/+AGg4BAm9RJCgXW2YAv5BFVCsjGcbMq9eN9i
LYw6gbbERFGlpSuGB5/7kGaWXSPDXDMHFFLiYWmPDAmVnqphaGpkkPImRbUzuEY6
USYrs/QHtHpKaisMmpanRGRvUNr4FV7k8+b6T2s4pKTtFzyADoZaDBe6v5GNsa4z
ViNMcONNNxfsS7ow8xCW3g9IWnNw5My4S2tS4Vzi3U+HkBCEGHHpGtrnH1gll/sV
F3JGGvGU8Nymjco6x9g/LB7BxlvjDVhsTrz4ccT6fp8HQdfwsXtuzSy+1hzdvtJK
fphHvd7lB40C0hUwXCGpx/y7qBsHVLoM8zbBZI/OKH3XWAlfOUYAHYTGEO+bQHG+
46NioHARsHAKq8TPysbgnRIc8Uld5F9ggTbvRfczMvjQS7ew7a1bRbYk3dFv/XFB
ZsdG/W/H8dRCeR9nGwyMIpYh6AGhd2Ab41gA5gUb9OJEgJETt6+XH3RN8TxdHVeq
VPpprMtaI0jXom+Woe4m
=qqMW
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--


--===============0758101830684558018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0758101830684558018==--
