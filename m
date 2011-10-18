From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 16/21] OMAP2+: UART: Remove custom activate funcs and use
	generic funcs.
Date: Tue, 18 Oct 2011 21:05:07 +0530
Message-ID: <1318952110-10659-2-git-send-email-govindraj.raja@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Govindraj R <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The custom hwmod activate and deactivate funcs does hwmod_enable
and idle same can be done with omap_device generic API's.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 7c65410..7658a03 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -78,24 +78,10 @@ static struct omap_uart_port_info omap_serial_default_info[] __initdata = {
 	},
 };
 
-static int uart_idle_hwmod(struct omap_device *od)
-{
-	omap_hwmod_idle(od->hwmods[0]);
-
-	return 0;
-}
-
-static int uart_enable_hwmod(struct omap_device *od)
-{
-	omap_hwmod_enable(od->hwmods[0]);
-
-	return 0;
-}
-
 static struct omap_device_pm_latency omap_uart_latency[] = {
 	{
-		.deactivate_func = uart_idle_hwmod,
-		.activate_func	 = uart_enable_hwmod,
+		.activate_func	 = omap_device_enable_hwmods,
+		.deactivate_func = omap_device_idle_hwmods,
 		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
 };
-- 
1.7.4.1
