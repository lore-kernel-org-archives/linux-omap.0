From: Felipe Balbi <balbi@ti.com>
Subject: Regression with AM43xx devices
Date: Tue, 2 Jun 2015 14:17:52 -0500
Message-ID: <20150602191752.GE9623@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51970 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbbFBTU3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 15:20:29 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

You commit fabbe6df130a46d5b5e7484b2273d69c4be3012a (ARM: OMAP: AM43xx
hwmod: Add data for am43xx emif hwmod) listed below added a new WARNING
during boot to all AM43xx-based boards. Full boot logs can be found at
[1], but it seems like we should, at least for the merge window, revert
said commit unless a fix could come it the next couple days or so.o

ps: note that boot log is for AM43xx IDK, but the same thing has been
reproduced on AM437x SK.

[1] http://hastebin.com/kasenikevo

------------------------------------------------------------------------

commit fabbe6df130a46d5b5e7484b2273d69c4be3012a
Author: Dave Gerlach <d-gerlach@ti.com>
Date:   Mon Jun 1 19:22:11 2015 -0600

    ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod
   =20
    Without a hwmod for am43xx emif use counting for emif clockdomain does
    not happen correctly so it may be shut off by pm code unintentionally.
   =20
    Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
    [paul@pwsan.com: updated to apply]
    Signed-off-by: Paul Walmsley <paul@pwsan.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/=
arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
index 130332c0534d..7f737965f543 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -145,6 +145,7 @@ extern struct omap_hwmod am33xx_uart5_hwmod;
 extern struct omap_hwmod am33xx_uart6_hwmod;
 extern struct omap_hwmod am33xx_wd_timer1_hwmod;
=20
+extern struct omap_hwmod_class am33xx_emif_hwmod_class;
 extern struct omap_hwmod_class am33xx_l4_hwmod_class;
 extern struct omap_hwmod_class am33xx_wkup_m3_hwmod_class;
 extern struct omap_hwmod_class am33xx_control_hwmod_class;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch=
/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index ae0cb673a3d1..907a452b78ea 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -203,6 +203,19 @@ struct omap_hwmod am33xx_prcm_hwmod =3D {
 };
