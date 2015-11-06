From: Felipe Balbi <balbi@ti.com>
Subject: Linus HEAD build break
Date: Fri, 6 Nov 2015 08:06:47 -0600
Message-ID: <871tc31atk.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5877006406810223497=="
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
To: Marek Belisko <marek@goldelico.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5877006406810223497==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Marek,

your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
subnode") breaks build on current linus/master (which current sits in
d1e41ff11941 Merge tag 'platform-drivers-x86-v4.4-1' of
git://git.infradead.org/users/dvhart/linux-platform-drivers-x86) for
anybody including twl4030.dtsi because it refers to a non-existent
twl4030_madc label. Build output of make V=3D1 dtbs:

<stdin>:1304:2: warning: #warning syscall mlock2 not implemented [-Wcpp]
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap2430-sdp=
.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap2430-sdp.dtb] Error 2
make[2]: *** Waiting for unfinished jobs....
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3430-sdp=
.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3430-sdp.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/logicpd-torp=
edo-37xx-devkit.dtb' failed
make[2]: *** [arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dtb] Error 2
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-beagle=
.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-beagle.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-beagle=
-xm-ab.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-beagle-xm-ab.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-cm-t35=
30.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-cm-t3530.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-beagle=
-xm.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-beagle-xm.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-devkit=
8000.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-devkit8000.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-gta04a=
4.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-gta04a4.dtb] Error 2
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-gta04a=
3.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-gta04a3.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-evm-37=
xx.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-evm-37xx.dtb] Error 2
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-evm.dt=
b' failed
make[2]: *** [arch/arm/boot/dts/omap3-evm.dtb] Error 2
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-cm-t37=
30.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-cm-t3730.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-gta04a=
5.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-gta04a5.dtb] Error 2
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-devkit=
8000-lcd70.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-devkit8000-lcd70.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl403=
0_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-devkit=
8000-lcd43.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-devkit8000-lcd43.dtb] Error 2
arch/arm/Makefile:338: recipe for target 'dtbs' failed
make[1]: *** [dtbs] Error 2
Makefile:146: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

Reverting that commit makes it build again.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPLP4AAoJEIaOsuA1yqREONQQAK506vIGJE6fE/ns9qszGJ8S
IAWm8BhbnvV74g4ajcTXyZah7uw+Er2zOa6V8NaEmJFI9TRSJMOWl7N0ndcAukyi
4q8C6HD9SwC3C1ycl4T8SJ0JaLjWW0V1r2qYSC5c3yl3EVqbO8lVKJfmawxwWpE2
Hn4OoDkAC+kd4h/PEI3jJN+zpaCKPAaVwYd8rkOyfjVdJzep9F8l7vvaNyyQxibL
iwJj0thqO6BzypNU4aFv/mSBnGDdLbYgsXbyxS0pLhBQujntHVec4rCrx650lWKe
tqcvGiDNtMuJcX7dyQxP6xDJS1lCs3TKd/AP7Lg9sHgEi0zmGSZhVggah1eXVR5m
6hx0yyOE5KuV1JHNGJXDPsgCh+GXWnaegtSl+BAeR3rbV2ifGb9+lRNarWeDVzlE
5E6kc3q7aLHztNYKzlqnky6mej2fzoWaC+C7f1t4hAJ7CG8Dx1C6OZ4+x2abDm5e
rhkHaZqHhjizLVsi3NEUQ75hrkTl/nC9MsyIYvAGrvPdqFdw7o3S2fXARYQxa+RU
welzP1FJC1CL1obFp2agS5E1cwNjp22Z4ogVJehI62bbSRmjLBhxv/stPzeG3vh9
kdgwtfh/i3kuJu60d6DR/Vq/ImzN7YCbLyLdv+E2NdjZpdy//wgXGmeTNqNOfS3c
jP+MP5/P2WJOgdrvsWUW
=g+rV
-----END PGP SIGNATURE-----
--=-=-=--


--===============5877006406810223497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5877006406810223497==--
