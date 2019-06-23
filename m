From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 02/15] ARM: davinci: cleanup cppcheck shifting errors
Date: Sun, 23 Jun 2019 22:13:00 +0700
Message-ID: <20190623151313.970-3-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
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
index 4f7d7824b0c9..76d78ffe2702 100644
--- a/arch/arm/mach-davinci/ddr2.h
+++ b/arch/arm/mach-davinci/ddr2.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define DDR2_SDRCR_OFFSET	0xc
-#define DDR2_SRPD_BIT		(1 << 23)
-#define DDR2_MCLKSTOPEN_BIT	(1 << 30)
-#define DDR2_LPMODEN_BIT	(1 << 31)
+#define DDR2_SRPD_BIT		(1U << 23)
+#define DDR2_MCLKSTOPEN_BIT	(1U << 30)
+#define DDR2_LPMODEN_BIT	(1U << 31)
-- 
2.11.0
