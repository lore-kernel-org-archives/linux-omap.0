From: Felipe Balbi <balbi@ti.com>
Subject: Re: Linus HEAD build break
Date: Fri, 6 Nov 2015 08:24:07 -0600
Message-ID: <87y4ebyznc.fsf@saruman.tx.rr.com>
References: <871tc31atk.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3078188002589908473=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <871tc31atk.fsf@saruman.tx.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@kernel.org>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3078188002589908473==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi again,

Felipe Balbi <balbi@ti.com> writes:
> Hi Marek,
>
> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
> subnode") breaks build on current linus/master (which current sits in

this commit cannot be found in next. How come it's in linus/master ?

If it had been in next, we'd find out about it a lot sooner and avoid
the build regression. It seems author didn't build his own patch,
considering the error is clear. Here's a patch, please merge it or
provide a better version. Below has been build tested
(omap2plus_defconfig) and boot tested (am437x SK, am437x IDK, beaglebone
black) (yeah, I don't have boards which sport MADC around).

8<---------------------------------------------------------------

From=207af26f7123bad3e9c9dcfe9dfe9f4ad58e56f7cb Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Fri, 6 Nov 2015 08:14:45 -0600
Subject: [PATCH] ARM: dts: twl4030: fix Monitoring ADC label

commit af19161aaed7 ("ARM: dts: twl4030: Add iio
properties for bci subnode") breaks build of several
DTS files by referring to a label that doesn't
exist. Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
=2D--
 arch/arm/boot/dts/twl4030.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 482b7aa37808..c8197f209efc 100644
=2D-- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -22,7 +22,7 @@
 	charger: bci {
 		compatible =3D "ti,twl4030-bci";
 		interrupts =3D <9>, <2>;
=2D		io-channels =3D <&twl4030_madc 11>;
+		io-channels =3D <&twl_madc 11>;
 		io-channel-name =3D "vac";
 		bci3v1-supply =3D <&vusb3v1>;
 	};
=2D-=20
2.6.2



=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPLgJAAoJEIaOsuA1yqREL18QAJbs486JHAgO7jaBklN2uL/C
uOWvIODS1MBWgHp6qg2doIqWn7+/xsTZ0L5wwJrwDxG1Sb3XMO9enk/cIeNXkSRb
7fSjwgA1/cf+PTDL5ZZ9Ej74dQVojcjzshWgv4gRJySnjDH9vhrbdPjDWcekUdPQ
dy+DrIQzLWnB0WroUqFPNC4oDrDvdsRkqkDuK6qqGzVH5jY2UxUNxjKD+QIs2Ua1
UMBUo9AurQMNH3Fhe9BZbst9sR3U82wqRh9LVhWxCktrVlXoRVCWFm1Bk/6pVHQr
92D1dnA8pmvC/yqmjQICQvLXKxYNdm3D7CpgKMOfq3kMc+dK9a22GvdQNEHqisuh
Ax1wjqxowtfLiNEsirjdsw+Jam55G61E2hz41eYSnLUI14/gZicr7zCtzc1KoeiE
F5a8G09z1KREmT5uBa4uJcUtwwOL+/sa3pVQ8Sl+Cikd6tAmMpKAu6Xii66IfeAB
8orAH6VR/oim8PG1S++d4ImbCItDMnDsFnramFzLclWITc8CQso8Z6MMOQcNY8LD
D9b5HL2cjDCreaNXWF5dJT1OjOnl3y86BPmbAMX+dqLTp6EMTUahO7RPlATVRFxK
LlhIS2EhDBYB3qKnJwFs2Z69R9kc19K1IYX9Um0mQM/ssZQz/FhsqlC0eblZanfY
KEbBoMmXfiyLF0vDdt45
=3e+w
-----END PGP SIGNATURE-----
--=-=-=--


--===============3078188002589908473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3078188002589908473==--
