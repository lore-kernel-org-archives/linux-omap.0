From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 1/2] arm: dts: omap4+: Add DMM bindings
Date: Tue, 11 Mar 2014 09:15:16 +0200
Message-ID: <531EB804.90702@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1381820660-5501-1-git-send-email-archit@ti.com> <1381820660-5501-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="LaNWtfPPfJxMfRsWKk10OAkXLQUrgQjAP"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381820660-5501-2-git-send-email-archit@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Archit Taneja <archit@ti.com>, bcousson@baylibre.com, tony@atomide.com, mark.rutland@arm.com
Cc: robdclark@gmail.com, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andy Gross <andygro@gmail.com>
List-Id: linux-omap@vger.kernel.org

--LaNWtfPPfJxMfRsWKk10OAkXLQUrgQjAP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 15/10/13 10:04, Archit Taneja wrote:
> Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 devices. =
DMM
> only requires address and irq information.
>=20
> Add documentation for the DMM bindings.
>=20
> Originally worked on by Andy Gross <andygro@gmail.com>
>=20
> Cc: Andy Gross <andygro@gmail.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/dmm.txt | 22 ++++++++++++++=
++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
>  arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
>  3 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

Has this been queued for 3.15?

 Tomi



--LaNWtfPPfJxMfRsWKk10OAkXLQUrgQjAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHrgEAAoJEPo9qoy8lh71xfoP/jt/ggDnsg5CXl/cQUnjVLQB
GYifRXzYuSWepXejLxfqpx4EsFn7X8Yl/fNHIBcHx6jmV1pOtw5vDAMQ5dzIq2Os
hL8M9SPaSUGDWT6selRQU1tERfM2NNLAwWX2a4hsvy/ArwODsEp47EDyR+pr5zJ3
QVICOpJsCF0w6W7DxIFL/xcphMB2ZiDSSaxcbj9ZKXIGQRzic+RfKQmLGHhOd+XY
D452ZQCFtjaoyYC4GDWIsHE8dcKkudX/eLsVasabI3Ich1DDbeQ0KYtBF3LldVBl
zbP64yErpdeSyfRwjuhQVnlNvyN/c7dks52Tfk9FlSOTzUEgLEXq8waa4QoDrG4K
qriZD9Uf8kI21XkeynV3WcMao1iKawbIIxrBF20+h6VP5jOFViL0pgwq4P7zpwTj
e3pk6AFgmnw7B6qL4q/EgRp6lG1ykFLWiUXsP3Clhz4Fbkr2cCAv7h1vsryh0XEQ
qr97VCs9T3dAW4MkJECKs1KBHw5p9hm3Q2MBPeMcYG8J0Jwv9vGnUjPqi8E99heG
02/PyS4DMDLwceuYX+NVodaHZ53Q2VeNC1V65WAKWRqjRdi6HPfPpOO2TiJtuLOT
GMN6EeSV6m5GtkcTUUtoU0rUcvLyukWEzfo+SBth6L5IbiKRQ6GzAlik2jA7WIF7
hOcJfWS7kebz+5BjRS/R
=rBGn
-----END PGP SIGNATURE-----

--LaNWtfPPfJxMfRsWKk10OAkXLQUrgQjAP--
