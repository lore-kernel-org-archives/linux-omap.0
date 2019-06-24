From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V2 11/15] ARM: pxa: cleanup cppcheck shifting errors
Date: Mon, 24 Jun 2019 20:51:01 +0700
Message-ID: <20190624135105.15579-12-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
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
index 74efc3ab595f..cbbb5cfecb60 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -35,9 +35,9 @@
 #define IPR(i)			(((i) < 32) ? (0x01c + ((i) << 2)) :		\
 				((i) < 64) ? (0x0b0 + (((i) - 32) << 2)) :	\
 				      (0x144 + (((i) - 64) << 2)))
-#define ICHP_VAL_IRQ		(1 << 31)
+#define ICHP_VAL_IRQ		BIT(31)
 #define ICHP_IRQ(i)		(((i) >> 16) & 0x7fff)
-#define IPR_VALID		(1 << 31)
+#define IPR_VALID		BIT(31)
 
 #define MAX_INTERNAL_IRQS	128
 
-- 
2.11.0
