From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
Date: Fri, 6 Nov 2015 10:23:39 -0600
Message-ID: <87a8qryu44.fsf@saruman.tx.rr.com>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3722405456547243379=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446826430-3705-1-git-send-email-sre@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3722405456547243379==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Sebastian Reichel <sre@kernel.org> writes:
> This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> which breaks the omap3 device tree build due to a wrong reference.
>
> I accidently queued this change via the power supply subsystem while
> telling Marek at the same time, that it should go through Tony's tree.
> Following that I did miss Stephen's messages about the build failure in
> linux-next and since he switched to merging an older snapshot nobody
> else noticed the problem in my tree. I didn't notice myself, since I
> did not build any device tree files assuming none have changed by me.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reported-by: Felipe Balbi <balbi@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/twl4030.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.d=
tsi
> index 482b7aa37808..36ae9160b558 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -22,8 +22,6 @@
>  	charger: bci {
>  		compatible =3D "ti,twl4030-bci";
>  		interrupts =3D <9>, <2>;
> -		io-channels =3D <&twl4030_madc 11>;
> -		io-channel-name =3D "vac";
>  		bci3v1-supply =3D <&vusb3v1>;
>  	};
>=20=20
> --=20
> 2.6.2
>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPNQNAAoJEIaOsuA1yqRE3CAQAKSCOWsZ7rqPDqNL3oORM6Hr
78QRDRWwzw4QmIogouvOA1dJA7fwPrrzIBA1YAg7cTLEEZuoBFo5VWUs7CzzyRCl
TlmBSbqYeZS5bCxMVS5Jdeop+k3q/wFCoF/fm7TqDWL0n3v/XbDTIc5J37BUY4Ie
55glmdLGnl9VCMKtedl4rcsBWZ8XR1vgZiyASxrq+oPzqS76H9HIc9E1U8qisGwx
94n7Zh0waPMWbVcPoOZdMXsFGLN6gijsUj4l0c1HYXjqTjksyIMSFB9CPqEERn6D
Bs/oReEl0DE+aHKX7GmTf++rwzYIHTPIavAG9AM/SAGyH4JsuW/8ejGKh3MIh35w
X9k1Fop5ll5qcW5c2KllpFFqXoTA8/16MIGMN3kI/gRj2UFibokcD4lyFsGQU9Sk
bsKagyIenhrf44UQHN5icxm+/6WVwEk5X/FJjh7+mmk+Uj8sfr2UYCk1ecVFehn+
Z1/PgIgEjh0dpsy+HCRbz9CdEcstLlZ+FcVczHdrIjXpFiRFSa9gS2SQpNUl78cf
9iXkumq5I6O9AiGG68Jz0Dgl/Bmi+rEsPbB05aUnMlrVIBuJPReLKyi8p1FXX3CP
cqcnKndtdA4PAPqHUM8Vh/kSwVySNNUD9P6lB2miTmIIadh2xmN4qrxjO/9RG2AK
Ux4IihP/QsjQE3dF1AfY
=EueI
-----END PGP SIGNATURE-----
--=-=-=--


--===============3722405456547243379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3722405456547243379==--
