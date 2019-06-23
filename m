From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 09/15] ARM: omap2: cleanup cppcheck shifting error
Date: Sun, 23 Jun 2019 22:13:07 +0700
Message-ID: <20190623151313.970-10-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-omap2/powerdomain.c:190]: (error) Shifting signed 32-bit
value by 31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-omap2/powerdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1cbac76136d4..4e2eb39bc698 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -35,7 +35,7 @@
 #include "soc.h"
 #include "pm.h"
 
-#define PWRDM_TRACE_STATES_FLAG	(1<<31)
+#define PWRDM_TRACE_STATES_FLAG	(1U<<31)
 
 void pwrdms_save_context(void);
 void pwrdms_restore_context(void);
-- 
2.11.0
