From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 15/15] ARM: vfp: cleanup cppcheck shifting errors
Date: Sun, 23 Jun 2019 22:13:13 +0700
Message-ID: <20190623151313.970-16-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

[arch/arm/vfp/vfpdouble.c:397]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour
[arch/arm/vfp/vfpdouble.c:407]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour
[arch/arm/vfp/vfpmodule.c:263]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour
[arch/arm/vfp/vfpmodule.c:264]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour
[arch/arm/vfp/vfpsingle.c:441]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour
[arch/arm/vfp/vfpsingle.c:451]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/vfp/vfpinstr.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
index 38dc154e39ff..377ab0ced8d8 100644
--- a/arch/arm/vfp/vfpinstr.h
+++ b/arch/arm/vfp/vfpinstr.h
@@ -8,8 +8,8 @@
  * VFP instruction masks.
  */
 #define INST_CPRTDO(inst)	(((inst) & 0x0f000000) == 0x0e000000)
-#define INST_CPRT(inst)		((inst) & (1 << 4))
-#define INST_CPRT_L(inst)	((inst) & (1 << 20))
+#define INST_CPRT(inst)		((inst) & (1U << 4))
+#define INST_CPRT_L(inst)	((inst) & (1U << 20))
 #define INST_CPRT_Rd(inst)	(((inst) & (15 << 12)) >> 12)
 #define INST_CPRT_OP(inst)	(((inst) >> 21) & 7)
 #define INST_CPNUM(inst)	((inst) & 0xf00)
@@ -27,7 +27,7 @@
 #define FOP_FDIV	(0x00800000)
 #define FOP_EXT		(0x00b00040)
 
-#define FOP_TO_IDX(inst)	((inst & 0x00b00000) >> 20 | (inst & (1 << 6)) >> 4)
+#define FOP_TO_IDX(inst)	((inst & 0x00b00000) >> 20 | (inst & (1U << 6)) >> 4)
 
 #define FEXT_MASK	(0x000f0080)
 #define FEXT_FCPY	(0x00000000)
@@ -46,21 +46,21 @@
 #define FEXT_FTOSI	(0x000d0000)
 #define FEXT_FTOSIZ	(0x000d0080)
 
-#define FEXT_TO_IDX(inst)	((inst & 0x000f0000) >> 15 | (inst & (1 << 7)) >> 7)
+#define FEXT_TO_IDX(inst)	((inst & 0x000f0000) >> 15 | (inst & (1U << 7)) >> 7)
 
-#define vfp_get_sd(inst)	((inst & 0x0000f000) >> 11 | (inst & (1 << 22)) >> 22)
-#define vfp_get_dd(inst)	((inst & 0x0000f000) >> 12 | (inst & (1 << 22)) >> 18)
-#define vfp_get_sm(inst)	((inst & 0x0000000f) << 1 | (inst & (1 << 5)) >> 5)
-#define vfp_get_dm(inst)	((inst & 0x0000000f) | (inst & (1 << 5)) >> 1)
-#define vfp_get_sn(inst)	((inst & 0x000f0000) >> 15 | (inst & (1 << 7)) >> 7)
-#define vfp_get_dn(inst)	((inst & 0x000f0000) >> 16 | (inst & (1 << 7)) >> 3)
+#define vfp_get_sd(inst)	((inst & 0x0000f000) >> 11 | (inst & (1U << 22)) >> 22)
+#define vfp_get_dd(inst)	((inst & 0x0000f000) >> 12 | (inst & (1U << 22)) >> 18)
+#define vfp_get_sm(inst)	((inst & 0x0000000f) << 1 | (inst & (1U << 5)) >> 5)
+#define vfp_get_dm(inst)	((inst & 0x0000000f) | (inst & (1U << 5)) >> 1)
+#define vfp_get_sn(inst)	((inst & 0x000f0000) >> 15 | (inst & (1U << 7)) >> 7)
+#define vfp_get_dn(inst)	((inst & 0x000f0000) >> 16 | (inst & (1U << 7)) >> 3)
 
 #define vfp_single(inst)	(((inst) & 0x0000f00) == 0xa00)
 
-#define FPSCR_N	(1 << 31)
-#define FPSCR_Z	(1 << 30)
-#define FPSCR_C (1 << 29)
-#define FPSCR_V	(1 << 28)
+#define FPSCR_N	(1U << 31)
+#define FPSCR_Z	(1U << 30)
+#define FPSCR_C (1U << 29)
+#define FPSCR_V	(1U << 28)
 
 /*
  * Since we aren't building with -mfpu=vfp, we need to code
-- 
2.11.0
