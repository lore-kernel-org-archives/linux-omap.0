From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 11/15] ARM: pxa: cleanup cppcheck shifting errors
Date: Sun, 23 Jun 2019 22:13:09 +0700
Message-ID: <20190623151313.970-12-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-pxa/irq.c:117]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour
[arch/arm/mach-pxa/irq.c:131]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-pxa/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 74efc3ab595f..2e2afe16069c 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -35,9 +35,9 @@
 #define IPR(i)			(((i) < 32) ? (0x01c + ((i) << 2)) :		\
 				((i) < 64) ? (0x0b0 + (((i) - 32) << 2)) :	\
 				      (0x144 + (((i) - 64) << 2)))
-#define ICHP_VAL_IRQ		(1 << 31)
+#define ICHP_VAL_IRQ		(1U << 31)
 #define ICHP_IRQ(i)		(((i) >> 16) & 0x7fff)
-#define IPR_VALID		(1 << 31)
+#define IPR_VALID		(1U << 31)
 
 #define MAX_INTERNAL_IRQS	128
 
-- 
2.11.0
