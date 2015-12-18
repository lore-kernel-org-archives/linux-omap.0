From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: OMAP display kconfig options changing
Date: Fri, 18 Dec 2015 10:55:41 +0200
Message-ID: <5673CA0D.4000706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3244151952824490033=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3244151952824490033==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mVm7wi6KcOOnrm6nnx64kDth7glXLVijq"

--mVm7wi6KcOOnrm6nnx64kDth7glXLVijq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tony,

I've just pushed a patch series to fbdev for-next branch which makes the
OMAP DRM and FB drivers independent of each other. This requires
changing the related Kconfig options.

What should I do with omap2plus_defconfig?

At the moment omap2plus_defconfig enables the omapfb driver and panels
as modules. Should I change it to do the same with the new code? Or
should I change it to use omapdrm, which is the better maintained and
developed driver (although no one has probably tried omapdrm on omap2)?

 Tomi


--mVm7wi6KcOOnrm6nnx64kDth7glXLVijq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWc8oOAAoJEPo9qoy8lh71bv4P/32rIkFsJ5j9l73SvNPHn7vX
3ZRekH3oXUlbItCBfGnHx4FZzhP6JOT3SaMn1GHTi1i8pKXoz+lcZ/yBddSndndY
dq545vEshgv/SaiwGa38Onawwe5z55ZAjzPO7FjyNN2ly2i56rXM3it1mvX5P17F
rYeiXHkwfgIwm/hU95sEzakjAAKSCf/mhsaOh1HGu2r8uth2aV7xovL2EocVmvi4
FnxqJy1ZwNuolAkKjA1+77mngB2a+ktUKfiLFXHXlanbz2lGxtkw0WEwNlG4ZXL9
Tsjvbt2FFKH0Hqtcih1ebrpevV+j+2iASIlWHZmSH1NmBalkrh36swHoG+ihck7S
fGW02Q9h7bFhNddSqNIhoPmVKalwynrvWXNKtd6XnapHk5Ujs5uQRuvzCnpV7PKn
j7v0R2U37VRq7E7AMpPfABeWxbn8UeQgQdTBcjHoviLrJVZXIle8Ia9/fqeFVAmn
JARhd7JpbQ9IVPZI9BqGlOX2wmnpjz9GPTkmoIsLYa4DUe049pqVSlkVe5FSBhyW
I0E8mhFciLq3s7/9I060q4stcqd3vIV5gSxxg5tiVSL0t0I/jH65jqMF6R2iIyxx
425+WrJTMpMnuzu/P24rAKbVCouZQCc9YG3RIzIVOc+v+e4Yq80gCV6UCzESa7dr
GyOG8gf4WzxVZe65NquH
=t/vA
-----END PGP SIGNATURE-----

--mVm7wi6KcOOnrm6nnx64kDth7glXLVijq--


--===============3244151952824490033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3244151952824490033==--
