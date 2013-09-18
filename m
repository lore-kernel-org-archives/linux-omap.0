From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/2] RX-51: Add support for OMAP3 ROM Random Number Generator
Date: Wed, 18 Sep 2013 22:05:57 +0200
Message-ID: <1379534757-20870-3-git-send-email-pali.rohar@gmail.com>
References: <201303281854.02847@pali>
 <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51.c  |   10 ++++++++++
 arch/arm/mach-omap2/omap-secure.c |   11 +++++++++++
 arch/arm/mach-omap2/omap-secure.h |    1 +
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
index db168c9..c2a3e39 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -93,6 +93,14 @@ static struct omap_musb_board_data musb_board_data =3D=
 {
 	.power			=3D 0,
 };
=20
+static struct platform_device omap3_rom_rng_device =3D {
+	.name		=3D "omap_rng",
+	.id		=3D -1,
+	.dev	=3D {
+		.platform_data	=3D rx51_secure_rng_call,
+	},
+};
+
 static void __init rx51_init(void)
 {
 	struct omap_sdrc_params *sdrc_params;
@@ -113,6 +121,8 @@ static void __init rx51_init(void)
 		/* set IBE to 1 */
 		rx51_secure_update_aux_cr(BIT(6), 0);
 #endif
+		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
+		platform_device_register(&omap3_rom_rng_device);
 	}
=20
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/om=
ap-secure.c
index 146a7c4..5ac122e 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -135,3 +135,14 @@ u32 rx51_secure_update_aux_cr(u32 set_bits, u32 cl=
ear_bits)
 				      FLAG_START_CRITICAL,
 				      1, acr, 0, 0, 0);
 }
+
+/**
+ * rx51_secure_rng_call: Routine for HW random generator
+ */
+u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag)
+{
+	return rx51_secure_dispatcher(RX51_PPA_HWRNG,
+				      0,
+				      NO_FLAG,
+				      3, ptr, count, flag, 0);
+}
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/om=
ap-secure.h
index 51b59c6..f6cabb0 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -65,6 +65,7 @@ extern int omap_secure_ram_reserve_memblock(void);
 extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 =
nargs,
 				  u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
+extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
=20
 #ifdef CONFIG_OMAP4_ERRATA_I688
 extern int omap_barrier_reserve_memblock(void);
--=20
1.7.10.4
