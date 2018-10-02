From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix impossible .irq < 0
Date: Tue,  2 Oct 2018 11:45:29 +0200
Message-ID: <20181002094529.30564-1-jmkrzyszt@gmail.com>
References: <20181001102453.GA18947@mwanda>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001102453.GA18947@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Since the very beginning, unsigned int .irq member of struct
plat_serial8250_port introduced by commit eff443df679e ("OMAP1:
AMS_DELTA: add modem support") was statically initialized to a negative
value -EINVAL.  Moreover, commit 0812db943748 ("ARM: OMAP1: ams-delta:
assign MODEM IRQ from GPIO descriptor") has introduced some new code
which checks for that member carrying a negative value which is
impossible.

Use IRQ_NOTCONNECTED instead of -EINVAL. Also, drop the valueless check
and let the modem device be registered regardless of .irq value, and
the value handled by "serial8250" driver.

Fixes: 0812db943748 ("ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index af318d958fd2..3d191fd52910 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -773,7 +773,7 @@ static struct plat_serial8250_port ams_delta_modem_ports[] = {
 	{
 		.membase	= IOMEM(MODEM_VIRT),
 		.mapbase	= MODEM_PHYS,
-		.irq		= -EINVAL, /* changed later */
+		.irq		= IRQ_NOTCONNECTED, /* changed later */
 		.flags		= UPF_BOOT_AUTOCONF,
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.iotype		= UPIO_MEM,
@@ -864,8 +864,7 @@ static int __init modem_nreset_init(void)
 
 
 /*
- * This function expects MODEM IRQ number already assigned to the port
- * and fails if it's not.
+ * This function expects MODEM IRQ number already assigned to the port.
  * The MODEM device requires its RESET# pin kept high during probe.
  * That requirement can be fulfilled in several ways:
  * - with a descriptor of already functional modem_nreset regulator
@@ -888,9 +887,6 @@ static int __init ams_delta_modem_init(void)
 	if (!machine_is_ams_delta())
 		return -ENODEV;
 
-	if (ams_delta_modem_ports[0].irq < 0)
-		return ams_delta_modem_ports[0].irq;
-
 	omap_cfg_reg(M14_1510_GPIO2);
 
 	/* Initialize the modem_nreset regulator consumer before use */
-- 
2.16.4
