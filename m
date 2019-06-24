From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V2 15/15] ARM: vfp: cleanup cppcheck shifting errors
Date: Mon, 24 Jun 2019 20:51:05 +0700
Message-ID: <20190624135105.15579-16-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
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
 arch/arm/vfp/vfpinstr.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
index 38dc154e39ff..8951637c58ff 100644
--- a/arch/arm/vfp/vfpinstr.h
+++ b/arch/arm/vfp/vfpinstr.h
@@ -57,10 +57,10 @@
 
 #define vfp_single(inst)	(((inst) & 0x0000f00) == 0xa00)
 
-#define FPSCR_N	(1 << 31)
-#define FPSCR_Z	(1 << 30)
-#define FPSCR_C (1 << 29)
-#define FPSCR_V	(1 << 28)
+#define FPSCR_N	BIT(31)
+#define FPSCR_Z	BIT(30)
+#define FPSCR_C BIT(29)
+#define FPSCR_V	BIT(28)
 
 /*
  * Since we aren't building with -mfpu=vfp, we need to code
-- 
2.11.0
