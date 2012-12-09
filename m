From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
Date: Sun, 09 Dec 2012 13:03:28 -0700
Message-ID: <20121209200327.3196.27686.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40208 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758932Ab2LIUFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:05:10 -0500
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

There's no need to determine the current power state for powerdomains
that must be on while the kernel is running.  We mark these
powerdomains with a new flag, PWRDM_ACTIVE_WITH_KERNEL.  Any
powerdomain marked with that flag is reported as being in the ON power
state while the kernel is running.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c           |    9 ++++++---
 arch/arm/mach-omap2/powerdomain.h           |    4 ++++
 arch/arm/mach-omap2/powerdomains2xxx_data.c |    2 ++
 arch/arm/mach-omap2/powerdomains33xx_data.c |    3 ++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c |    9 ++++++---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    5 ++++-
 6 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
index f5e2727..a4bb0bb 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -462,7 +462,8 @@ static int _pwrdm_read_fpwrst(struct powerdomain *p=
wrdm)
 	int pwrst, logic_pwrst, ret;
 	u8 fpwrst;
=20
-	if (!_pwrdm_pwrst_can_change(pwrdm))
+	if (!_pwrdm_pwrst_can_change(pwrdm) ||
+	    pwrdm->flags & PWRDM_ACTIVE_WITH_KERNEL)
 		return PWRDM_FUNC_PWRST_ON;
=20
 	pwrst =3D arch_pwrdm->pwrdm_read_pwrst(pwrdm);
@@ -1104,12 +1105,14 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwr=
dm)
=20
 int pwrdm_state_switch_nolock(struct powerdomain *pwrdm)
 {
-	int ret;
+	int ret =3D 0;
=20
 	if (!pwrdm || !arch_pwrdm)
 		return -EINVAL;
=20
-	ret =3D arch_pwrdm->pwrdm_wait_transition(pwrdm);
+	if (!(pwrdm->flags & PWRDM_ACTIVE_WITH_KERNEL))
+		ret =3D arch_pwrdm->pwrdm_wait_transition(pwrdm);
+
 	if (!ret)
 		_pwrdm_state_switch(pwrdm);
=20
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/po=
werdomain.h
index f4a189a..10941fd 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -78,10 +78,14 @@ enum pwrdm_func_state {
  *
  * PWRDM_HAS_LOWPOWERSTATECHANGE - can transition from a sleep state
  * to a lower sleep state without waking up the powerdomain
+ *
+ * PWRDM_ACTIVE_WITH_KERNEL - this powerdomain's current power state i=
s
+ * guaranteed to be ON whenever the kernel is running
  */
 #define PWRDM_HAS_HDWR_SAR		BIT(0)
 #define PWRDM_HAS_MPU_QUIRK		BIT(1)
 #define PWRDM_HAS_LOWPOWERSTATECHANGE	BIT(2)
+#define PWRDM_ACTIVE_WITH_KERNEL	BIT(3)
=20
 /*
  * Powerdomain internal flags (struct powerdomain._flags)
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mac=
h-omap2/powerdomains2xxx_data.c
index 578eef8..112927f 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -54,6 +54,7 @@ static struct powerdomain mpu_24xx_pwrdm =3D {
 		[0] =3D PWRSTS_ON,
 	},
 	.voltdm		  =3D { .name =3D "core" },
+	.flags		  =3D PWRDM_ACTIVE_WITH_KERNEL,
 };
=20
 static struct powerdomain core_24xx_pwrdm =3D {
@@ -73,6 +74,7 @@ static struct powerdomain core_24xx_pwrdm =3D {
 		[2] =3D PWRSTS_OFF_RET_ON, /* MEM3ONSTATE */
 	},
 	.voltdm		  =3D { .name =3D "core" },
+	.flags		  =3D PWRDM_ACTIVE_WITH_KERNEL,
 };
