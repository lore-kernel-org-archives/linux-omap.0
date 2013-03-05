From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 8/8] ARM: dts: omap5: add dwc3 core dt data
Date: Tue, 5 Mar 2013 16:39:34 +0200
Message-ID: <20130305143934.GB12123@arwen.pp.htv.fi>
References: <1362494223-14151-1-git-send-email-kishon@ti.com>
 <1362494223-14151-9-git-send-email-kishon@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0209086326885699782=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362494223-14151-9-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============0209086326885699782==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 05, 2013 at 08:07:03PM +0530, Kishon Vijay Abraham I wrote:
> Add dwc3 core dt data as a subnode to dwc3 omap glue data in omap5 dt
> data file. The information for the entered data node is available @
> Documentation/devicetree/bindings/usb/dwc3.txt
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index c4eb2ec..24dd69f 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -514,6 +514,13 @@
>  			#size-cells =3D <1>;
>  			utmi-mode =3D <2>;
>  			ranges;
> +			dwc3@4a030000 {
> +				compatible =3D "synopsys,dwc3";
> +				reg =3D <0x4a030000 0x1000>;
> +				interrupts =3D <0 92 4>;
> +				usb-phy =3D <&usb2_phy>, <&usb3_phy>;
> +				tx-fifo-resize;

I think this should be merged with previous patch. Also, we need to
check whether tx-fifo-resize is needed with ES2 or not ;-)

--=20
balbi

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNgOmAAoJEIaOsuA1yqREhvAP/1WxhkKskft5voUhBdSFBhXr
4TWmn8lziRHiye04Qee5xhNFf6aXfT7KQ376UM6H78ZGpPpAt1v8fqHqVje87ZM+
3Fi2Vi09dbggC/1MXhDlkEpjYaxe4mJPxbFQl9OFwkC3gkDyXhjuiUf+3P9zhnr3
6dth3yXemC1xcPtidwjwMOs2P+c23wZ5GrjV4vOJiHZ3+/ldKVa2SR52uLTV+H/4
FQspiqVS9cVTifL6UPGmRkkAobHPB9EA0lmluxn8ELobL9M2YoYyAztXNf3BcJ7M
LgpGm4Rd2Np572a9e5BgJN15WbGrALdJzfhAQugNxnq012yZSzgM2ng2qhf9aEWV
Cfudnx0sOdTYG4WSucxAxKDaaRU03+Fp6L+zrr55ixG2YcXDqFGsj20YY+W0C2Sf
FzykW+LGRijcjurCMt5MoeNS5nhHjkLYbuMYiwPEKi4BwakhbwL7CzIUZSevSrsI
MmAnQnMxaI2x7bwbyLuv/kDsa5FEPuvqPW4nW+ulTKKveeYlwXO2cHVPh462hVXd
32rVRQnxnZDVrbwwGHZHMVZgkXkXqYX4HaZZP28vbITY0MobYhSlCMDfwfJzHi06
dLF3RTEwckoZgTdLbrQYHVaOl9f2aZS7rExK1nLwqF5UrEkc/Gv14JOsN3N68x5o
e977oaSz9w0kn9uUuHAS
=Z+cH
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

--===============0209086326885699782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0209086326885699782==--
