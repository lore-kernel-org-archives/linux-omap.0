From: "Kyungmin Park" <kmpark@infradead.org>
Subject: [PATCH] Add PRCM scheme I on omap2420
Date: Fri, 16 Feb 2007 10:49:57 +0900
Message-ID: <006001c7516c$c87272d0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0061_01C751B8.385A1AD0"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0061_01C751B8.385A1AD0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit

Hi,

In the previous time, I sent the patch but not applied. [1]

Here's current git patch.

Thank you,
Kyungmin Park

1. http://linux.omap.com/pipermail/linux-omap-open-source/2006-
May/007076.html

------=_NextPart_000_0061_01C751B8.385A1AD0
Content-Type: text/plain; name="0001-ARM-OMAP-Add-PRCM-I-scheme-on-OMAP2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Add-PRCM-I-scheme-on-OMAP2.txt"

>From 4f8531d975c4cb44ffb3f86d68e5c9f141de0410 Mon Sep 17 00:00:00 2001=0A=
From: Kyungmin Park <kyungmin.park@samsung.com>=0A=
Date: Fri, 16 Feb 2007 10:45:46 +0900=0A=
Subject: [PATCH] ARM: OMAP: Add PRCM I scheme on OMAP2=0A=
=0A=
Add PRCM I scheme on OMAP2=0A=
=0A=
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>=0A=
---=0A=
 arch/arm/mach-omap2/clock.h |   38 =
+++++++++++++++++++++++++++++++++++++-=0A=
 1 files changed, 37 insertions(+), 1 deletions(-)=0A=
=0A=
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h=0A=
index 162978f..54bd116 100644=0A=
--- a/arch/arm/mach-omap2/clock.h=0A=
+++ b/arch/arm/mach-omap2/clock.h=0A=
@@ -174,7 +174,7 @@ struct prcm_config {=0A=
 #define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */=0A=
 #define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */=0A=
 #define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */=0A=
-#define RII_CLKSEL_IVA			(6 << 8)	/* iva1 - 200MHz */=0A=
+#define RII_CLKSEL_IVA			(3 << 8)	/* iva1 - 200MHz */=0A=
 #define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */=0A=
 #define RII_CM_CLKSEL_DSP_VAL		RII_SYNC_IVA | RII_CLKSEL_IVA | \=0A=
 					RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \=0A=
@@ -182,6 +182,27 @@ struct prcm_config {=0A=
 #define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */=0A=
 #define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX=0A=
 =0A=
+/* 2420-PRCM I 660MHz core */=0A=
+#define RI_CLKSEL_L3			(4 << 0)	/* 165MHz */=0A=
+#define RI_CLKSEL_L4			(2 << 5)	/* 82.5MHz */=0A=
+#define RI_CLKSEL_USB			(4 << 25)	/* 41.25MHz */=0A=
+#define RI_CM_CLKSEL1_CORE_VAL		RI_CLKSEL_USB | \=0A=
+					RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \=0A=
+					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \=0A=
+					RI_CLKSEL_L4 | RI_CLKSEL_L3=0A=
+#define RI_CLKSEL_MPU			(2 << 0)	/* 330MHz */=0A=
+#define RI_CM_CLKSEL_MPU_VAL		RI_CLKSEL_MPU=0A=
+#define RI_CLKSEL_DSP			(3 << 0)	/* c5x - 220MHz */=0A=
+#define RI_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 110MHz */=0A=
+#define RI_SYNC_DSP			(1 << 7)	/* Activate sync */=0A=
+#define RI_CLKSEL_IVA			(4 << 8)	/* iva1 - 165MHz */=0A=
+#define RI_SYNC_IVA			(0 << 13)	/* Bypass sync */=0A=
+#define RI_CM_CLKSEL_DSP_VAL		RI_SYNC_IVA | RI_CLKSEL_IVA | \=0A=
+					RI_SYNC_DSP | RI_CLKSEL_DSP_IF | \=0A=
+					RI_CLKSEL_DSP=0A=
+#define RI_CLKSEL_GFX			(1 << 0)	/* 165MHz */=0A=
+#define RI_CM_CLKSEL_GFX_VAL		RI_CLKSEL_GFX=0A=
+=0A=
 /* 2420-PRCM VII (boot) */=0A=
 #define RVII_CLKSEL_L3			(1 << 0)=0A=
 #define RVII_CLKSEL_L4			(1 << 5)=0A=
@@ -300,6 +321,13 @@ struct prcm_config {=0A=
  * boot (boot)=0A=
  */=0A=
 =0A=
+/* PRCM I target DPLL =3D 2*330MHz =3D 660MHz */=0A=
+#define MI_DPLL_MULT_12			(55 << 12)=0A=
+#define MI_DPLL_DIV_12			(1 << 8)=0A=
+#define MI_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \=0A=
+					MI_DPLL_DIV_12 | MI_DPLL_MULT_12 | \=0A=
+					MX_APLLS_CLIKIN_12=0A=
+=0A=
 /*=0A=
  * 2420 Equivalent - mode registers=0A=
  * PRCM II , target DPLL =3D 2*300MHz =3D 600MHz=0A=
@@ -352,6 +380,7 @@ struct prcm_config {=0A=
  * By having the boot loader boot up in the fastest L4 speed available =
likely=0A=
  * will result in something which you can switch between.=0A=
  */=0A=
+#define V24XX_SDRC_RFR_CTRL_165MHz	(0x00044c00 | 1)=0A=
 #define V24XX_SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)=0A=
 #define V24XX_SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)=0A=
 #define V24XX_SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */=0A=
@@ -394,6 +423,13 @@ struct prcm_config {=0A=
  * Note: This table needs to be sorted, fastest to slowest.=0A=
  =
*------------------------------------------------------------------------=
-*/=0A=
 static struct prcm_config rate_table[] =3D {=0A=
+	/* PRCM I - FAST */=0A=
+	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */=0A=
+		RI_CM_CLKSEL_DSP_VAL, RI_CM_CLKSEL_GFX_VAL,=0A=
+		RI_CM_CLKSEL1_CORE_VAL, MI_CM_CLKSEL1_PLL_12_VAL,=0A=
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_165MHz,=0A=
+		RATE_IN_242X},=0A=
+=0A=
 	/* PRCM II - FAST */=0A=
 	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */=0A=
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,=0A=
-- =0A=
1.4.4.2=0A=
=0A=

------=_NextPart_000_0061_01C751B8.385A1AD0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0061_01C751B8.385A1AD0--