=20
=20
diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mac=
h-omap2/powerdomains33xx_data.c
index 869adb8..acb148a 100644
--- a/arch/arm/mach-omap2/powerdomains33xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
@@ -123,7 +123,8 @@ static struct powerdomain mpu_33xx_pwrdm =3D {
 	.pwrstst_offs		=3D AM33XX_PM_MPU_PWRSTST_OFFSET,
 	.pwrsts			=3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret	=3D PWRSTS_OFF_RET,
-	.flags			=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags			=3D (PWRDM_HAS_LOWPOWERSTATECHANGE |
+				   PWRDM_ACTIVE_WITH_KERNEL),
 	.banks			=3D 3,
 	.logicretstate_mask	=3D AM33XX_LOGICRETSTATE_MASK,
 	.mem_on_mask		=3D {
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mac=
h-omap2/powerdomains3xxx_data.c
index f0e14e9ef..ade93d3 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -58,7 +58,7 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
 	.prcm_offs	  =3D MPU_MOD,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
-	.flags		  =3D PWRDM_HAS_MPU_QUIRK,
+	.flags		  =3D (PWRDM_HAS_MPU_QUIRK | PWRDM_ACTIVE_WITH_KERNEL),
 	.banks		  =3D 1,
 	.pwrsts_mem_ret	  =3D {
 		[0] =3D PWRSTS_OFF_RET,
@@ -74,7 +74,7 @@ static struct powerdomain mpu_am35x_pwrdm =3D {
 	.prcm_offs	  =3D MPU_MOD,
 	.pwrsts		  =3D PWRSTS_ON,
 	.pwrsts_logic_ret =3D PWRSTS_ON,
-	.flags		  =3D PWRDM_HAS_MPU_QUIRK,
+	.flags		  =3D (PWRDM_HAS_MPU_QUIRK | PWRDM_ACTIVE_WITH_KERNEL),
 	.banks		  =3D 1,
 	.pwrsts_mem_ret	  =3D {
 		[0] =3D PWRSTS_ON,
@@ -110,6 +110,7 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm=
 =3D {
 		[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
 	.voltdm		  =3D { .name =3D "core" },
+	.flags		  =3D PWRDM_ACTIVE_WITH_KERNEL,
 };
=20
 static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
@@ -121,7 +122,8 @@ static struct powerdomain core_3xxx_es3_1_pwrdm =3D=
 {
 	 * Setting the SAR flag for errata ID i478 which applies
 	 *  to 3430 <=3D ES3.1
 	 */
-	.flags		  =3D PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
+	.flags		  =3D (PWRDM_HAS_HDWR_SAR |  /* for USBTLL only */
+			     PWRDM_ACTIVE_WITH_KERNEL),
 	.banks		  =3D 2,
 	.pwrsts_mem_ret	  =3D {
 		[0] =3D PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
@@ -149,6 +151,7 @@ static struct powerdomain core_am35x_pwrdm =3D {
 		[1] =3D PWRSTS_ON, /* MEM2ONSTATE */
 	},
 	.voltdm		  =3D { .name =3D "core" },
+	.flags		  =3D PWRDM_ACTIVE_WITH_KERNEL,
 };
=20
 static struct powerdomain dss_pwrdm =3D {
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mac=
h-omap2/powerdomains44xx_data.c
index 704664c..b64213c 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -53,7 +53,8 @@ static struct powerdomain core_44xx_pwrdm =3D {
 		[3] =3D PWRSTS_ON,	/* ducati_l2ram */
 		[4] =3D PWRSTS_ON,	/* ducati_unicache */
 	},
-	.flags		  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  =3D (PWRDM_HAS_LOWPOWERSTATECHANGE |
+			     PWRDM_ACTIVE_WITH_KERNEL),
 };
=20
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
@@ -164,6 +165,7 @@ static struct powerdomain cpu0_44xx_pwrdm =3D {
 	.pwrsts_mem_on	=3D {
 		[0] =3D PWRSTS_ON,	/* cpu0_l1 */
 	},
+	.flags		  =3D PWRDM_ACTIVE_WITH_KERNEL,
 };
=20
 /* cpu1_44xx_pwrdm: MPU1 processor and Neon coprocessor power domain *=
/
@@ -218,6 +220,7 @@ static struct powerdomain mpu_44xx_pwrdm =3D {
 		[1] =3D PWRSTS_ON,	/* mpu_l2 */
 		[2] =3D PWRSTS_ON,	/* mpu_ram */
 	},
+	.flags		  =3D PWRDM_ACTIVE_WITH_KERNEL,
 };
=20
 /* ivahd_44xx_pwrdm: IVA-HD power domain */


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
