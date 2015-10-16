From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] clocksource: ti-32k: make it depend on GENERIC_CLOCKSOURCE
Date: Fri, 16 Oct 2015 16:10:05 -0500
Message-ID: <1445029805-13736-1-git-send-email-balbi@ti.com>
References: <201510170412.4siQMwFD%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201510170412.4siQMwFD%fengguang.wu@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

the new ti 32k clocksource driver should depend on
GENERIC_CLOCKSOURCE because of its reliance on
sched_clock_register().

Let's enable that to avoid any possible build errors
and/or warnings on randbuilds.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 98b2a9b9bfad..3a1efa3fd88d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -117,6 +117,7 @@ config CLKSRC_PISTACHIO
 
 config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
+	depends on GENERIC_SCHED_CLOCK
 	select CLKSRC_OF if OF
 	help
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
-- 
2.5.3
