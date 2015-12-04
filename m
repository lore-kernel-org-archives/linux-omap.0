From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Date: Fri, 4 Dec 2015 11:21:49 -0600
Message-ID: <87wpsunn82.fsf@saruman.tx.rr.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0516450787631601975=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0516450787631601975==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> @@ -174,12 +182,44 @@
>  		};
>=20=20
>  		edma: edma@49000000 {
> -			compatible =3D "ti,edma3";
> -			ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";
> -			reg =3D	<0x49000000 0x10000>,
> -				<0x44e10f90 0x40>;
> +			compatible =3D "ti,edma3-tpcc";
> +			ti,hwmods =3D "tpcc";
> +			reg =3D	<0x49000000 0x10000>;
> +			reg-names =3D "edma3_cc";
>  			interrupts =3D <12 13 14>;
> -			#dma-cells =3D <1>;
> +			interrupt-names =3D "edma3_ccint", "emda3_mperr",
> +					  "edma3_ccerrint";
> +			dma-requests =3D <64>;
> +			#dma-cells =3D <2>;
> +
> +			ti,tptcs =3D <&edma_tptc0 7>, <&edma_tptc1 5>,
> +				   <&edma_tptc2 0>;
> +
> +			ti,edma-memcpy-channels =3D /bits/ 16 <20 21>;

can you explain this property here ? Are you setting bits 20 and 21 on a
16-bit field ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYcuuAAoJEIaOsuA1yqREF/8P/jgEVUYtpWffnZkGywga/nj2
h3LLH7txd10InHR9RFrsVzid/gP3C8lutU8RV/H6vRIAQcrpc6XVrMht6W5QbpLr
kHCBn/2SH/EA5ZYjr6xLTn95Qx9OezAyRTtE51S2h1ifqSEBTMtJ9/fmeEFmRU8t
X0zfoQcLiLRnU0UoVfwzEAGbuH4+7/cU6gS3pCNqMfUV53bar1Wd6udgZm1GPRjc
XJiR6XROwaHhhEvbjrlYBj4cAFpmNSuQOgVoBX5Ei32zA/QLnj+J7gTgKAWnbaks
8wilUwe04qVnb/lRuIeXH2XmuTbWdCuTvvhvW15cb5/p+Qo+z16MT3axVglosBOO
0dYs54/Q1He7RaR+pxG9GBcRc3VGhxES3SienIVJ1NIGXWlAcI20izg2YAQvCRyj
kOQjixSOElaYj/IwTaAekunra8qler2R8W56Z+Ykd8XTLNapN1VBMppcbDYUlJ8B
mUcTtsNHg3SWouvv0Y2RePpR8UBFzCfV7th2bG7uUWjKKcY4S93axIBJq+e+5eET
M0tiwH8ML1Mm10h3gzt/nqOhqsQNfomF+x5QxP7uVZEiV9B4ltIWGWAtxKTEZuE0
DlqGmCSoMJhjWou+sOVNC+xyNUZK8kg3ZcrkKqC2Zy0f/59d6UoKH+oC8E2kUuSc
Cug5lFBJVKVAUNUhwxYE
=Mpvy
-----END PGP SIGNATURE-----
--=-=-=--


--===============0516450787631601975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0516450787631601975==--
