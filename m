From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2: board-generic: use omap4_local_timer_init for
 AM437x
Date: Fri, 6 Nov 2015 13:38:38 -0600
Message-ID: <87d1vmyl35.fsf@saruman.tx.rr.com>
References: <1445375159-22234-1-git-send-email-balbi@ti.com>
 <563C5F3C.5090900@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3591962641759570334=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <563C5F3C.5090900@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <a0131933@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============3591962641759570334==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Lokesh Vutla <a0131933@ti.com> writes:
> On Wednesday 21 October 2015 02:35 AM, Felipe Balbi wrote:
>> AM437x-based boards, can use omap4_local_timer_init()
>> just fine. Let's use that instead.
>
> This is breaking AM43x-epos board.
> Today's Linux next: http://pastebin.ubuntu.com/13122620/
> Reverting this patch: http://pastebin.ubuntu.com/13122621/

seems like the 32k timer isn't ticking. I don't have EPOS around, care
to confirm if that board has 32k oscillator populated ? If it doesn't,
then we should probably disable counter32k:

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x=
-epos-evm.dts
index 86c2dfbe8875..e703e32b6da6 100644
=2D-- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -792,3 +792,8 @@
 	tx-num-evt =3D <32>;
 	rx-num-evt =3D <32>;
 };
+
+/* 32kHz oscillator not populated */
+&counter32k {
+	status =3D "disabled";
+};

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPQG/AAoJEIaOsuA1yqREV/4P/2JtnQqXxv4fpjqk05CZWWTN
a1zqcNWT/kQrInVkyPr5rTA9zTA9/PNptgTFQE9Dr0mZ79BReCJuJIaz1VJrtxCx
fxS/oSzU6V79CuqNu7KrxO1MYyu3w/oTmkS2mMcusUuL+ek5hgdEXROgObqz0CIa
/j6JpIXvv15mBSU60JmDvIzO86rn4Sl9xalp0cg2Q/R2i5P1pdysysgR9VvBxCBP
1YPI7uvm2S4OdujcWfPSaBpOvS9hWNFrdq8KnamYiYR1ueHDD08ws27qy/raj2jX
PR/8sXdRSn2UoSlcemGfW37zhFPBgD3I0VzYTFselpP7SnihGKo/zbiQXKtygtfJ
ngZkILvxkQn34hkZodMX7NdyL+tyXia7QmKTxCU/tt1rKE1insxORvxWY1pAFN8z
NxFg/Fc3YkZxNm5EjJz4SXSPDC00Xc0L2d1tolcxIQKCfr89Q9MhC79FaaK8PunO
BL+sA+YioeU881jNjhvmYZq3MmaZ0u+M1TUqKI5ruPgsHUwloV83xLCvR0HEiq42
GUn6nqxj5l4lhaM5pKWH5+4hO2TOpqeFob+1/s45/WCGEUIBJ4qcNZHX23xPg1AV
lt9gZvjblv0GO83xoZH3TjgRIPULJz59zF2ooATwkjO9iqDOWI8RWLMNMDZlXs9v
xJc7gMGEB9wX4mFMM3Jo
=G0up
-----END PGP SIGNATURE-----
--=-=-=--


--===============3591962641759570334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3591962641759570334==--
