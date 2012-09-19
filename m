From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] drivers: bus: Move the OMAP interconnect driver to
 drivers/bus/
Date: Wed, 19 Sep 2012 18:57:57 +0000
Message-ID: <201209191857.57862.arnd@arndb.de>
References: <1347614434-15938-1-git-send-email-santosh.shilimkar@ti.com>
 <20120917215128.GF11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120917215128.GF11762@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 17 September 2012, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120914 02:21]:
> > OMAP interconnect drivers are used for the interconnect error handling.
> > Since they are bus driver, lets move it to newly created drivers/bus.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Patch just moves OMAP interconnect drivers as is to the newly created
> > driver/bus/* directory. Patch is generated against "arm-soc/drivers/ocp2scp"
> > tree and test on all OMAP boards.
> 
> Great, looks like this should not conflict with other
> omap patches queued, so Arnd should probably take this into
> the bus branch:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

It turns out that the patch actually did conflict and we now have a broken
omap2plus_defconfig. The patch below seems to fix it, but please verify
that this makes sense.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index f447e02..ab911a3 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -28,7 +28,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
-#include "soc.h"
 #include "omap_l3_noc.h"
 
 /*
@@ -191,7 +190,7 @@ static int __devinit omap4_l3_probe(struct platform_device *pdev)
 			IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						9 + OMAP44XX_IRQ_GIC_START);
+						l3->debug_irq);
 		goto err3;
 	}
 
@@ -201,7 +200,7 @@ static int __devinit omap4_l3_probe(struct platform_device *pdev)
 			IRQF_DISABLED, "l3-app-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						10 + OMAP44XX_IRQ_GIC_START);
+						l3->app_irq);
 		goto err4;
 	}
