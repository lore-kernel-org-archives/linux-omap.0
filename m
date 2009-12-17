From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: OMAP4: Add support for McPDM
Date: Thu, 17 Dec 2009 22:28:21 +0200
Message-ID: <20091217202821.GA30379@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D2@dlee01.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D2@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Dec 17, 2009 at 08:40:32PM +0100, ext Candelaria Villareal, Jorge wrote:
>diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
>index 61952aa..b96e9d8 100644
>--- a/sound/soc/omap/Kconfig
>+++ b/sound/soc/omap/Kconfig
>@@ -6,6 +6,9 @@ config SND_OMAP_SOC_MCBSP
>        tristate
>        select OMAP_MCBSP
>
>+config SND_OMAP_SOC_MCPDM
>+       tristate

look at how SND_OMAP_SOC_N810 is done, can't you follow that ? put some 
description ad help ?

>diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
>new file mode 100644
>index 0000000..e162dd1
>--- /dev/null
>+++ b/sound/soc/omap/mcpdm.c
>@@ -0,0 +1,505 @@
>+/*
>+ * mcpdm.c  --  McPDM interface driver
>+ *
>+ * Author: Jorge Eduardo Candelaria <x0107209@ti.com>

no copyright ? How about:

Copyright (C) 2009 - Texas Instruments, Inc.

>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * version 2 as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful, but
>+ * WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+ * General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>+ * 02110-1301 USA
>+ *
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/device.h>
>+#include <linux/platform_device.h>
>+#include <linux/wait.h>
>+#include <linux/interrupt.h>
>+#include <linux/err.h>
>+#include <linux/clk.h>
>+#include <linux/delay.h>
>+#include <linux/io.h>
>+#include <linux/irq.h>
>+
>+#include "mcpdm.h"

is this used by any other file ? If not, it shouldn't be necessary.

>+static struct omap_mcpdm *mcpdm;

allocate on probe() and make it the private_data of the device structure 
with platform_set_drvdata(pdev, mcpdm);

>+static void omap_mcpdm_write(u16 reg, u32 val)

I'd rather:

static inline void omap_mcpdm_write(struct omap_mcpdm *mcpdm,
		u16 reg, u32 val)

>+{
>+       __raw_writel(val, mcpdm->io_base + reg);
>+}
>+
>+static int omap_mcpdm_read(u16 reg)

ditto.

>+{
>+       return __raw_readl(mcpdm->io_base + reg);
>+}
>+
>+void omap_mcpdm_reg_dump(void)
>+{
>+       dev_dbg(mcpdm->dev, "***********************\n");
>+       dev_dbg(mcpdm->dev, "IRQSTATUS_RAW:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_IRQSTATUS_RAW));
>+       dev_dbg(mcpdm->dev, "IRQSTATUS:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_IRQSTATUS));
>+       dev_dbg(mcpdm->dev, "IRQENABLE_SET:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_IRQENABLE_SET));
>+       dev_dbg(mcpdm->dev, "IRQENABLE_CLR:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_IRQENABLE_CLR));
>+       dev_dbg(mcpdm->dev, "IRQWAKE_EN: 0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_IRQWAKE_EN));
>+       dev_dbg(mcpdm->dev, "DMAENABLE_SET: 0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_DMAENABLE_SET));
>+       dev_dbg(mcpdm->dev, "DMAENABLE_CLR:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_DMAENABLE_CLR));
>+       dev_dbg(mcpdm->dev, "DMAWAKEEN:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_DMAWAKEEN));
>+       dev_dbg(mcpdm->dev, "CTRL:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_CTRL));
>+       dev_dbg(mcpdm->dev, "DN_DATA:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_DN_DATA));
>+       dev_dbg(mcpdm->dev, "UP_DATA: 0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_UP_DATA));
>+       dev_dbg(mcpdm->dev, "FIFO_CTRL_DN: 0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_FIFO_CTRL_DN));
>+       dev_dbg(mcpdm->dev, "FIFO_CTRL_UP:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_FIFO_CTRL_UP));
>+       dev_dbg(mcpdm->dev, "DN_OFFSET:  0x%04x\n",
>+                       omap_mcpdm_read(MCPDM_DN_OFFSET));
>+       dev_dbg(mcpdm->dev, "***********************\n");
>+}
>+EXPORT_SYMBOL(omap_mcpdm_reg_dump);

I'd rather use debugfs for such stuff.

>+EXPORT_SYMBOL(omap_mcpdm_set_offset);
>+EXPORT_SYMBOL(omap_mcpdm_reset);
>+EXPORT_SYMBOL(omap_mcpdm_start);
>+EXPORT_SYMBOL(omap_mcpdm_stop);
>+EXPORT_SYMBOL(omap_mcpdm_set_uplink);
>+EXPORT_SYMBOL(omap_mcpdm_set_downlink);
>+EXPORT_SYMBOL(omap_mcpdm_clr_uplink);
>+EXPORT_SYMBOL(omap_mcpdm_clr_downlink);
>+EXPORT_SYMBOL(omap_mcpdm_request);
>+EXPORT_SYMBOL(omap_mcpdm_free);

way too many exported symbols, no ? Doesn't ALSA API have proper place 
for this kind of stuff ? I'd need ALSA experts to reply to that but it 
does smell funny...

>+static irqreturn_t omap_mcpdm_irq_handler(int irq, void *dev_id)
>+{
>+       struct omap_mcpdm *mcpdm_irq = dev_id;
>+       int irq_status;
>+
>+       irq_status = omap_mcpdm_read(MCPDM_IRQSTATUS);
>+
>+       /* Acknowledge irq event */
>+       omap_mcpdm_write(MCPDM_IRQSTATUS, irq_status);
>+
>+       switch (irq_status) {

it's better if you:

	if (irq_status & DN_IRQ_FULL) {
		...
	}

	if (irq_status & DN_IRQ_EMPTY) {
		...
	}

	if (irq_status & DN_IRQ) {
		...
	}

>+int omap_mcpdm_request(void)
>+{
>+       int ret;
>+
>+       clk_enable(mcpdm->clk);
>+
>+       spin_lock(&mcpdm->lock);
>+
>+       if (!mcpdm->free) {
>+               dev_err(mcpdm->dev, "McPDM interface is in use\n");
>+               spin_unlock(&mcpdm->lock);
>+               return -EBUSY;
>+       }
>+       mcpdm->free = 0;
>+
>+       spin_unlock(&mcpdm->lock);
>+
>+       /* Disable lines while request is ongoing */
>+       omap_mcpdm_write(MCPDM_CTRL, 0x00);
>+
>+       ret = request_irq(mcpdm->irq, omap_mcpdm_irq_handler,
>+                               0, "McPDM", (void *)mcpdm);
>+       if (ret) {
>+               dev_err(mcpdm->dev, "Request for McPDM IRQ failed\n");
>+               return ret;
>+       }
>+
>+       return 0;
>+}
>+EXPORT_SYMBOL(omap_mcpdm_request);

How about moving this to probe() ??

>+void omap_mcpdm_free(void)
>+{
>+       clk_disable(mcpdm->clk);
>+
>+       spin_lock(&mcpdm->lock);
>+       if (mcpdm->free) {
>+               dev_err(mcpdm->dev, "McPDM interface is already free\n");
>+               spin_unlock(&mcpdm->lock);
>+               return;
>+       }
>+       mcpdm->free = 1;
>+       spin_unlock(&mcpdm->lock);
>+
>+       free_irq(mcpdm->irq, (void *)mcpdm);
>+}
>+EXPORT_SYMBOL(omap_mcpdm_free);

move to remove()

>+static int __devinit omap_mcpdm_probe(struct platform_device *pdev)
>+{
>+       struct omap_mcpdm_platform_data *pdata = pdev->dev.platform_data;
>+       int ret = 0;
>+
>+       if (!pdata) {
>+               dev_err(&pdev->dev, "McPDM device initialized without "
>+                                       "platform data\n");

try not to break the string, it makes grep much more difficult. You can 
also make a smaller string like: "no platform data"  or something...

>+               ret = -EINVAL;
>+               goto exit;
>+       }
>+       dev_dbg(&pdev->dev, "Initializing OMAP McPDM driver \n");

not needed this message.

>+       mcpdm = kzalloc(sizeof(struct omap_mcpdm), GFP_KERNEL);
>+       if (!mcpdm) {
>+               ret = -ENOMEM;
>+               goto exit;
>+       }
>+
>+       spin_lock_init(&mcpdm->lock);
>+       mcpdm->free = 1;
>+       mcpdm->phys_base = pdata->phys_base;

this is passed via struct resource.

>+       mcpdm->io_base = ioremap(mcpdm->phys_base, SZ_4K);

then this would be something like:

static int __devinit omap_mcpdm_probe(struct platform_device *pdev)
{
	...
	struct resource		*res;
	...

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (res == NULL) {
		dev_err(&pdev->dev, "no resource\n");
		goto err1;
	}

	mcpdm->io_base = ioremap(res->start, resource_size(res));
	if (mcpdm->io_base == NULL) {
		dev_err(&pdev->dev, "ioremap failed\n");
		goto err2;
	}

	...

>+       if (!mcpdm->io_base) {
>+               ret = -ENOMEM;
>+               goto err_ioremap;
>+       }
>+
>+       mcpdm->irq = pdata->irq;
>+
>+       /* FIXME: Enable this ones correct clk nodes available */
>+       if (!cpu_is_omap44xx()) {

if you don't use the code now, don't add it.

>+               mcpdm->clk = clk_get(&pdev->dev, "fclk");
>+               if (IS_ERR(mcpdm->clk)) {
>+                       ret = PTR_ERR(mcpdm->clk);
>+                       dev_err(&pdev->dev, "unable to get fclk: %d\n", ret);
>+                       goto err_clk;
>+               }
>+       }
>+
>+       mcpdm->pdata = pdata;

pdata is supposed to be __initdata, no point in saving it.

>+       mcpdm->dev = &pdev->dev;
>+       platform_set_drvdata(pdev, mcpdm);
>+
>+       return 0;
>+
>+err_clk:
>+       iounmap(mcpdm->io_base);
>+err_ioremap:
>+       kfree(mcpdm);
>+exit:
>+       return ret;
>+}
>+
>+static int __devexit omap_mcpdm_remove(struct platform_device *pdev)
>+{
>+       struct omap_mcpdm *mcpdm_ptr = platform_get_drvdata(pdev);
>+
>+       platform_set_drvdata(pdev, NULL);
>+
>+       if (mcpdm_ptr) {

if this pointer is NULL, the you deserve to oops, get rid of the branch.

>+               clk_disable(mcpdm_ptr->clk);
>+               clk_put(mcpdm_ptr->clk);
>+
>+               iounmap(mcpdm_ptr->io_base);
>+
>+               mcpdm_ptr->clk = NULL;
>+               mcpdm_ptr->free = 0;
>+               mcpdm_ptr->dev = NULL;

where's your kfree(mcpdm_ptr) ???

>+       printk(KERN_INFO "McPDM driver removed \n");

get rid of this.

>+static struct platform_driver omap_mcpdm_driver = {
>+       .probe = omap_mcpdm_probe,
>+       .remove = omap_mcpdm_remove,

	.remove = __devexit_p(omap_mcpdm_remove),

>+       .driver = {
>+               .name = "omap-mcpdm",
>+       },
>+};
>+
>+static struct platform_device *omap_mcpdm_device;
>+
>+static struct omap_mcpdm_platform_data mcpdm_pdata = {
>+       .phys_base = OMAP44XX_MCPDM_BASE,
>+       .irq = INT_44XX_MCPDM_IRQ,
>+};

this should be passed by arch code, no ??

>+static int __init omap_mcpdm_init(void)
>+{
>+       int ret;
>+       struct platform_device *device;
>+
>+       device = platform_device_alloc("omap-mcpdm", -1);
>+       if (!device) {
>+               printk(KERN_ERR "McPDM platform device allocation failed\n");
>+               return -ENOMEM;
>+       }
>+       device->dev.platform_data = &mcpdm_pdata;

although n810 does the same, I don't like it. I think the board file 
should register the platform_device

>+       omap_mcpdm_device = device;
>+       (void) platform_device_add(omap_mcpdm_device);

what ? so even if you don't have a platform_device you register the 
driver ??

>+       ret = platform_driver_register(&omap_mcpdm_driver);
>+       if (ret)
>+               goto error;
>+       return 0;
>+
>+error:
>+       printk(KERN_ERR "OMAP McPDM initialization error\n");

no printk(), simply return err.

>+       return ret;
>+}
>+arch_initcall(omap_mcpdm_init);

I wonder if arch_initcall() is really necessary...

>diff --git a/sound/soc/omap/mcpdm.h b/sound/soc/omap/mcpdm.h
>new file mode 100644
>index 0000000..c953e95
>--- /dev/null
>+++ b/sound/soc/omap/mcpdm.h
>@@ -0,0 +1,156 @@
>+/*
>+ * mcpdm.h -- Defines for McPDM driver
>+ *
>+ * Author: Jorge Eduardo Candelaria <x0107209@ti.com>
>+ *
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * version 2 as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful, but
>+ * WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+ * General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>+ * 02110-1301 USA
>+ *
>+ */
>+
>+#define OMAP44XX_MCPDM_BASE    0x40132000
>+#define OMAP44XX_MCPDM_L3_BASE 0x49032000

not here... probably in some <plat/cpu.h> or similar...

>+/* McPDM registers */
>+
>+#define MCPDM_REVISION         0x00
>+#define MCPDM_SYSCONFIG                0x10
>+#define MCPDM_IRQSTATUS_RAW    0x24
>+#define MCPDM_IRQSTATUS                0x28
>+#define MCPDM_IRQENABLE_SET    0x2C
>+#define MCPDM_IRQENABLE_CLR    0x30
>+#define MCPDM_IRQWAKE_EN       0x34
>+#define MCPDM_DMAENABLE_SET    0x38
>+#define MCPDM_DMAENABLE_CLR    0x3C
>+#define MCPDM_DMAWAKEEN                0x40
>+#define MCPDM_CTRL             0x44
>+#define MCPDM_DN_DATA          0x48
>+#define MCPDM_UP_DATA          0x4C
>+#define MCPDM_FIFO_CTRL_DN     0x50
>+#define MCPDM_FIFO_CTRL_UP     0x54
>+#define MCPDM_DN_OFFSET                0x58
>+
>+/*
>+ * MCPDM_IRQ bit fields
>+ * IRQSTATUS_RAW, IRQSTATUS, IRQENABLE_SET, IRQENABLE_CLR
>+ */
>+
>+#define DN_IRQ                 (1 << 0)
>+#define DN_IRQ_EMTPY           (1 << 1)
>+#define DN_IRQ_ALMST_EMPTY     (1 << 2)
>+#define DN_IRQ_FULL            (1 << 3)
>
>+#define UP_IRQ                 (1 << 8)
>+#define UP_IRQ_EMPTY           (1 << 9)
>+#define UP_IRQ_ALMST_FULL      (1 << 10)
>+#define UP_IRQ_FULL            (1 << 11)
>+
>+#define DOWNLINK_IRQ_MASK      0x00F
>+#define UPLINK_IRQ_MASK                0xF00

prepend with MCPDM_

>+void omap_mcpdm_reg_dump(void);
>+void omap_mcpdm_reset(int links, int reset);
>+void omap_mcpdm_start(int stream);
>+void omap_mcpdm_stop(int stream);
>+int omap_mcpdm_set_uplink(struct omap_mcpdm_link *uplink);
>+int omap_mcpdm_set_downlink(struct omap_mcpdm_link *downlink);
>+int omap_mcpdm_clr_uplink(struct omap_mcpdm_link *uplink);
>+int omap_mcpdm_clr_downlink(struct omap_mcpdm_link *downlink);
>+int omap_mcpdm_request(void);
>+void omap_mcpdm_free(void);
>+int omap_mcpdm_set_offset(int offset1, int offset2);

these shouldn't be necessary but at least the extern is missing.

-- 
balbi
