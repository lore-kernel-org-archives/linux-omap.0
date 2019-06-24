From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V2 02/15] ARM: davinci: cleanup cppcheck shifting errors
Date: Mon, 24 Jun 2019 20:50:52 +0700
Message-ID: <20190624135105.15579-3-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-davinci/cpuidle.c:41]: (error) Shifting signed 32-bit
value by 31 bits is undefined behaviour
[arch/arm/mach-davinci/cpuidle.c:43]: (error) Shifting signed 32-bit
value by 31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-davinci/ddr2.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/ddr2.h b/arch/arm/mach-davinci/ddr2.h
index 4f7d7824b0c9..f2f56d16d7d5 100644
--- a/arch/arm/mach-davinci/ddr2.h
+++ b/arch/arm/mach-davinci/ddr2.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define DDR2_SDRCR_OFFSET	0xc
-#define DDR2_SRPD_BIT		(1 << 23)
-#define DDR2_MCLKSTOPEN_BIT	(1 << 30)
-#define DDR2_LPMODEN_BIT	(1 << 31)
+#define DDR2_SRPD_BIT		BIT(23)
+#define DDR2_MCLKSTOPEN_BIT	BIT(30)
+#define DDR2_LPMODEN_BIT	BIT(31)
-- 
2.11.0
