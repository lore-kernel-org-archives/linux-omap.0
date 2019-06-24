From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V2 12/15] ARM: vexpress: cleanup cppcheck shifting error
Date: Mon, 24 Jun 2019 20:51:02 +0700
Message-ID: <20190624135105.15579-13-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-vexpress/spc.c:366]: (error) Shifting signed 32-bit value
by 31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-vexpress/spc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 0f5381d13494..425ce633667a 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -57,8 +57,8 @@
 
 /* SPC CPU/cluster reset statue */
 #define STANDBYWFI_STAT		0x3c
-#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	(1 << (cpu))
-#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	(1 << (3 + (cpu)))
+#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	BIT((cpu))
+#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	BIT((3 + (cpu)))
 
 /* SPC system config interface registers */
 #define SYSCFG_WDATA		0x70
@@ -69,7 +69,7 @@
 #define A7_PERFVAL_BASE		0xC30
 
 /* Config interface control bits */
-#define SYSCFG_START		(1 << 31)
+#define SYSCFG_START		BIT(31)
 #define SYSCFG_SCC		(6 << 20)
 #define SYSCFG_STAT		(14 << 20)
 
@@ -90,8 +90,8 @@
 #define CA15_DVFS	0
 #define CA7_DVFS	1
 #define SPC_SYS_CFG	2
-#define STAT_COMPLETE(type)	((1 << 0) << (type << 2))
-#define STAT_ERR(type)		((1 << 1) << (type << 2))
+#define STAT_COMPLETE(type)	(BIT(0) << (type << 2))
+#define STAT_ERR(type)		(BIT(1) << (type << 2))
 #define RESPONSE_MASK(type)	(STAT_COMPLETE(type) | STAT_ERR(type))
 
 struct ve_spc_opp {
@@ -162,7 +162,7 @@ void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set)
 	if (cluster >= MAX_CLUSTERS)
 		return;
 
-	mask = 1 << cpu;
+	mask = BIT(cpu);
 
 	if (!cluster_is_a15(cluster))
 		mask <<= 4;
-- 
2.11.0
