From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 01/15] arm: perf: cleanup cppcheck shifting error
Date: Sun, 23 Jun 2019 22:12:59 +0700
Message-ID: <20190623151313.970-2-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

fix "Shifting signed 32-bit value by 31 bits is undefined behaviour
errors"

[arch/arm/kernel/perf_event_v7.c:1080]: (error) Shifting signed 32-bit
value by 31 bits is undefined behaviour
[arch/arm/kernel/perf_event_v7.c:1436]: (error) Shifting signed 32-bit
value by 31 bits is undefined behaviour
[arch/arm/kernel/perf_event_v7.c:1783]: (error) Shifting signed 32-bit
value by 31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/kernel/perf_event_v7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index a4fb0f8b8f84..83dc472a39b2 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -697,9 +697,9 @@ static struct attribute_group armv7_pmuv2_events_attr_group = {
 /*
  * Event filters for PMUv2
  */
-#define	ARMV7_EXCLUDE_PL1	(1 << 31)
-#define	ARMV7_EXCLUDE_USER	(1 << 30)
-#define	ARMV7_INCLUDE_HYP	(1 << 27)
+#define	ARMV7_EXCLUDE_PL1	(1U << 31)
+#define	ARMV7_EXCLUDE_USER	(1U << 30)
+#define	ARMV7_INCLUDE_HYP	(1U << 27)
 
 /*
  * Secure debug enable reg
-- 
2.11.0
