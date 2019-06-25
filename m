From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V3 12/15] ARM: vexpress: cleanup cppcheck shifting error
Date: Tue, 25 Jun 2019 11:03:53 +0700
Message-ID: <20190625040356.27473-13-tranmanphong@gmail.com>
References: <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190625040356.27473-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625040356.27473-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

There is error from cppcheck tool
"Shifting signed 32-bit value by 31 bits is undefined behaviour errors"
change to use BIT() marco for improvement.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-vexpress/spc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 0f5381d13494..354e0e7025ae 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -69,7 +69,7 @@
 #define A7_PERFVAL_BASE		0xC30
 
 /* Config interface control bits */
-#define SYSCFG_START		(1 << 31)
+#define SYSCFG_START		BIT(31)
 #define SYSCFG_SCC		(6 << 20)
 #define SYSCFG_STAT		(14 << 20)
 
@@ -162,7 +162,7 @@ void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set)
 	if (cluster >= MAX_CLUSTERS)
 		return;
 
-	mask = 1 << cpu;
+	mask = BIT(cpu);
 
 	if (!cluster_is_a15(cluster))
 		mask <<= 4;
-- 
2.11.0