=20
 /*
+ * 'emif' class
+ * instance(s): emif
+ */
+static struct omap_hwmod_class_sysconfig am33xx_emif_sysc =3D {
+	.rev_offs	=3D 0x0000,
+};
+
+struct omap_hwmod_class am33xx_emif_hwmod_class =3D {
+	.name		=3D "emif",
+	.sysc		=3D &am33xx_emif_sysc,
+};
+
+/*
  * 'aes0' class
  */
 static struct omap_hwmod_class_sysconfig am33xx_aes0_sysc =3D {
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_33xx_data.c
index 0cf7b563dcd1..cc0791d9125b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -34,19 +34,6 @@
  * IP blocks
  */
=20
-/*
- * 'emif' class
- * instance(s): emif
- */
-static struct omap_hwmod_class_sysconfig am33xx_emif_sysc =3D {
-	.rev_offs	=3D 0x0000,
-};
-
-static struct omap_hwmod_class am33xx_emif_hwmod_class =3D {
-	.name		=3D "emif",
-	.sysc		=3D &am33xx_emif_sysc,
-};
-
 /* emif */
 static struct omap_hwmod am33xx_emif_hwmod =3D {
 	.name		=3D "emif",
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_43xx_data.c
index 17e8004fc20f..215d5efa0dba 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -24,6 +24,20 @@
=20
=20
 /* IP blocks */
+static struct omap_hwmod am43xx_emif_hwmod =3D {
+	.name		=3D "emif",
+	.class		=3D &am33xx_emif_hwmod_class,
+	.clkdm_name	=3D "emif_clkdm",
+	.flags		=3D HWMOD_INIT_NO_IDLE,
+	.main_clk	=3D "dpll_ddr_m2_ck",
+	.prcm		=3D {
+		.omap4	=3D {
+			.clkctrl_offs	=3D AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET,
+			.modulemode	=3D MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 static struct omap_hwmod am43xx_l4_hs_hwmod =3D {
 	.name		=3D "l4_hs",
 	.class		=3D &am33xx_l4_hwmod_class,
@@ -583,6 +597,13 @@ static struct omap_hwmod am43xx_vpfe1_hwmod =3D {
 };
=20
 /* Interfaces */
+static struct omap_hwmod_ocp_if am43xx_l3_main__emif =3D {
+	.master		=3D &am33xx_l3_main_hwmod,
+	.slave		=3D &am43xx_emif_hwmod,
+	.clk		=3D "dpll_core_m4_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs =3D {
 	.master		=3D &am33xx_l3_main_hwmod,
 	.slave		=3D &am43xx_l4_hs_hwmod,
@@ -918,6 +939,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[]=
 __initdata =3D {
 	&am33xx_l3_main__l3_instr,
 	&am33xx_l3_main__gfx,
 	&am33xx_l3_s__l3_main,
+	&am43xx_l3_main__emif,
 	&am33xx_pruss__l3_main,
 	&am43xx_wkup_m3__l4_wkup,
 	&am33xx_gfx__l3_main,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index d0261996db6d..7eebc27fa892 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -146,4 +146,6 @@
 #define AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET		0x04a0
 #define AM43XX_CM_PER_VPFE0_CLKCTRL_OFFSET		0x0068
 #define AM43XX_CM_PER_VPFE1_CLKCTRL_OFFSET		0x0070
+#define AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET		0x0720
+
 #endif

--------------------------------------------------------------------------

git bisect start
# good: [e26081808edadfd257c6c9d81014e3b25e9a6118] Linux 4.1-rc4
git bisect good e26081808edadfd257c6c9d81014e3b25e9a6118
# bad: [073c2e3b6d0b06be76e9d80e0879a95f7bd4a421] Merge tag 'omap-for-v4.2/=
o2_dc' into for-next
git bisect bad 073c2e3b6d0b06be76e9d80e0879a95f7bd4a421
# good: [f044523a11ca9b32bfa7f663cded1071e55fb51a] Merge branch 'omap-for-v=
4.2/dt' into for-next
git bisect good f044523a11ca9b32bfa7f663cded1071e55fb51a
# good: [c663484536a2c3f7be583b72c014a850dd1b43c6] Merge tag 'omap-for-v4.1=
/fixes-rc6' into for-next
git bisect good c663484536a2c3f7be583b72c014a850dd1b43c6
# good: [5fbfa07151978e2432bc4321003ac2c40d22382d] Merge tag 'omap-for-v4.2=
/wakeirq-drivers' into for-next
git bisect good 5fbfa07151978e2432bc4321003ac2c40d22382d
# bad: [436bbc12452c23b9e7385f3fcabc82fdd387a55a] Merge tag 'for-v4.2/omap-=
hwmod-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending =
into omap-for-v4.2/soc
git bisect bad 436bbc12452c23b9e7385f3fcabc82fdd387a55a
# bad: [fabbe6df130a46d5b5e7484b2273d69c4be3012a] ARM: OMAP: AM43xx hwmod: =
Add data for am43xx emif hwmod
git bisect bad fabbe6df130a46d5b5e7484b2273d69c4be3012a
# good: [63aa945b1013c34b145dcf218d4ea323cbd93f86] memory: omap-gpmc: Add K=
config option for debug
git bisect good 63aa945b1013c34b145dcf218d4ea323cbd93f86
# first bad commit: [fabbe6df130a46d5b5e7484b2273d69c4be3012a] ARM: OMAP: A=
M43xx hwmod: Add data for am43xx emif hwmod

--=20
balbi

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbgFgAAoJEIaOsuA1yqREyuEP/2tzelZM9L8DsBXTTr31EqJg
UAb+wb/B/D13fYKDTWsLC+m25NQ38J7k9xC/mGuc1g7FJj/HOa5ULefZurNIjFBJ
9DyLmAtrTqX53+Aj43tWO/UuBpEBl25Lm9zzPVrbzcBpAFsURFbeDJ1+s+VnAzCD
Q9qJtT3cEHBMEWiqg/UjZI//mNN4DNDdHCZ/fOk6s+rmx4Jy4ikEuI/t2V24yUwO
oRpSN9Y7jIeAhIKExbGudG/0IWvjfDJ9rgj3oMoUapfq5Kqmh/0ciC9drGcgIYcj
pZ5sSleJLHOifIkbtry7SNDrfn1X91zYZGwVRlPefmzE13DQmXPgA7qjTPmgDpI5
Ah5IcczqojzUrAxWZYaREsdIB9DS1FLWwUNXDIJ/Idohzgwmy6e/l+c5AfnrBzgv
MLbTeUb0wcncVgAn9MEvekOtqHVVxJiKNgEpDrEw39Y/Ac0LFVh479hJKkmIvRL2
B+sniCoYslqhTD1Ht1Q3Wn38IMYt72D4zHPW26pVRiKreogFf50j6g5IQRGlM69A
6xEtZRwIvRDqS0oR3HqoAcBI+GnoSM9+j/2DX6VZaWGghPnmq+Y3a+fbtdAegkCQ
BRH6phtx4rm631RTHufImu+JXlKpjvCCAMugBuBCmemaJQ5yqsAwaGgxQk/LuaHZ
UFr4oHRH7L5pN3mKRsCf
=0RBy
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
