From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 4/5] ARM: OMAP: Wakeupgen: AM43xx HS devices should save context like non-HS
Date: Fri, 29 Mar 2019 12:53:35 -0500
Message-ID: <20190329175336.19824-4-afd@ti.com>
References: <20190329175336.19824-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

Unlike some previous generation devices, AM43xx HS IRQ and Wakegen
context is handled by the ROM for us, and no secure service call
is needed or supported. Non-GP AM43xx devices should take the
same path as GP.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 17558be4bf0a..7dcbe1736f7e 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -436,13 +436,13 @@ static int irq_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 {
 	switch (cmd) {
 	case CPU_CLUSTER_PM_ENTER:
-		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		if (omap_type() == OMAP2_DEVICE_TYPE_GP || soc_is_am43xx())
 			irq_save_context();
 		else
 			irq_save_secure_context();
 		break;
 	case CPU_CLUSTER_PM_EXIT:
-		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		if (omap_type() == OMAP2_DEVICE_TYPE_GP || soc_is_am43xx())
 			irq_restore_context();
 		break;
 	}
-- 
2.21.0
