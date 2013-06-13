From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH 1/4] arm: omap: Add phy binding info for musb in plat
 data
Date: Thu, 13 Jun 2013 16:05:58 +0300
Message-ID: <51B9C3B6.1080707@ti.com>
References: <1368796954-3499-1-git-send-email-kishon@ti.com>
 <51A43E0A.8090201@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5764837050227183952=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51A43E0A.8090201@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, tony@atomide.com
Cc: linux@arm.linux.org.uk, eballetbo@gmail.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, javier@dowhile0.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5764837050227183952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2OVELJTAMTAOLKXJQHTRA"

------enig2OVELJTAMTAOLKXJQHTRA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/05/13 08:18, Kishon Vijay Abraham I wrote:
> Hi Tony,
>=20
> On Friday 17 May 2013 06:52 PM, Kishon Vijay Abraham I wrote:
>> In order for controllers to get PHY in case of non dt boot, the phy
>> binding information (phy label) should be added in the platform
>> data of the controller.
>=20
> This series would be needed to get MUSB working in OMAP3 boards for
> non-dt boot case. Do you think this is good enough to go in this rc cyc=
le?

Did this or some other solution go forward? I'm still unable to boot
with usb-gadget-ethernet with v3.10-rc5.

 Tomi



------enig2OVELJTAMTAOLKXJQHTRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRucO2AAoJEPo9qoy8lh71WVsP/jmjAagz6yP6Pcb/UJs6Zlf7
EFSDgv3zc7YOPheEGruvwbiXO4EzkIFBmkOLXzPj3VNf0DtKEmyw5juInDzI2pYT
slaeLMZsHTBgmfHvsHKJX3vlCMyhkEuD1QXeFUvebTKy/bzQpbQF7Hr+zdnZ3w4K
UHKrNNJwynEhm95NuFfUB0HDNcaKV0X8oi3uMW5ilAzbrHxugsyBwg+HD9Y2m02W
VeyCzM6c/xOGuevYMyCWIInxk2DvbXIiXG+OrD10LEPhwVVibfgWwHrpOwCysCJC
00r5zL0FQliGuOPA08SlLYr46U+y1JvsoWy5/uVGJwMEstPSdbAs6A7mmhBbFekq
BuMbA7SOvWSJxSk0XIUl+p5gzug1eX4yf+w1kkXO4J+nclM/sN4eDnPsCUKGLjlm
ZhI+/8pIfJoNg+zz1s/jvLqzMOnLovitlfnm9zfMOf1OqrpwA6stMTH5wyJ7rltP
mHcbxCWNDkHn2qU8BMaFV4gL+Op8V3bxVCfCxfB6JQf3HUhATIl4A5uPSnazA2PO
1F6vI8bIFJJeyg5SP56thDIPffs6KKAWXQd9N5QhydnFkS9HEeVBuQ+u6t7UWeL+
Fox19gOtPsBl5DWrLncvjNT0//ab7fxFFLpb//vogDRMfsUYZqtUjPo0xWXoJLeR
ZY0/MWIVK4tXJ/ry7Mpt
=NJQ9
-----END PGP SIGNATURE-----

------enig2OVELJTAMTAOLKXJQHTRA--


--===============5764837050227183952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5764837050227183952==--
