From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/5] regulator: Introduce TI Adaptive Body Bias(ABB)
 on-chip LDO driver
Date: Fri, 3 May 2013 10:02:58 +0100
Message-ID: <20130503090258.GG4945@sirena.org.uk>
References: <1367515215-30753-1-git-send-email-nm@ti.com>
 <1367515215-30753-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8625868075164494361=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1367515215-30753-2-git-send-email-nm-l0cyMroinI0@public.gmane.org>
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
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Andrii.Tseglytskyi" <andrii.tseglytskyi-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============8625868075164494361==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2013 at 12:20:10PM -0500, Nishanth Menon wrote:
> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi-l0cyMroinI0@public.gmane.org>
>=20
> Adaptive Body Biasing (ABB) modulates transistor bias voltages
> dynamically in order to optimize switching speed versus leakage.

I've applied this but please note that I still have deep concerns about
some of the discussion about controlling this from other regulators.

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg30/AAoJELSic+t+oim9GncP/3NEkoeofdTRdgmFPO1kdgGB
V7/vInEISlsssB26JwmkdR8U5RFyQHoOOsSZ+0iDkljRsaTFm1TRVpRcRiYgoiFh
SnKTeKoVPd/ElWToodrHzNfX8a+7WKLfyylgvH+sOeLlSK12+IaSzQt7+Y/4sQ0E
uavcEVTtZXdk92xZ7NNIM5HWiDXnZUtpfO+saNTY8dIZewQ8Lhpk228jVfUYx18r
d0wOSQGCtpST6RtdlzLOgnr4asNyoS22S1mJmQd5qWbn5+nLptdqMHDpRkVYgrEk
DEZ3shmUIJKfjGIHqDEo6/RHlwz0wuU2OqBSVbePy1/pz/taIwfV2ljxDxa7Qua0
RSQkmX48k70F9NPC34g/RTBocNjBxqB6K8YZezKOBYXo3JRu0ub7tdC+yawUg7fC
pGfIGI1CBIC68FFDVbhW6PyfPDMohE6TUVPBVSOV2KW2eI3LhGA0sCP2E0mWpHKo
filJjW+TGKBV7M+re6/Fch7JP7dbU9ercBofRa1H/aGLHVdbWIcRkc/ioXzO0s7r
cT4AFV59CCkC66RgAsKE7qViTodJOQUSI1MN2p6DE5NS6RZPXaKjaL7KXLSVIW9u
0IVukE/GT8wVtPIZs2PL7YqXlHuIUInxZihWfsHR7YY6QhBnci2wuYb2WTbahumI
d5iOkL2mwU9LDQmkqlN6
=WHVM
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--

--===============8625868075164494361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8625868075164494361==--
