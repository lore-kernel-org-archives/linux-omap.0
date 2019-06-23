From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 12/15] ARM: vexpress: cleanup cppcheck shifting error
Date: Sun, 23 Jun 2019 22:13:10 +0700
Message-ID: <20190623151313.970-13-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-vexpress/spc.c:366]: (error) Shifting signed 32-bit value
by 31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-vexpress/spc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 0f5381d13494..f8911dae776c 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -57,8 +57,8 @@
 
 /* SPC CPU/cluster reset statue */
 #define STANDBYWFI_STAT		0x3c
-#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	(1 << (cpu))
-#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	(1 << (3 + (cpu)))
+#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	(1U << (cpu))
+#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	(1U << (3 + (cpu)))
 
 /* SPC system config interface registers */
 #define SYSCFG_WDATA		0x70
@@ -69,7 +69,7 @@
 #define A7_PERFVAL_BASE		0xC30
 
 /* Config interface control bits */
-#define SYSCFG_START		(1 << 31)
+#define SYSCFG_START		(1U << 31)
 #define SYSCFG_SCC		(6 << 20)
 #define SYSCFG_STAT		(14 << 20)
 
@@ -90,8 +90,8 @@
 #define CA15_DVFS	0
 #define CA7_DVFS	1
 #define SPC_SYS_CFG	2
-#define STAT_COMPLETE(type)	((1 << 0) << (type << 2))
-#define STAT_ERR(type)		((1 << 1) << (type << 2))
+#define STAT_COMPLETE(type)	((1U << 0) << (type << 2))
+#define STAT_ERR(type)		((1U << 1) << (type << 2))
 #define RESPONSE_MASK(type)	(STAT_COMPLETE(type) | STAT_ERR(type))
 
 struct ve_spc_opp {
@@ -162,7 +162,7 @@ void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set)
 	if (cluster >= MAX_CLUSTERS)
 		return;
 
-	mask = 1 << cpu;
+	mask = 1U << cpu;
 
 	if (!cluster_is_a15(cluster))
 		mask <<= 4;
-- 
2.11.0
