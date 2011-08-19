From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=203/4=5D=20usb=3A=20Introduce=20DesignWare=20USB3=20DRD=20Driver?=
Date: Fri, 19 Aug 2011 18:10:58 +0300
Message-ID: <1313766659-28360-4-git-send-email-balbi@ti.com>
References: <1313766659-28360-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1313766659-28360-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The DesignWare USB3 is a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

Several other parameters can be configured
like amount of FIFO space, amount of TX and
RX endpoints, amount of Host Interrupters,
etc.

The current driver has been validated with
a virtual model of version 1.73a of that core
and with an FPGA burned with version 1.83a
of the DRD core. We have support for PCIe
bus, which is used on FPGA prototyping, and
for the OMAP5, more adaptation (or glue)
layers can be easily added and the driver
is half prepared to handle any possible
configuration the HW engineer has chosen
considering we have the information on
one of the GHWPARAMS registers to do
runtime checking of certain features.

More runtime checks can, and should, be added
in order to make this driver even more flexible
with regards to number of endpoints, FIFO sizes,
transfer types, etc.

While this supports only the device side, for
now, we will add support for Host side (xHCI -
see the updated series Sebastian has sent [1])
and OTG after we have it all stabilized.

[1] http://marc.info/?l=3Dlinux-usb&m=3D131341992020339&w=3D2

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 Documentation/usb/dwc3.txt   |   53 ++
 drivers/usb/Kconfig          |    2 +
 drivers/usb/Makefile         |    2 +
 drivers/usb/dwc3/Kconfig     |   25 +
 drivers/usb/dwc3/Makefile    |   36 +
 drivers/usb/dwc3/core.c      |  467 ++++++++++
 drivers/usb/dwc3/core.h      |  709 +++++++++++++++
 drivers/usb/dwc3/debug.h     |   51 +
 drivers/usb/dwc3/debugfs.c   |  534 +++++++++++
 drivers/usb/dwc3/dwc3-omap.c |  410 +++++++++
 drivers/usb/dwc3/dwc3-pci.c  |  219 +++++
 drivers/usb/dwc3/ep0.c       |  782 ++++++++++++++++
 drivers/usb/dwc3/gadget.c    | 2063 ++++++++++++++++++++++++++++++++++=
++++++++
 drivers/usb/dwc3/gadget.h    |  292 ++++++
 drivers/usb/dwc3/io.h        |   55 ++
 drivers/usb/gadget/Kconfig   |   12 +
 16 files changed, 5712 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/usb/dwc3.txt
 create mode 100644 drivers/usb/dwc3/Kconfig
 create mode 100644 drivers/usb/dwc3/Makefile
 create mode 100644 drivers/usb/dwc3/core.c
 create mode 100644 drivers/usb/dwc3/core.h
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/debugfs.c
 create mode 100644 drivers/usb/dwc3/dwc3-omap.c
 create mode 100644 drivers/usb/dwc3/dwc3-pci.c
 create mode 100644 drivers/usb/dwc3/ep0.c
 create mode 100644 drivers/usb/dwc3/gadget.c
 create mode 100644 drivers/usb/dwc3/gadget.h
 create mode 100644 drivers/usb/dwc3/io.h

diff --git a/Documentation/usb/dwc3.txt b/Documentation/usb/dwc3.txt
new file mode 100644
index 0000000..2f65853
--- /dev/null
+++ b/Documentation/usb/dwc3.txt
@@ -0,0 +1,53 @@
+
+ TODO
+~~~~~~
+Please pick something while reading :)
+
+- Implement streaming support for BULK endpoints
+  Tatyana's patch "usb: Add streams support to the gadget framework"
+  introduces streaming support for the gadget driver.
+  Every usb_request has new field called stream_id which holds its id.
+  Every usb_ep has a field num_supported_strms which describes the max
+  number of streams supported (for this ep).
+  UAS is AFAIK the only gadget with streaming support.
+
+- Convert interrupt handler to per-ep-thread-irq
+
+  As it turns out some DWC3-commands ~1ms to complete. Currently we sp=
in
+  until the command completes which is bad.
+
+  Implementation idea:
+  - dwc core implements a demultiplexing irq chip for interrupts per
+    endpoint. The interrupt numbers are allocated during probe and bel=
ong
+    to the device. If MSI provides per-endpoint interrupt this dummy
+    interrupt chip can be replaced with "real" interrupts.
+  - interrupts are requested / allocated on usb_ep_enable() and remove=
d on
+    usb_ep_disable(). Worst case are 32 interrupts, the lower limit is=
 two
+    for ep0/1.
+  - dwc3_send_gadget_ep_cmd() will sleep in wait_for_completion_timeou=
t()
+    until the command completes.
+  - the interrupt handler is split into the following pieces:
+    - primary handler of the device
+      goes through every event and calls generic_handle_irq() for even=
t
+      it. On return from generic_handle_irq() in acknowledges the even=
t
+      counter so interrupt goes away (eventually).
+
+    - threaded handler of the device
+      none
+
+    - primary handler of the EP-interrupt
+      reads the event and tries to process it. Everything that requrie=
s
+      sleeping is handed over to the Thread. The event is saved in an
+      per-endpoint data-structure.
+      We probably have to pay attention not to process events once we
+      handed something to thread so we don't process event X prio Y
+      where X > Y.
+
+    - threaded handler of the EP-interrupt
+      handles the remaining EP work which might sleep such as waiting
+      for command completion.
+
+  Latency:
+   There should be no increase in latency since the interrupt-thread h=
as a
+   high priority and will be run before an average task in user land
+   (except the user changed priorities).
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 48f1781..288b570 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -110,6 +110,8 @@ config USB
=20
 source "drivers/usb/core/Kconfig"
=20
+source "drivers/usb/dwc3/Kconfig"
+
 source "drivers/usb/mon/Kconfig"
=20
 source "drivers/usb/wusbcore/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 30ddf8d..969b0a5 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -6,6 +6,8 @@
=20
 obj-$(CONFIG_USB)		+=3D core/
=20
+obj-$(CONFIG_USB_DWC3)		+=3D dwc3/
+
 obj-$(CONFIG_USB_MON)		+=3D mon/
=20
 obj-$(CONFIG_PCI)		+=3D host/
diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
new file mode 100644
index 0000000..3c1d67d
--- /dev/null
+++ b/drivers/usb/dwc3/Kconfig
@@ -0,0 +1,25 @@
+config USB_DWC3
+	tristate "DesignWare USB3 DRD Core Support"
+	depends on (USB || USB_GADGET)
+	select USB_OTG_UTILS
+	help
+	  Say Y or M here if your system has a Dual Role SuperSpeed
+	  USB controller based on the DesignWare USB3 IP Core.
+
+	  If you choose to build this driver is a dynamically linked
+	  module, the module will be called dwc3.ko.
+
+if USB_DWC3
+
+config USB_DWC3_DEBUG
+	bool "Enable Debugging Messages"
+	help
+	  Say Y here to enable debugging messages on DWC3 Driver.
+
+config USB_DWC3_VERBOSE
+	bool "Enable Verbose Debugging Messages"
+	depends on USB_DWC3_DEBUG
+	help
+	  Say Y here to enable verbose debugging messages on DWC3 Driver.
+
+endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
new file mode 100644
index 0000000..593d1db
--- /dev/null
+++ b/drivers/usb/dwc3/Makefile
@@ -0,0 +1,36 @@
+ccflags-$(CONFIG_USB_DWC3_DEBUG)	:=3D -DDEBUG
+ccflags-$(CONFIG_USB_DWC3_VERBOSE)	+=3D -DVERBOSE_DEBUG
+
+obj-$(CONFIG_USB_DWC3)			+=3D dwc3.o
+
+dwc3-y					:=3D core.o
+
+ifneq ($(CONFIG_USB_GADGET_DWC3),)
+	dwc3-y				+=3D gadget.o ep0.o
+endif
+
+ifneq ($(CONFIG_DEBUG_FS),)
+	dwc3-y				+=3D debugfs.o
+endif
+
+##
+# Platform-specific glue layers go here
+#
+# NOTICE: Make sure your glue layer doesn't depend on anything
+# which is arch-specific and that it compiles on all situations.
+#
+# We want to keep this requirement in order to be able to compile
+# the entire driver (with all its glue layers) on several architecture=
s
+# and make sure it compiles fine. This will also help with allmodconfi=
g
+# and allyesconfig builds.
+#
+# The only exception is the PCI glue layer, but that's only because
+# PCI doesn't provide nops if CONFIG_PCI isn't enabled.
+##
+
+obj-$(CONFIG_USB_DWC3)		+=3D dwc3-omap.o
+
+ifneq ($(CONFIG_PCI),)
+	obj-$(CONFIG_USB_DWC3)		+=3D dwc3-pci.o
+endif
+
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
new file mode 100644
index 0000000..443e4fb
--- /dev/null
+++ b/drivers/usb/dwc3/core.c
@@ -0,0 +1,467 @@
+/**
+ * core.c - DesignWare USB3 DRD Controller Core file
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+
+#include "core.h"
+#include "gadget.h"
+#include "io.h"
+
+#include "debug.h"
+
+/**
+ * dwc3_core_soft_reset - Issues core soft reset and PHY reset
+ * @dwc: pointer to our context structure
+ */
+static void dwc3_core_soft_reset(struct dwc3 *dwc)
+{
+	u32		reg;
+
+	/* Before Resetting PHY, put Core in Reset */
+	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg |=3D DWC3_GCTL_CORESOFTRESET;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	/* Assert USB3 PHY reset */
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg |=3D DWC3_GUSB3PIPECTL_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
+	/* Assert USB2 PHY reset */
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	reg |=3D DWC3_GUSB2PHYCFG_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+	mdelay(100);
+
+	/* Clear USB3 PHY reset */
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg &=3D ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
+	/* Clear USB2 PHY reset */
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	reg &=3D ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+	/* After PHYs are stable we can take Core out of reset state */
+	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &=3D ~DWC3_GCTL_CORESOFTRESET;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
+/**
+ * dwc3_free_one_event_buffer - Frees one event buffer
+ * @dwc: Pointer to our controller context structure
+ * @evt: Pointer to event buffer to be freed
+ */
+static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
+		struct dwc3_event_buffer *evt)
+{
+	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
+	kfree(evt);
+}
+
+/**
+ * dwc3_alloc_one_event_buffer - Allocated one event buffer structure
+ * @dwc: Pointer to our controller context structure
+ * @length: size of the event buffer
+ *
+ * Returns a pointer to the allocated event buffer structure on succes
+ * otherwise ERR_PTR(errno).
+ */
+static struct dwc3_event_buffer *__devinit
+dwc3_alloc_one_event_buffer(struct dwc3 *dwc, unsigned length)
+{
+	struct dwc3_event_buffer	*evt;
+
+	evt =3D kzalloc(sizeof(*evt), GFP_KERNEL);
+	if (!evt)
+		return ERR_PTR(-ENOMEM);
+
+	evt->dwc	=3D dwc;
+	evt->length	=3D length;
+	evt->buf	=3D dma_alloc_coherent(dwc->dev, length,
+			&evt->dma, GFP_KERNEL);
+	if (!evt->buf) {
+		kfree(evt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return evt;
+}
+
+/**
+ * dwc3_free_event_buffers - frees all allocated event buffers
+ * @dwc: Pointer to our controller context structure
+ */
+static void dwc3_free_event_buffers(struct dwc3 *dwc)
+{
+	struct dwc3_event_buffer	*evt;
+	int i;
+
+	for (i =3D 0; i < DWC3_EVENT_BUFFERS_NUM; i++) {
+		evt =3D dwc->ev_buffs[i];
+		if (evt) {
+			dwc3_free_one_event_buffer(dwc, evt);
+			dwc->ev_buffs[i] =3D NULL;
+		}
+	}
+}
+
+/**
+ * dwc3_alloc_event_buffers - Allocates @num event buffers of size @le=
ngth
+ * @dwc: Pointer to out controller context structure
+ * @num: number of event buffers to allocate
+ * @length: size of event buffer
+ *
+ * Returns 0 on success otherwise negative errno. In error the case, d=
wc
+ * may contain some buffers allocated but not all which were requested=
=2E
+ */
+static int __devinit dwc3_alloc_event_buffers(struct dwc3 *dwc, unsign=
ed num,
+		unsigned length)
+{
+	int			i;
+
+	for (i =3D 0; i < num; i++) {
+		struct dwc3_event_buffer	*evt;
+
+		evt =3D dwc3_alloc_one_event_buffer(dwc, length);
+		if (IS_ERR(evt)) {
+			dev_err(dwc->dev, "can't allocate event buffer\n");
+			return PTR_ERR(evt);
+		}
+		dwc->ev_buffs[i] =3D evt;
+	}
+
+	return 0;
+}
+
+/**
+ * dwc3_event_buffers_setup - setup our allocated event buffers
+ * @dwc: Pointer to out controller context structure
+ *
+ * Returns 0 on success otherwise negative errno.
+ */
+static int __devinit dwc3_event_buffers_setup(struct dwc3 *dwc)
+{
+	struct dwc3_event_buffer	*evt;
+	int				n;
+
+	for (n =3D 0; n < DWC3_EVENT_BUFFERS_NUM; n++) {
+		evt =3D dwc->ev_buffs[n];
+		dev_dbg(dwc->dev, "Event buf %p dma %08llx length %d\n",
+				evt->buf, (unsigned long long) evt->dma,
+				evt->length);
+
+		dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(n),
+				lower_32_bits(evt->dma));
+		dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(n),
+				upper_32_bits(evt->dma));
+		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(n),
+				evt->length & 0xffff);
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(n), 0);
+	}
+
+	return 0;
+}
+
+static void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
+{
+	struct dwc3_event_buffer	*evt;
+	int				n;
+
+	for (n =3D 0; n < DWC3_EVENT_BUFFERS_NUM; n++) {
+		evt =3D dwc->ev_buffs[n];
+		dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(n), 0);
+		dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(n), 0);
+		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(n), 0);
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(n), 0);
+	}
+}
+
+/**
+ * dwc3_core_init - Low-level initialization of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success otherwise negative errno.
+ */
+static int __devinit dwc3_core_init(struct dwc3 *dwc)
+{
+	unsigned long		timeout;
+	u32			reg;
+	int			ret;
+
+	dwc3_core_soft_reset(dwc);
+
+	/* issue device SoftReset too */
+	timeout =3D jiffies + msecs_to_jiffies(500);
+	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
+	do {
+		reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			break;
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dwc->dev, "Reset Timed Out\n");
+			ret =3D -ETIMEDOUT;
+			goto err0;
+		}
+
+		cpu_relax();
+	} while (true);
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GSNPSID);
+	/* This should read as U3 followed by revision number */
+	if ((reg & DWC3_GSNPSID_MASK) !=3D 0x55330000) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		ret =3D -ENODEV;
+		goto err0;
+	}
+
+	dwc->revision =3D reg & DWC3_GSNPSREV_MASK;
+
+	ret =3D dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_NUM,
+			DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		ret =3D -ENOMEM;
+		goto err1;
+	}
+
+	ret =3D dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto err1;
+	}
+
+	return 0;
+
+err1:
+	dwc3_free_event_buffers(dwc);
+
+err0:
+	return ret;
+}
+
+static void dwc3_core_exit(struct dwc3 *dwc)
+{
+	dwc3_event_buffers_cleanup(dwc);
+	dwc3_free_event_buffers(dwc);
+}
+
+#define DWC3_ALIGN_MASK		(16 - 1)
+
+static int __devinit dwc3_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id =3D platform_get_device_id(pdev);
+	struct resource		*res;
+	struct dwc3		*dwc;
+	void __iomem		*regs;
+	unsigned int		features =3D id->driver_data;
+	int			ret =3D -ENOMEM;
+	int			irq;
+	void			*mem;
+
+	mem =3D kzalloc(sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
+	if (!mem) {
+		dev_err(&pdev->dev, "not enough memory\n");
+		goto err0;
+	}
+	dwc =3D PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
+	dwc->mem =3D mem;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing resource\n");
+		goto err1;
+	}
+
+	res =3D request_mem_region(res->start, resource_size(res),
+			dev_name(&pdev->dev));
+	if (!res) {
+		dev_err(&pdev->dev, "can't request mem region\n");
+		goto err1;
+	}
+
+	regs =3D ioremap(res->start, resource_size(res));
+	if (!regs) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		goto err2;
+	}
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "missing IRQ\n");
+		goto err3;
+	}
+
+	spin_lock_init(&dwc->lock);
+	platform_set_drvdata(pdev, dwc);
+
+	dwc->regs	=3D regs;
+	dwc->regs_size	=3D resource_size(res);
+	dwc->dev	=3D &pdev->dev;
+	dwc->irq	=3D irq;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_forbid(&pdev->dev);
+
+	ret =3D dwc3_core_init(dwc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize core\n");
+		goto err3;
+	}
+
+	if (features & DWC3_HAS_PERIPHERAL) {
+		ret =3D dwc3_gadget_init(dwc);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to initialized gadget\n");
+			goto err4;
+		}
+	}
+
+	ret =3D dwc3_debugfs_init(dwc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize debugfs\n");
+		goto err5;
+	}
+
+	pm_runtime_allow(&pdev->dev);
+
+	return 0;
+
+err5:
+	if (features & DWC3_HAS_PERIPHERAL)
+		dwc3_gadget_exit(dwc);
+
+err4:
+	dwc3_core_exit(dwc);
+
+err3:
+	iounmap(regs);
+
+err2:
+	release_mem_region(res->start, resource_size(res));
+
+err1:
+	kfree(dwc->mem);
+
+err0:
+	return ret;
+}
+
+static int __devexit dwc3_remove(struct platform_device *pdev)
+{
+	const struct platform_device_id *id =3D platform_get_device_id(pdev);
+	struct dwc3	*dwc =3D platform_get_drvdata(pdev);
+	struct resource	*res;
+	unsigned int	features =3D id->driver_data;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	dwc3_debugfs_exit(dwc);
+
+	if (features & DWC3_HAS_PERIPHERAL)
+		dwc3_gadget_exit(dwc);
+
+	dwc3_core_exit(dwc);
+	release_mem_region(res->start, resource_size(res));
+	iounmap(dwc->regs);
+	kfree(dwc->mem);
+
+	return 0;
+}
+
+static const struct platform_device_id dwc3_id_table[] __devinitconst =
=3D {
+	{
+		.name	=3D "dwc3-omap",
+		.driver_data =3D (DWC3_HAS_PERIPHERAL
+			| DWC3_HAS_XHCI
+			| DWC3_HAS_OTG),
+	},
+	{
+		.name	=3D "dwc3-pci",
+		.driver_data =3D DWC3_HAS_PERIPHERAL,
+	},
+	{  },	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(platform, dwc3_id_table);
+
+static struct platform_driver dwc3_driver =3D {
+	.probe		=3D dwc3_probe,
+	.remove		=3D __devexit_p(dwc3_remove),
+	.driver		=3D {
+		.name	=3D "dwc3",
+	},
+	.id_table	=3D dwc3_id_table,
+};
+
+MODULE_AUTHOR("Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
+
+static int __devinit dwc3_init(void)
+{
+	return platform_driver_register(&dwc3_driver);
+}
+module_init(dwc3_init);
+
+static void __exit dwc3_exit(void)
+{
+	platform_driver_unregister(&dwc3_driver);
+}
+module_exit(dwc3_exit);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
new file mode 100644
index 0000000..83b2960
--- /dev/null
+++ b/drivers/usb/dwc3/core.h
@@ -0,0 +1,709 @@
+/**
+ * core.h - DesignWare USB3 DRD Core Header
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __DRIVERS_USB_DWC3_CORE_H
+#define __DRIVERS_USB_DWC3_CORE_H
+
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/debugfs.h>
+
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+
+/* Global constants */
+#define DWC3_ENDPOINTS_NUM	32
+
+#define DWC3_EVENT_BUFFERS_NUM	2
+#define DWC3_EVENT_BUFFERS_SIZE	PAGE_SIZE
+#define DWC3_EVENT_TYPE_MASK	0xfe
+
+#define DWC3_EVENT_TYPE_DEV	0
+#define DWC3_EVENT_TYPE_CARKIT	3
+#define DWC3_EVENT_TYPE_I2C	4
+
+#define DWC3_DEVICE_EVENT_DISCONNECT		0
+#define DWC3_DEVICE_EVENT_RESET			1
+#define DWC3_DEVICE_EVENT_CONNECT_DONE		2
+#define DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE	3
+#define DWC3_DEVICE_EVENT_WAKEUP		4
+#define DWC3_DEVICE_EVENT_EOPF			6
+#define DWC3_DEVICE_EVENT_SOF			7
+#define DWC3_DEVICE_EVENT_ERRATIC_ERROR		9
+#define DWC3_DEVICE_EVENT_CMD_CMPL		10
+#define DWC3_DEVICE_EVENT_OVERFLOW		11
+
+#define DWC3_GEVNTCOUNT_MASK	0xfffc
+#define DWC3_GSNPSID_MASK	0xffff0000
+#define DWC3_GSNPSREV_MASK	0xffff
+
+/* Global Registers */
+#define DWC3_GSBUSCFG0		0xc100
+#define DWC3_GSBUSCFG1		0xc104
+#define DWC3_GTXTHRCFG		0xc108
+#define DWC3_GRXTHRCFG		0xc10c
+#define DWC3_GCTL		0xc110
+#define DWC3_GEVTEN		0xc114
+#define DWC3_GSTS		0xc118
+#define DWC3_GSNPSID		0xc120
+#define DWC3_GGPIO		0xc124
+#define DWC3_GUID		0xc128
+#define DWC3_GUCTL		0xc12c
+#define DWC3_GBUSERRADDR0	0xc130
+#define DWC3_GBUSERRADDR1	0xc134
+#define DWC3_GPRTBIMAP0		0xc138
+#define DWC3_GPRTBIMAP1		0xc13c
+#define DWC3_GHWPARAMS0		0xc140
+#define DWC3_GHWPARAMS1		0xc144
+#define DWC3_GHWPARAMS2		0xc148
+#define DWC3_GHWPARAMS3		0xc14c
+#define DWC3_GHWPARAMS4		0xc150
+#define DWC3_GHWPARAMS5		0xc154
+#define DWC3_GHWPARAMS6		0xc158
+#define DWC3_GHWPARAMS7		0xc15c
+#define DWC3_GDBGFIFOSPACE	0xc160
+#define DWC3_GDBGLTSSM		0xc164
+#define DWC3_GPRTBIMAP_HS0	0xc180
+#define DWC3_GPRTBIMAP_HS1	0xc184
+#define DWC3_GPRTBIMAP_FS0	0xc188
+#define DWC3_GPRTBIMAP_FS1	0xc18c
+
+#define DWC3_GUSB2PHYCFG(n)	(0xc200 + (n * 0x04))
+#define DWC3_GUSB2I2CCTL(n)	(0xc240 + (n * 0x04))
+
+#define DWC3_GUSB2PHYACC(n)	(0xc280 + (n * 0x04))
+
+#define DWC3_GUSB3PIPECTL(n)	(0xc2c0 + (n * 0x04))
+
+#define DWC3_GTXFIFOSIZ(n)	(0xc300 + (n * 0x04))
+#define DWC3_GRXFIFOSIZ(n)	(0xc380 + (n * 0x04))
+
+#define DWC3_GEVNTADRLO(n)	(0xc400 + (n * 0x10))
+#define DWC3_GEVNTADRHI(n)	(0xc404 + (n * 0x10))
+#define DWC3_GEVNTSIZ(n)	(0xc408 + (n * 0x10))
+#define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
+
+#define DWC3_GHWPARAMS8		0xc600
+
+/* Device Registers */
+#define DWC3_DCFG		0xc700
+#define DWC3_DCTL		0xc704
+#define DWC3_DEVTEN		0xc708
+#define DWC3_DSTS		0xc70c
+#define DWC3_DGCMDPAR		0xc710
+#define DWC3_DGCMD		0xc714
+#define DWC3_DALEPENA		0xc720
+#define DWC3_DEPCMDPAR2(n)	(0xc800 + (n * 0x10))
+#define DWC3_DEPCMDPAR1(n)	(0xc804 + (n * 0x10))
+#define DWC3_DEPCMDPAR0(n)	(0xc808 + (n * 0x10))
+#define DWC3_DEPCMD(n)		(0xc80c + (n * 0x10))
+
+/* OTG Registers */
+#define DWC3_OCFG		0xcc00
+#define DWC3_OCTL		0xcc04
+#define DWC3_OEVTEN		0xcc08
+#define DWC3_OSTS		0xcc0C
+
+/* Bit fields */
+
+/* Global Configuration Register */
+#define DWC3_GCTL_PWRDNSCALE(n)	(n << 19)
+#define DWC3_GCTL_U2RSTECN	16
+#define DWC3_GCTL_RAMCLKSEL(x)	((x & DWC3_GCTL_CLK_MASK) << 6)
+#define DWC3_GCTL_CLK_BUS	(0)
+#define DWC3_GCTL_CLK_PIPE	(1)
+#define DWC3_GCTL_CLK_PIPEHALF	(2)
+#define DWC3_GCTL_CLK_MASK	(3)
+
+#define DWC3_GCTL_PRTCAPDIR(n)	(n << 12)
+#define DWC3_GCTL_PRTCAP_HOST	1
+#define DWC3_GCTL_PRTCAP_DEVICE	2
+#define DWC3_GCTL_PRTCAP_OTG	3
+
+#define DWC3_GCTL_CORESOFTRESET	(1 << 11)
+#define DWC3_GCTL_DISSCRAMBLE	(1 << 3)
+
+/* Global USB2 PHY Configuration Register */
+#define DWC3_GUSB2PHYCFG_PHYSOFTRST (1 << 31)
+#define DWC3_GUSB2PHYCFG_SUSPHY	(1 << 6)
+
+/* Global USB3 PIPE Control Register */
+#define DWC3_GUSB3PIPECTL_PHYSOFTRST (1 << 31)
+#define DWC3_GUSB3PIPECTL_SUSPHY (1 << 17)
+
+/* Device Configuration Register */
+#define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
+#define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
+
+#define DWC3_DCFG_SPEED_MASK	(7 << 0)
+#define DWC3_DCFG_SUPERSPEED	(4 << 0)
+#define DWC3_DCFG_HIGHSPEED	(0 << 0)
+#define DWC3_DCFG_FULLSPEED2	(1 << 0)
+#define DWC3_DCFG_LOWSPEED	(2 << 0)
+#define DWC3_DCFG_FULLSPEED1	(3 << 0)
+
+/* Device Control Register */
+#define DWC3_DCTL_RUN_STOP	(1 << 31)
+#define DWC3_DCTL_CSFTRST	(1 << 30)
+#define DWC3_DCTL_LSFTRST	(1 << 29)
+
+#define DWC3_DCTL_HIRD_THRES_MASK	(0x1f << 24)
+#define DWC3_DCTL_HIRD_THRES(n)	(((n) & DWC3_DCTL_HIRD_THRES_MASK) >> =
24)
+
+#define DWC3_DCTL_APPL1RES	(1 << 23)
+
+#define DWC3_DCTL_INITU2ENA	(1 << 12)
+#define DWC3_DCTL_ACCEPTU2ENA	(1 << 11)
+#define DWC3_DCTL_INITU1ENA	(1 << 10)
+#define DWC3_DCTL_ACCEPTU1ENA	(1 << 9)
+#define DWC3_DCTL_TSTCTRL_MASK	(0xf << 1)
+
+#define DWC3_DCTL_ULSTCHNGREQ_MASK	(0x0f << 5)
+#define DWC3_DCTL_ULSTCHNGREQ(n) (((n) << 5) & DWC3_DCTL_ULSTCHNGREQ_M=
ASK)
+
+#define DWC3_DCTL_ULSTCHNG_NO_ACTION	(DWC3_DCTL_ULSTCHNGREQ(0))
+#define DWC3_DCTL_ULSTCHNG_SS_DISABLED	(DWC3_DCTL_ULSTCHNGREQ(4))
+#define DWC3_DCTL_ULSTCHNG_RX_DETECT	(DWC3_DCTL_ULSTCHNGREQ(5))
+#define DWC3_DCTL_ULSTCHNG_SS_INACTIVE	(DWC3_DCTL_ULSTCHNGREQ(6))
+#define DWC3_DCTL_ULSTCHNG_RECOVERY	(DWC3_DCTL_ULSTCHNGREQ(8))
+#define DWC3_DCTL_ULSTCHNG_COMPLIANCE	(DWC3_DCTL_ULSTCHNGREQ(10))
+#define DWC3_DCTL_ULSTCHNG_LOOPBACK	(DWC3_DCTL_ULSTCHNGREQ(11))
+
+/* Device Event Enable Register */
+#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	(1 << 12)
+#define DWC3_DEVTEN_EVNTOVERFLOWEN	(1 << 11)
+#define DWC3_DEVTEN_CMDCMPLTEN		(1 << 10)
+#define DWC3_DEVTEN_ERRTICERREN		(1 << 9)
+#define DWC3_DEVTEN_SOFEN		(1 << 7)
+#define DWC3_DEVTEN_EOPFEN		(1 << 6)
+#define DWC3_DEVTEN_WKUPEVTEN		(1 << 4)
+#define DWC3_DEVTEN_ULSTCNGEN		(1 << 3)
+#define DWC3_DEVTEN_CONNECTDONEEN	(1 << 2)
+#define DWC3_DEVTEN_USBRSTEN		(1 << 1)
+#define DWC3_DEVTEN_DISCONNEVTEN	(1 << 0)
+
+/* Device Status Register */
+#define DWC3_DSTS_PWRUPREQ		(1 << 24)
+#define DWC3_DSTS_COREIDLE		(1 << 23)
+#define DWC3_DSTS_DEVCTRLHLT		(1 << 22)
+
+#define DWC3_DSTS_USBLNKST_MASK		(0x0f << 18)
+#define DWC3_DSTS_USBLNKST(n)		(((n) & DWC3_DSTS_USBLNKST_MASK) >> 18)
+
+#define DWC3_DSTS_RXFIFOEMPTY		(1 << 17)
+
+#define DWC3_DSTS_SOFFN_MASK		(0x3ff << 3)
+#define DWC3_DSTS_SOFFN(n)		(((n) & DWC3_DSTS_SOFFN_MASK) >> 3)
+
+#define DWC3_DSTS_CONNECTSPD		(7 << 0)
+
+#define DWC3_DSTS_SUPERSPEED		(4 << 0)
+#define DWC3_DSTS_HIGHSPEED		(0 << 0)
+#define DWC3_DSTS_FULLSPEED2		(1 << 0)
+#define DWC3_DSTS_LOWSPEED		(2 << 0)
+#define DWC3_DSTS_FULLSPEED1		(3 << 0)
+
+/* Device Generic Command Register */
+#define DWC3_DGCMD_SET_LMP		0x01
+#define DWC3_DGCMD_SET_PERIODIC_PAR	0x02
+#define DWC3_DGCMD_XMIT_FUNCTION	0x03
+#define DWC3_DGCMD_SELECTED_FIFO_FLUSH	0x09
+#define DWC3_DGCMD_ALL_FIFO_FLUSH	0x0a
+#define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
+#define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
+
+/* Device Endpoint Command Register */
+#define DWC3_DEPCMD_PARAM_SHIFT		16
+#define DWC3_DEPCMD_PARAM(x)		(x << DWC3_DEPCMD_PARAM_SHIFT)
+#define DWC3_DEPCMD_GET_RSC_IDX(x)	((x >> DWC3_DEPCMD_PARAM_SHIFT) & 0=
x7f)
+#define DWC3_DEPCMD_STATUS_MASK		(0x0f << 12)
+#define DWC3_DEPCMD_STATUS(x)		((x & DWC3_DEPCMD_STATUS_MASK) >> 12)
+#define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
+#define DWC3_DEPCMD_CMDACT		(1 << 10)
+#define DWC3_DEPCMD_CMDIOC		(1 << 8)
+
+#define DWC3_DEPCMD_DEPSTARTCFG		(0x09 << 0)
+#define DWC3_DEPCMD_ENDTRANSFER		(0x08 << 0)
+#define DWC3_DEPCMD_UPDATETRANSFER	(0x07 << 0)
+#define DWC3_DEPCMD_STARTTRANSFER	(0x06 << 0)
+#define DWC3_DEPCMD_CLEARSTALL		(0x05 << 0)
+#define DWC3_DEPCMD_SETSTALL		(0x04 << 0)
+#define DWC3_DEPCMD_GETSEQNUMBER	(0x03 << 0)
+#define DWC3_DEPCMD_SETTRANSFRESOURCE	(0x02 << 0)
+#define DWC3_DEPCMD_SETEPCONFIG		(0x01 << 0)
+
+/* The EP number goes 0..31 so ep0 is always out and ep1 is always in =
*/
+#define DWC3_DALEPENA_EP(n)		(1 << n)
+
+#define DWC3_DEPCMD_TYPE_CONTROL	0
+#define DWC3_DEPCMD_TYPE_ISOC		1
+#define DWC3_DEPCMD_TYPE_BULK		2
+#define DWC3_DEPCMD_TYPE_INTR		3
+
+/* Structures */
+
+struct dwc3_trb_hw;
+
+/**
+ * struct dwc3_event_buffer - Software event buffer representation
+ * @list: a list of event buffers
+ * @buf: _THE_ buffer
+ * @length: size of this buffer
+ * @dma: dma_addr_t
+ * @dwc: pointer to DWC controller
+ */
+struct dwc3_event_buffer {
+	void			*buf;
+	unsigned		length;
+	unsigned int		lpos;
+
+	dma_addr_t		dma;
+
+	struct dwc3		*dwc;
+};
+
+#define DWC3_EP_FLAG_STALLED	(1 << 0)
+#define DWC3_EP_FLAG_WEDGED	(1 << 1)
+
+#define DWC3_EP_DIRECTION_TX	true
+#define DWC3_EP_DIRECTION_RX	false
+
+#define DWC3_TRB_NUM		32
+#define DWC3_TRB_MASK		(DWC3_TRB_NUM - 1)
+
+/**
+ * struct dwc3_ep - device side endpoint representation
+ * @endpoint: usb endpoint
+ * @request_list: list of requests for this endpoint
+ * @req_queued: list of requests on this ep which have TRBs setup
+ * @trb_pool: array of transaction buffers
+ * @trb_pool_dma: dma address of @trb_pool
+ * @free_slot: next slot which is going to be used
+ * @busy_slot: first slot which is owned by HW
+ * @desc: usb_endpoint_descriptor pointer
+ * @dwc: pointer to DWC controller
+ * @flags: endpoint flags (wedged, stalled, ...)
+ * @current_trb: index of current used trb
+ * @number: endpoint number (1 - 15)
+ * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
+ * @res_trans_idx: Resource transfer index
+ * @interval: the intervall on which the ISOC transfer is started
+ * @name: a human readable name e.g. ep1out-bulk
+ * @direction: true for TX, false for RX
+ */
+struct dwc3_ep {
+	struct usb_ep		endpoint;
+	struct list_head	request_list;
+	struct list_head	req_queued;
+
+	struct dwc3_trb_hw	*trb_pool;
+	dma_addr_t		trb_pool_dma;
+	u32			free_slot;
+	u32			busy_slot;
+	const struct usb_endpoint_descriptor *desc;
+	struct dwc3		*dwc;
+
+	unsigned		flags;
+#define DWC3_EP_ENABLED		(1 << 0)
+#define DWC3_EP_STALL		(1 << 1)
+#define DWC3_EP_WEDGE		(1 << 2)
+#define DWC3_EP_BUSY		(1 << 4)
+#define DWC3_EP_PENDING_REQUEST	(1 << 5)
+#define DWC3_EP_WILL_SHUTDOWN	(1 << 6)
+
+	unsigned		current_trb;
+
+	u8			number;
+	u8			type;
+	u8			res_trans_idx;
+	u32			interval;
+
+	char			name[20];
+
+	unsigned		direction:1;
+};
+
+enum dwc3_phy {
+	DWC3_PHY_UNKNOWN =3D 0,
+	DWC3_PHY_USB3,
+	DWC3_PHY_USB2,
+};
+
+enum dwc3_ep0_state {
+	EP0_UNCONNECTED		=3D 0,
+	EP0_IDLE,
+	EP0_IN_DATA_PHASE,
+	EP0_OUT_DATA_PHASE,
+	EP0_IN_WAIT_GADGET,
+	EP0_OUT_WAIT_GADGET,
+	EP0_IN_WAIT_NRDY,
+	EP0_OUT_WAIT_NRDY,
+	EP0_IN_STATUS_PHASE,
+	EP0_OUT_STATUS_PHASE,
+	EP0_STALL,
+};
+
+enum dwc3_link_state {
+	/* In SuperSpeed */
+	DWC3_LINK_STATE_U0		=3D 0x00, /* in HS, means ON */
+	DWC3_LINK_STATE_U1		=3D 0x01,
+	DWC3_LINK_STATE_U2		=3D 0x02, /* in HS, means SLEEP */
+	DWC3_LINK_STATE_U3		=3D 0x03, /* in HS, means SUSPEND */
+	DWC3_LINK_STATE_SS_DIS		=3D 0x04,
+	DWC3_LINK_STATE_RX_DET		=3D 0x05, /* in HS, means Early Suspend */
+	DWC3_LINK_STATE_SS_INACT	=3D 0x06,
+	DWC3_LINK_STATE_POLL		=3D 0x07,
+	DWC3_LINK_STATE_RECOV		=3D 0x08,
+	DWC3_LINK_STATE_HRESET		=3D 0x09,
+	DWC3_LINK_STATE_CMPLY		=3D 0x0a,
+	DWC3_LINK_STATE_LPBK		=3D 0x0b,
+	DWC3_LINK_STATE_MASK		=3D 0x0f,
+};
+
+enum dwc3_device_state {
+	DWC3_DEFAULT_STATE,
+	DWC3_ADDRESS_STATE,
+	DWC3_CONFIGURED_STATE,
+};
+
+/**
+ * struct dwc3_trb - transfer request block
+ * @bpl: lower 32bit of the buffer
+ * @bph: higher 32bit of the buffer
+ * @length: buffer size (up to 16mb - 1)
+ * @pcm1: packet count m1
+ * @trbsts: trb status
+ *	0 =3D ok
+ *	1 =3D missed isoc
+ *	2 =3D setup pending
+ * @hwo: hardware owner of descriptor
+ * @lst: last trb
+ * @chn: chain buffers
+ * @csp: continue on short packets (only supported on isoc eps)
+ * @trbctl: trb control
+ *	1 =3D normal
+ *	2 =3D control-setup
+ *	3 =3D control-status-2
+ *	4 =3D control-status-3
+ *	5 =3D control-data (first trb of data stage)
+ *	6 =3D isochronous-first (first trb of service interval)
+ *	7 =3D isochronous
+ *	8 =3D link trb
+ *	others =3D reserved
+ * @isp_imi: interrupt on short packet / interrupt on missed isoc
+ * @ioc: interrupt on complete
+ * @sid_sofn: Stream ID / SOF Number
+ */
+struct dwc3_trb {
+	u64             bplh;
+
+	union {
+		struct {
+			u32             length:24;
+			u32             pcm1:2;
+			u32             reserved27_26:2;
+			u32             trbsts:4;
+#define DWC3_TRB_STS_OKAY                       0
+#define DWC3_TRB_STS_MISSED_ISOC                1
+#define DWC3_TRB_STS_SETUP_PENDING              2
+		};
+		u32 len_pcm;
+	};
+
+	union {
+		struct {
+			u32             hwo:1;
+			u32             lst:1;
+			u32             chn:1;
+			u32             csp:1;
+			u32             trbctl:6;
+			u32             isp_imi:1;
+			u32             ioc:1;
+			u32             reserved13_12:2;
+			u32             sid_sofn:16;
+			u32             reserved31_30:2;
+		};
+		u32 control;
+	};
+} __packed;
+
+/**
+ * struct dwc3_trb_hw - transfer request block (hw format)
+ * @bpl: DW0-3
+ * @bph: DW4-7
+ * @size: DW8-B
+ * @trl: DWC-F
+ */
+struct dwc3_trb_hw {
+	__le32		bpl;
+	__le32		bph;
+	__le32		size;
+	__le32		ctrl;
+} __packed;
+
+static inline void dwc3_trb_to_hw(struct dwc3_trb *nat, struct dwc3_tr=
b_hw *hw)
+{
+	hw->bpl =3D cpu_to_le32(lower_32_bits(nat->bplh));
+	hw->bph =3D cpu_to_le32(upper_32_bits(nat->bplh));
+	hw->size =3D cpu_to_le32p(&nat->len_pcm);
+	/* HWO is written last */
+	hw->ctrl =3D cpu_to_le32p(&nat->control);
+}
+
+static inline void dwc3_trb_to_nat(struct dwc3_trb_hw *hw, struct dwc3=
_trb *nat)
+{
+	u64 bplh;
+
+	bplh =3D le32_to_cpup(&hw->bpl);
+	bplh |=3D (u64) le32_to_cpup(&hw->bph) << 32;
+	nat->bplh =3D bplh;
+
+	nat->len_pcm =3D le32_to_cpup(&hw->size);
+	nat->control =3D le32_to_cpup(&hw->ctrl);
+}
+
+/**
+ * struct dwc3 - representation of our controller
+ * ctrl_req: usb control request which is used for ep0
+ * ep0_trb: trb which is used for the ctrl_req
+ * setup_buf: used while precessing STD USB requests
+ * ctrl_req_addr: dma address of ctrl_req
+ * ep0_trb: dma address of ep0_trb
+ * ep0_usb_req: dummy req used while handling STD USB requests
+ * setup_buf_addr: dma address of setup_buf
+ * @lock: for synchronizing
+ * @dev: pointer to our struct device
+ * @event_buffer_list: a list of event buffers
+ * @gadget: device side representation of the peripheral controller
+ * @gadget_driver: pointer to the gadget driver
+ * @regs: base address for our registers
+ * @regs_size: address space size
+ * @irq: IRQ number
+ * @revision: revision register contents
+ * @is_selfpowered: true when we are selfpowered
+ * @three_stage_setup: set if we perform a three phase setup
+ * @ep0_status_pending: ep0 status response without a req is pending
+ * @ep0state: state of endpoint zero
+ * @link_state: link state
+ * @speed: device speed (super, high, full, low)
+ * @mem: points to start of memory which is used for this struct.
+ * @root: debugfs root folder pointer
+ */
+struct dwc3 {
+	struct usb_ctrlrequest	*ctrl_req;
+	struct dwc3_trb_hw	*ep0_trb;
+	u8			*setup_buf;
+	dma_addr_t		ctrl_req_addr;
+	dma_addr_t		ep0_trb_addr;
+	dma_addr_t		setup_buf_addr;
+	struct usb_request	ep0_usb_req;
+	/* device lock */
+	spinlock_t		lock;
+	struct device		*dev;
+
+	struct dwc3_event_buffer *ev_buffs[DWC3_EVENT_BUFFERS_NUM];
+	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
+
+	struct usb_gadget	gadget;
+	struct usb_gadget_driver *gadget_driver;
+
+	void __iomem		*regs;
+	size_t			regs_size;
+
+	int			irq;
+
+	u32			revision;
+
+#define DWC3_REVISION_173A	0x5533173a
+#define DWC3_REVISION_175A	0x5533175a
+#define DWC3_REVISION_180A	0x5533180a
+#define DWC3_REVISION_183A	0x5533183a
+#define DWC3_REVISION_185A	0x5533185a
+#define DWC3_REVISION_188A	0x5533188a
+#define DWC3_REVISION_190A	0x5533190a
+
+	unsigned		is_selfpowered:1;
+	unsigned		three_stage_setup:1;
+	unsigned		ep0_status_pending:1;
+
+	enum dwc3_ep0_state	ep0state;
+	enum dwc3_link_state	link_state;
+	enum dwc3_device_state	dev_state;
+
+	u8			speed;
+	void			*mem;
+
+	struct dentry		*root;
+};
+
+/* -------------------------------------------------------------------=
------- */
+
+#define DWC3_TRBSTS_OK			0
+#define DWC3_TRBSTS_MISSED_ISOC		1
+#define DWC3_TRBSTS_SETUP_PENDING	2
+
+#define DWC3_TRBCTL_NORMAL		1
+#define DWC3_TRBCTL_CONTROL_SETUP	2
+#define DWC3_TRBCTL_CONTROL_STATUS2	3
+#define DWC3_TRBCTL_CONTROL_STATUS3	4
+#define DWC3_TRBCTL_CONTROL_DATA	5
+#define DWC3_TRBCTL_ISOCHRONOUS_FIRST	6
+#define DWC3_TRBCTL_ISOCHRONOUS		7
+#define DWC3_TRBCTL_LINK_TRB		8
+
+/* -------------------------------------------------------------------=
------- */
+
+struct dwc3_event_type {
+	u32	is_devspec:1;
+	u32	type:6;
+	u32	reserved8_31:25;
+} __packed;
+
+#define DWC3_DEPEVT_XFERCOMPLETE	0x01
+#define DWC3_DEPEVT_XFERINPROGRESS	0x02
+#define DWC3_DEPEVT_XFERNOTREADY	0x03
+#define DWC3_DEPEVT_RXTXFIFOEVT		0x04
+#define DWC3_DEPEVT_STREAMEVT		0x06
+#define DWC3_DEPEVT_EPCMDCMPLT		0x07
+
+/**
+ * struct dwc3_event_depvt - Device Endpoint Events
+ * @one_bit: indicates this is an endpoint event (not used)
+ * @endpoint_number: number of the endpoint
+ * @endpoint_event: The event we have:
+ *	0x00	- Reserved
+ *	0x01	- XferComplete
+ *	0x02	- XferInProgress
+ *	0x03	- XferNotReady
+ *	0x04	- RxTxFifoEvt (IN->Underrun, OUT->Overrun)
+ *	0x05	- Reserved
+ *	0x06	- StreamEvt
+ *	0x07	- EPCmdCmplt
+ * @reserved11_10: Reserved, don't use.
+ * @status: Indicates the status of the event. Refer to databook for
+ *	more information.
+ * @parameters: Parameters of the current event. Refer to databook for
+ *	more information.
+ */
+struct dwc3_event_depevt {
+	u32	one_bit:1;
+	u32	endpoint_number:5;
+	u32	endpoint_event:4;
+	u32	reserved11_10:2;
+	u32	status:4;
+#define DEPEVT_STATUS_BUSERR    (1 << 0)
+#define DEPEVT_STATUS_SHORT     (1 << 1)
+#define DEPEVT_STATUS_IOC       (1 << 2)
+#define DEPEVT_STATUS_LST	(1 << 3)
+	u32	parameters:16;
+} __packed;
+
+/**
+ * struct dwc3_event_devt - Device Events
+ * @one_bit: indicates this is a non-endpoint event (not used)
+ * @device_event: indicates it's a device event. Should read as 0x00
+ * @type: indicates the type of device event.
+ *	0	- DisconnEvt
+ *	1	- USBRst
+ *	2	- ConnectDone
+ *	3	- ULStChng
+ *	4	- WkUpEvt
+ *	5	- Reserved
+ *	6	- EOPF
+ *	7	- SOF
+ *	8	- Reserved
+ *	9	- ErrticErr
+ *	10	- CmdCmplt
+ *	11	- EvntOverflow
+ *	12	- VndrDevTstRcved
+ * @reserved15_12: Reserved, not used
+ * @event_info: Information about this event
+ * @reserved31_24: Reserved, not used
+ */
+struct dwc3_event_devt {
+	u32	one_bit:1;
+	u32	device_event:7;
+	u32	type:4;
+	u32	reserved15_12:4;
+	u32	event_info:8;
+	u32	reserved31_24:8;
+} __packed;
+
+/**
+ * struct dwc3_event_gevt - Other Core Events
+ * @one_bit: indicates this is a non-endpoint event (not used)
+ * @device_event: indicates it's (0x03) Carkit or (0x04) I2C event.
+ * @phy_port_number: self-explanatory
+ * @reserved31_12: Reserved, not used.
+ */
+struct dwc3_event_gevt {
+	u32	one_bit:1;
+	u32	device_event:7;
+	u32	phy_port_number:4;
+	u32	reserved31_12:20;
+} __packed;
+
+/**
+ * union dwc3_event - representation of Event Buffer contents
+ * @raw: raw 32-bit event
+ * @type: the type of the event
+ * @depevt: Device Endpoint Event
+ * @devt: Device Event
+ * @gevt: Global Event
+ */
+union dwc3_event {
+	u32				raw;
+	struct dwc3_event_type		type;
+	struct dwc3_event_depevt	depevt;
+	struct dwc3_event_devt		devt;
+	struct dwc3_event_gevt		gevt;
+};
+
+/*
+ * DWC3 Features to be used as Driver Data
+ */
+
+#define DWC3_HAS_PERIPHERAL		BIT(0)
+#define DWC3_HAS_XHCI			BIT(1)
+#define DWC3_HAS_OTG			BIT(3)
+
+#endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
new file mode 100644
index 0000000..ee3ba73
--- /dev/null
+++ b/drivers/usb/dwc3/debug.h
@@ -0,0 +1,51 @@
+/**
+ * debug.h - DesignWare USB3 DRD Controller Debug Header
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "core.h"
+
+#ifdef CONFIG_DEBUG_FS
+extern int dwc3_debugfs_init(struct dwc3 *);
+extern void dwc3_debugfs_exit(struct dwc3 *);
+#else
+static inline int dwc3_debugfs_init(struct dwc3 *d)
+{  return 0;  }
+static inline void dwc3_debugfs_exit(struct dwc3 *d)
+{  }
+#endif
+
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
new file mode 100644
index 0000000..432df53
--- /dev/null
+++ b/drivers/usb/dwc3/debugfs.c
@@ -0,0 +1,534 @@
+/**
+ * debugfs.c - DesignWare USB3 DRD Controller DebugFS file
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+
+#include <asm/uaccess.h>
+
+#include "core.h"
+#include "gadget.h"
+#include "io.h"
+
+struct dwc3_register {
+	const char	*name;
+	u32		offset;
+};
+
+#define dump_register(nm)				\
+{							\
+	.name	=3D __stringify(nm),			\
+	.offset	=3D DWC3_ ##nm,				\
+}
+
+static const struct dwc3_register dwc3_regs[] =3D {
+	dump_register(GSBUSCFG0),
+	dump_register(GSBUSCFG1),
+	dump_register(GTXTHRCFG),
+	dump_register(GRXTHRCFG),
+	dump_register(GCTL),
+	dump_register(GEVTEN),
+	dump_register(GSTS),
+	dump_register(GSNPSID),
+	dump_register(GGPIO),
+	dump_register(GUID),
+	dump_register(GUCTL),
+	dump_register(GBUSERRADDR0),
+	dump_register(GBUSERRADDR1),
+	dump_register(GPRTBIMAP0),
+	dump_register(GPRTBIMAP1),
+	dump_register(GHWPARAMS0),
+	dump_register(GHWPARAMS1),
+	dump_register(GHWPARAMS2),
+	dump_register(GHWPARAMS3),
+	dump_register(GHWPARAMS4),
+	dump_register(GHWPARAMS5),
+	dump_register(GHWPARAMS6),
+	dump_register(GHWPARAMS7),
+	dump_register(GDBGFIFOSPACE),
+	dump_register(GDBGLTSSM),
+	dump_register(GPRTBIMAP_HS0),
+	dump_register(GPRTBIMAP_HS1),
+	dump_register(GPRTBIMAP_FS0),
+	dump_register(GPRTBIMAP_FS1),
+
+	dump_register(GUSB2PHYCFG(0)),
+	dump_register(GUSB2PHYCFG(1)),
+	dump_register(GUSB2PHYCFG(2)),
+	dump_register(GUSB2PHYCFG(3)),
+	dump_register(GUSB2PHYCFG(4)),
+	dump_register(GUSB2PHYCFG(5)),
+	dump_register(GUSB2PHYCFG(6)),
+	dump_register(GUSB2PHYCFG(7)),
+	dump_register(GUSB2PHYCFG(8)),
+	dump_register(GUSB2PHYCFG(9)),
+	dump_register(GUSB2PHYCFG(10)),
+	dump_register(GUSB2PHYCFG(11)),
+	dump_register(GUSB2PHYCFG(12)),
+	dump_register(GUSB2PHYCFG(13)),
+	dump_register(GUSB2PHYCFG(14)),
+	dump_register(GUSB2PHYCFG(15)),
+
+	dump_register(GUSB2I2CCTL(0)),
+	dump_register(GUSB2I2CCTL(1)),
+	dump_register(GUSB2I2CCTL(2)),
+	dump_register(GUSB2I2CCTL(3)),
+	dump_register(GUSB2I2CCTL(4)),
+	dump_register(GUSB2I2CCTL(5)),
+	dump_register(GUSB2I2CCTL(6)),
+	dump_register(GUSB2I2CCTL(7)),
+	dump_register(GUSB2I2CCTL(8)),
+	dump_register(GUSB2I2CCTL(9)),
+	dump_register(GUSB2I2CCTL(10)),
+	dump_register(GUSB2I2CCTL(11)),
+	dump_register(GUSB2I2CCTL(12)),
+	dump_register(GUSB2I2CCTL(13)),
+	dump_register(GUSB2I2CCTL(14)),
+	dump_register(GUSB2I2CCTL(15)),
+
+	dump_register(GUSB2PHYACC(0)),
+	dump_register(GUSB2PHYACC(1)),
+	dump_register(GUSB2PHYACC(2)),
+	dump_register(GUSB2PHYACC(3)),
+	dump_register(GUSB2PHYACC(4)),
+	dump_register(GUSB2PHYACC(5)),
+	dump_register(GUSB2PHYACC(6)),
+	dump_register(GUSB2PHYACC(7)),
+	dump_register(GUSB2PHYACC(8)),
+	dump_register(GUSB2PHYACC(9)),
+	dump_register(GUSB2PHYACC(10)),
+	dump_register(GUSB2PHYACC(11)),
+	dump_register(GUSB2PHYACC(12)),
+	dump_register(GUSB2PHYACC(13)),
+	dump_register(GUSB2PHYACC(14)),
+	dump_register(GUSB2PHYACC(15)),
+
+	dump_register(GUSB3PIPECTL(0)),
+	dump_register(GUSB3PIPECTL(1)),
+	dump_register(GUSB3PIPECTL(2)),
+	dump_register(GUSB3PIPECTL(3)),
+	dump_register(GUSB3PIPECTL(4)),
+	dump_register(GUSB3PIPECTL(5)),
+	dump_register(GUSB3PIPECTL(6)),
+	dump_register(GUSB3PIPECTL(7)),
+	dump_register(GUSB3PIPECTL(8)),
+	dump_register(GUSB3PIPECTL(9)),
+	dump_register(GUSB3PIPECTL(10)),
+	dump_register(GUSB3PIPECTL(11)),
+	dump_register(GUSB3PIPECTL(12)),
+	dump_register(GUSB3PIPECTL(13)),
+	dump_register(GUSB3PIPECTL(14)),
+	dump_register(GUSB3PIPECTL(15)),
+
+	dump_register(GTXFIFOSIZ(0)),
+	dump_register(GTXFIFOSIZ(1)),
+	dump_register(GTXFIFOSIZ(2)),
+	dump_register(GTXFIFOSIZ(3)),
+	dump_register(GTXFIFOSIZ(4)),
+	dump_register(GTXFIFOSIZ(5)),
+	dump_register(GTXFIFOSIZ(6)),
+	dump_register(GTXFIFOSIZ(7)),
+	dump_register(GTXFIFOSIZ(8)),
+	dump_register(GTXFIFOSIZ(9)),
+	dump_register(GTXFIFOSIZ(10)),
+	dump_register(GTXFIFOSIZ(11)),
+	dump_register(GTXFIFOSIZ(12)),
+	dump_register(GTXFIFOSIZ(13)),
+	dump_register(GTXFIFOSIZ(14)),
+	dump_register(GTXFIFOSIZ(15)),
+	dump_register(GTXFIFOSIZ(16)),
+	dump_register(GTXFIFOSIZ(17)),
+	dump_register(GTXFIFOSIZ(18)),
+	dump_register(GTXFIFOSIZ(19)),
+	dump_register(GTXFIFOSIZ(20)),
+	dump_register(GTXFIFOSIZ(21)),
+	dump_register(GTXFIFOSIZ(22)),
+	dump_register(GTXFIFOSIZ(23)),
+	dump_register(GTXFIFOSIZ(24)),
+	dump_register(GTXFIFOSIZ(25)),
+	dump_register(GTXFIFOSIZ(26)),
+	dump_register(GTXFIFOSIZ(27)),
+	dump_register(GTXFIFOSIZ(28)),
+	dump_register(GTXFIFOSIZ(29)),
+	dump_register(GTXFIFOSIZ(30)),
+	dump_register(GTXFIFOSIZ(31)),
+
+	dump_register(GRXFIFOSIZ(0)),
+	dump_register(GRXFIFOSIZ(1)),
+	dump_register(GRXFIFOSIZ(2)),
+	dump_register(GRXFIFOSIZ(3)),
+	dump_register(GRXFIFOSIZ(4)),
+	dump_register(GRXFIFOSIZ(5)),
+	dump_register(GRXFIFOSIZ(6)),
+	dump_register(GRXFIFOSIZ(7)),
+	dump_register(GRXFIFOSIZ(8)),
+	dump_register(GRXFIFOSIZ(9)),
+	dump_register(GRXFIFOSIZ(10)),
+	dump_register(GRXFIFOSIZ(11)),
+	dump_register(GRXFIFOSIZ(12)),
+	dump_register(GRXFIFOSIZ(13)),
+	dump_register(GRXFIFOSIZ(14)),
+	dump_register(GRXFIFOSIZ(15)),
+	dump_register(GRXFIFOSIZ(16)),
+	dump_register(GRXFIFOSIZ(17)),
+	dump_register(GRXFIFOSIZ(18)),
+	dump_register(GRXFIFOSIZ(19)),
+	dump_register(GRXFIFOSIZ(20)),
+	dump_register(GRXFIFOSIZ(21)),
+	dump_register(GRXFIFOSIZ(22)),
+	dump_register(GRXFIFOSIZ(23)),
+	dump_register(GRXFIFOSIZ(24)),
+	dump_register(GRXFIFOSIZ(25)),
+	dump_register(GRXFIFOSIZ(26)),
+	dump_register(GRXFIFOSIZ(27)),
+	dump_register(GRXFIFOSIZ(28)),
+	dump_register(GRXFIFOSIZ(29)),
+	dump_register(GRXFIFOSIZ(30)),
+	dump_register(GRXFIFOSIZ(31)),
+
+	dump_register(GEVNTADRLO(0)),
+	dump_register(GEVNTADRHI(0)),
+	dump_register(GEVNTSIZ(0)),
+	dump_register(GEVNTCOUNT(0)),
+
+	dump_register(GHWPARAMS8),
+	dump_register(DCFG),
+	dump_register(DCTL),
+	dump_register(DEVTEN),
+	dump_register(DSTS),
+	dump_register(DGCMDPAR),
+	dump_register(DGCMD),
+	dump_register(DALEPENA),
+
+	dump_register(DEPCMDPAR2(0)),
+	dump_register(DEPCMDPAR2(1)),
+	dump_register(DEPCMDPAR2(2)),
+	dump_register(DEPCMDPAR2(3)),
+	dump_register(DEPCMDPAR2(4)),
+	dump_register(DEPCMDPAR2(5)),
+	dump_register(DEPCMDPAR2(6)),
+	dump_register(DEPCMDPAR2(7)),
+	dump_register(DEPCMDPAR2(8)),
+	dump_register(DEPCMDPAR2(9)),
+	dump_register(DEPCMDPAR2(10)),
+	dump_register(DEPCMDPAR2(11)),
+	dump_register(DEPCMDPAR2(12)),
+	dump_register(DEPCMDPAR2(13)),
+	dump_register(DEPCMDPAR2(14)),
+	dump_register(DEPCMDPAR2(15)),
+	dump_register(DEPCMDPAR2(16)),
+	dump_register(DEPCMDPAR2(17)),
+	dump_register(DEPCMDPAR2(18)),
+	dump_register(DEPCMDPAR2(19)),
+	dump_register(DEPCMDPAR2(20)),
+	dump_register(DEPCMDPAR2(21)),
+	dump_register(DEPCMDPAR2(22)),
+	dump_register(DEPCMDPAR2(23)),
+	dump_register(DEPCMDPAR2(24)),
+	dump_register(DEPCMDPAR2(25)),
+	dump_register(DEPCMDPAR2(26)),
+	dump_register(DEPCMDPAR2(27)),
+	dump_register(DEPCMDPAR2(28)),
+	dump_register(DEPCMDPAR2(29)),
+	dump_register(DEPCMDPAR2(30)),
+	dump_register(DEPCMDPAR2(31)),
+
+	dump_register(DEPCMDPAR1(0)),
+	dump_register(DEPCMDPAR1(1)),
+	dump_register(DEPCMDPAR1(2)),
+	dump_register(DEPCMDPAR1(3)),
+	dump_register(DEPCMDPAR1(4)),
+	dump_register(DEPCMDPAR1(5)),
+	dump_register(DEPCMDPAR1(6)),
+	dump_register(DEPCMDPAR1(7)),
+	dump_register(DEPCMDPAR1(8)),
+	dump_register(DEPCMDPAR1(9)),
+	dump_register(DEPCMDPAR1(10)),
+	dump_register(DEPCMDPAR1(11)),
+	dump_register(DEPCMDPAR1(12)),
+	dump_register(DEPCMDPAR1(13)),
+	dump_register(DEPCMDPAR1(14)),
+	dump_register(DEPCMDPAR1(15)),
+	dump_register(DEPCMDPAR1(16)),
+	dump_register(DEPCMDPAR1(17)),
+	dump_register(DEPCMDPAR1(18)),
+	dump_register(DEPCMDPAR1(19)),
+	dump_register(DEPCMDPAR1(20)),
+	dump_register(DEPCMDPAR1(21)),
+	dump_register(DEPCMDPAR1(22)),
+	dump_register(DEPCMDPAR1(23)),
+	dump_register(DEPCMDPAR1(24)),
+	dump_register(DEPCMDPAR1(25)),
+	dump_register(DEPCMDPAR1(26)),
+	dump_register(DEPCMDPAR1(27)),
+	dump_register(DEPCMDPAR1(28)),
+	dump_register(DEPCMDPAR1(29)),
+	dump_register(DEPCMDPAR1(30)),
+	dump_register(DEPCMDPAR1(31)),
+
+	dump_register(DEPCMDPAR0(0)),
+	dump_register(DEPCMDPAR0(1)),
+	dump_register(DEPCMDPAR0(2)),
+	dump_register(DEPCMDPAR0(3)),
+	dump_register(DEPCMDPAR0(4)),
+	dump_register(DEPCMDPAR0(5)),
+	dump_register(DEPCMDPAR0(6)),
+	dump_register(DEPCMDPAR0(7)),
+	dump_register(DEPCMDPAR0(8)),
+	dump_register(DEPCMDPAR0(9)),
+	dump_register(DEPCMDPAR0(10)),
+	dump_register(DEPCMDPAR0(11)),
+	dump_register(DEPCMDPAR0(12)),
+	dump_register(DEPCMDPAR0(13)),
+	dump_register(DEPCMDPAR0(14)),
+	dump_register(DEPCMDPAR0(15)),
+	dump_register(DEPCMDPAR0(16)),
+	dump_register(DEPCMDPAR0(17)),
+	dump_register(DEPCMDPAR0(18)),
+	dump_register(DEPCMDPAR0(19)),
+	dump_register(DEPCMDPAR0(20)),
+	dump_register(DEPCMDPAR0(21)),
+	dump_register(DEPCMDPAR0(22)),
+	dump_register(DEPCMDPAR0(23)),
+	dump_register(DEPCMDPAR0(24)),
+	dump_register(DEPCMDPAR0(25)),
+	dump_register(DEPCMDPAR0(26)),
+	dump_register(DEPCMDPAR0(27)),
+	dump_register(DEPCMDPAR0(28)),
+	dump_register(DEPCMDPAR0(29)),
+	dump_register(DEPCMDPAR0(30)),
+	dump_register(DEPCMDPAR0(31)),
+
+	dump_register(DEPCMD(0)),
+	dump_register(DEPCMD(1)),
+	dump_register(DEPCMD(2)),
+	dump_register(DEPCMD(3)),
+	dump_register(DEPCMD(4)),
+	dump_register(DEPCMD(5)),
+	dump_register(DEPCMD(6)),
+	dump_register(DEPCMD(7)),
+	dump_register(DEPCMD(8)),
+	dump_register(DEPCMD(9)),
+	dump_register(DEPCMD(10)),
+	dump_register(DEPCMD(11)),
+	dump_register(DEPCMD(12)),
+	dump_register(DEPCMD(13)),
+	dump_register(DEPCMD(14)),
+	dump_register(DEPCMD(15)),
+	dump_register(DEPCMD(16)),
+	dump_register(DEPCMD(17)),
+	dump_register(DEPCMD(18)),
+	dump_register(DEPCMD(19)),
+	dump_register(DEPCMD(20)),
+	dump_register(DEPCMD(21)),
+	dump_register(DEPCMD(22)),
+	dump_register(DEPCMD(23)),
+	dump_register(DEPCMD(24)),
+	dump_register(DEPCMD(25)),
+	dump_register(DEPCMD(26)),
+	dump_register(DEPCMD(27)),
+	dump_register(DEPCMD(28)),
+	dump_register(DEPCMD(29)),
+	dump_register(DEPCMD(30)),
+	dump_register(DEPCMD(31)),
+
+	dump_register(OCFG),
+	dump_register(OCTL),
+	dump_register(OEVTEN),
+	dump_register(OSTS),
+};
+
+static int dwc3_regdump_show(struct seq_file *s, void *unused)
+{
+	struct dwc3		*dwc =3D s->private;
+	int			i;
+
+	seq_printf(s, "DesignWare USB3 Core Register Dump\n");
+
+	for (i =3D 0; i < ARRAY_SIZE(dwc3_regs); i++) {
+		seq_printf(s, "%-20s :    %08x\n", dwc3_regs[i].name,
+				dwc3_readl(dwc->regs, dwc3_regs[i].offset));
+	}
+
+	return 0;
+}
+
+static int dwc3_regdump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dwc3_regdump_show, inode->i_private);
+}
+
+static const struct file_operations dwc3_regdump_fops =3D {
+	.open			=3D dwc3_regdump_open,
+	.read			=3D seq_read,
+	.release		=3D single_release,
+};
+
+
+static int dwc3_send_testmode_cmd(struct dwc3 *dwc, int mode)
+{
+	u32 timeout =3D 250;
+
+	dwc3_writel(dwc->regs, DWC3_DGCMDPAR, mode);
+	dwc3_writel(dwc->regs, DWC3_DGCMD, DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK |
+			DWC3_DEPCMD_CMDACT);
+	do {
+		u32 reg;
+
+		reg =3D dwc3_readl(dwc->regs, DWC3_DGCMD);
+		if (!(reg & DWC3_DEPCMD_CMDACT))
+			return 0;
+		timeout--;
+		if (!timeout)
+			return -ETIMEDOUT;
+		mdelay(1);
+	} while (1);
+}
+
+static struct dwc3_trb_hw trb_0 __aligned(16);
+static struct dwc3_trb_hw trb_1 __aligned(16);
+
+#define BUF_SIZE	4096
+static int dwc3_testmode_open(struct inode *inode, struct file *file)
+{
+	struct dwc3 *dwc =3D inode->i_private;
+	struct dwc3_gadget_ep_cmd_params par0;
+	struct dwc3_gadget_ep_cmd_params par1;
+	struct dwc3_trb         trb;
+	int ret;
+	u8 *buf0;
+	u8 *buf1;
+
+	buf0 =3D kmalloc(BUF_SIZE, GFP_KERNEL);
+	if (!buf0)
+		return -ENOMEM;
+	buf1 =3D kmalloc(BUF_SIZE, GFP_KERNEL);
+	if (!buf1)
+		return -ENOMEM;
+
+	memset(buf0, 0xaa, BUF_SIZE);
+	memset(buf1, 0x33, BUF_SIZE);
+
+	memset(&trb, 0, sizeof(trb));
+	memset(&par0, 0, sizeof(par0));
+	memset(&par1, 0, sizeof(par1));
+
+	trb.lst =3D 1;
+	trb.trbctl =3D DWC3_TRBCTL_NORMAL;
+	trb.length =3D BUF_SIZE;
+	trb.hwo =3D 1;
+
+	trb.bplh =3D virt_to_phys(buf0);
+	dwc3_trb_to_hw(&trb, &trb_0);
+
+	trb.bplh =3D virt_to_phys(buf1);
+	dwc3_trb_to_hw(&trb, &trb_1);
+
+	par0.param0.depstrtxfer.transfer_desc_addr_high =3D
+		upper_32_bits(virt_to_phys(&trb_0));
+	par0.param1.depstrtxfer.transfer_desc_addr_low =3D
+		lower_32_bits(virt_to_phys(&trb_0));
+
+	par1.param0.depstrtxfer.transfer_desc_addr_high =3D
+		upper_32_bits(virt_to_phys(&trb_1));
+	par1.param1.depstrtxfer.transfer_desc_addr_low =3D
+		lower_32_bits(virt_to_phys(&trb_1));
+
+	dwc3_send_testmode_cmd(dwc, 1);
+
+	ret =3D dwc3_send_gadget_ep_cmd(dwc, 0, DWC3_DEPCMD_STARTTRANSFER, &p=
ar0);
+	ret =3D dwc3_send_gadget_ep_cmd(dwc, 1, DWC3_DEPCMD_STARTTRANSFER, &p=
ar1);
+
+	dwc3_send_testmode_cmd(dwc, 0);
+	return -EBUSY;
+}
+
+static const struct file_operations dwc3_testmode_fops =3D {
+	.open			=3D dwc3_testmode_open,
+	.read			=3D seq_read,
+	.release		=3D single_release,
+};
+
+int __devinit dwc3_debugfs_init(struct dwc3 *dwc)
+{
+	struct dentry		*root;
+	struct dentry		*file;
+	int			ret;
+
+	root =3D debugfs_create_dir(dev_name(dwc->dev), NULL);
+	if (IS_ERR(root)){
+		ret =3D PTR_ERR(root);
+		goto err0;
+	}
+
+	dwc->root =3D root;
+
+	file =3D debugfs_create_file("regdump", S_IRUGO, root, dwc,
+			&dwc3_regdump_fops);
+	if (IS_ERR(file)) {
+		ret =3D PTR_ERR(file);
+		goto err1;
+	}
+	file =3D debugfs_create_file("testmode", S_IRUGO, root, dwc,
+			&dwc3_testmode_fops);
+	if (IS_ERR(file)) {
+		ret =3D PTR_ERR(file);
+		goto err1;
+	}
+
+	return 0;
+
+err1:
+	debugfs_remove_recursive(root);
+
+err0:
+	return ret;
+}
+
+void __devexit dwc3_debugfs_exit(struct dwc3 *dwc)
+{
+	debugfs_remove_recursive(dwc->root);
+	dwc->root =3D NULL;
+}
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.=
c
new file mode 100644
index 0000000..08fffe6
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -0,0 +1,410 @@
+/**
+ * dwc3-omap.c - OMAP Specific Glue layer
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+
+#include "io.h"
+
+/*
+ * All these registers belong to OMAP's Wrapper around the
+ * DesignWare USB3 Core.
+ */
+
+#define USBOTGSS_REVISION			0x0000
+#define USBOTGSS_SYSCONFIG			0x0010
+#define USBOTGSS_IRQ_EOI			0x0020
+#define USBOTGSS_IRQSTATUS_RAW_0		0x0024
+#define USBOTGSS_IRQSTATUS_0			0x0028
+#define USBOTGSS_IRQENABLE_SET_0		0x002c
+#define USBOTGSS_IRQENABLE_CLR_0		0x0030
+#define USBOTGSS_IRQSTATUS_RAW_1		0x0034
+#define USBOTGSS_IRQSTATUS_1			0x0038
+#define USBOTGSS_IRQENABLE_SET_1		0x003c
+#define USBOTGSS_IRQENABLE_CLR_1		0x0040
+#define USBOTGSS_UTMI_OTG_CTRL			0x0080
+#define USBOTGSS_UTMI_OTG_STATUS		0x0084
+#define USBOTGSS_MMRAM_OFFSET			0x0100
+#define USBOTGSS_FLADJ				0x0104
+#define USBOTGSS_DEBUG_CFG			0x0108
+#define USBOTGSS_DEBUG_DATA			0x010c
+
+/* SYSCONFIG REGISTER */
+#define USBOTGSS_SYSCONFIG_DMADISABLE		(1 << 16)
+#define USBOTGSS_SYSCONFIG_STANDBYMODE(x)	((x) << 4)
+#define USBOTGSS_SYSCONFIG_IDLEMODE(x)		((x) << 2)
+
+/* IRQ_EOI REGISTER */
+#define USBOTGSS_IRQ_EOI_LINE_NUMBER		(1 << 0)
+
+/* IRQS0 BITS */
+#define USBOTGSS_IRQO_COREIRQ_ST		(1 << 0)
+
+/* IRQ1 BITS */
+#define USBOTGSS_IRQ1_DMADISABLECLR		(1 << 17)
+#define USBOTGSS_IRQ1_OEVT			(1 << 16)
+#define USBOTGSS_IRQ1_DRVVBUS_RISE		(1 << 13)
+#define USBOTGSS_IRQ1_CHRGVBUS_RISE		(1 << 12)
+#define USBOTGSS_IRQ1_DISCHRGVBUS_RISE		(1 << 11)
+#define USBOTGSS_IRQ1_IDPULLUP_RISE		(1 << 8)
+#define USBOTGSS_IRQ1_DRVVBUS_FALL		(1 << 5)
+#define USBOTGSS_IRQ1_CHRGVBUS_FALL		(1 << 4)
+#define USBOTGSS_IRQ1_DISCHRGVBUS_FALL		(1 << 3)
+#define USBOTGSS_IRQ1_IDPULLUP_FALL		(1 << 0)
+
+/* UTMI_OTG_CTRL REGISTER */
+#define USBOTGSS_UTMI_OTG_CTRL_DRVVBUS		(1 << 5)
+#define USBOTGSS_UTMI_OTG_CTRL_CHRGVBUS		(1 << 4)
+#define USBOTGSS_UTMI_OTG_CTRL_DISCHRGVBUS	(1 << 3)
+#define USBOTGSS_UTMI_OTG_CTRL_IDPULLUP		(1 << 0)
+
+/* UTMI_OTG_STATUS REGISTER */
+#define USBOTGSS_UTMI_OTG_STATUS_SW_MODE	(1 << 31)
+#define USBOTGSS_UTMI_OTG_STATUS_POWERPRESENT	(1 << 9)
+#define USBOTGSS_UTMI_OTG_STATUS_TXBITSTUFFENABLE (1 << 8)
+#define USBOTGSS_UTMI_OTG_STATUS_IDDIG		(1 << 4)
+#define USBOTGSS_UTMI_OTG_STATUS_SESSEND	(1 << 3)
+#define USBOTGSS_UTMI_OTG_STATUS_SESSVALID	(1 << 2)
+#define USBOTGSS_UTMI_OTG_STATUS_VBUSVALID	(1 << 1)
+
+struct dwc3_omap {
+	/* device lock */
+	spinlock_t		lock;
+
+	struct platform_device	*dwc3;
+	struct device		*dev;
+
+	int			irq;
+	void __iomem		*base;
+
+	void			*context;
+	u32			resource_size;
+
+	u32			dma_status:1;
+};
+
+#ifdef CONFIG_PM
+static int dwc3_omap_suspend(struct device *dev)
+{
+	struct dwc3_omap	*omap =3D dev_get_drvdata(dev);
+
+	memcpy_fromio(omap->context, omap->base, omap->resource_size);
+
+	return 0;
+}
+
+static int dwc3_omap_resume(struct device *dev)
+{
+	struct dwc3_omap	*omap =3D dev_get_drvdata(dev);
+
+	memcpy_toio(omap->base, omap->context, omap->resource_size);
+
+	return 0;
+}
+
+static int dwc3_omap_idle(struct device *dev)
+{
+	struct dwc3_omap	*omap =3D dev_get_drvdata(dev);
+	u32			reg;
+
+	/* stop DMA Engine */
+	reg =3D dwc3_readl(omap->base, USBOTGSS_SYSCONFIG);
+	reg &=3D ~(USBOTGSS_SYSCONFIG_DMADISABLE);
+	dwc3_writel(omap->base, USBOTGSS_SYSCONFIG, reg);
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(dwc3_omap_pm_ops, dwc3_omap_suspend,
+		dwc3_omap_resume, dwc3_omap_idle);
+
+#define DEV_PM_OPS	(&dwc3_omap_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
+static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
+{
+	struct dwc3_omap	*omap =3D _omap;
+	u32			reg;
+	u32			ctrl;
+
+	spin_lock(&omap->lock);
+
+	reg =3D dwc3_readl(omap->base, USBOTGSS_IRQSTATUS_1);
+	ctrl =3D dwc3_readl(omap->base, USBOTGSS_UTMI_OTG_CTRL);
+
+	if (reg & USBOTGSS_IRQ1_DMADISABLECLR) {
+		dev_dbg(omap->base, "DMA Disable was Cleared\n");
+		omap->dma_status =3D false;
+	}
+
+	if (reg & USBOTGSS_IRQ1_OEVT)
+		dev_dbg(omap->base, "OTG Event\n");
+
+	if (reg & USBOTGSS_IRQ1_DRVVBUS_RISE) {
+		dev_dbg(omap->base, "DRVVBUS Rise\n");
+		ctrl |=3D USBOTGSS_UTMI_OTG_CTRL_DRVVBUS;
+	}
+
+	if (reg & USBOTGSS_IRQ1_CHRGVBUS_RISE) {
+		dev_dbg(omap->base, "CHRGVBUS Rise\n");
+		ctrl |=3D USBOTGSS_UTMI_OTG_CTRL_CHRGVBUS;
+	}
+
+	if (reg & USBOTGSS_IRQ1_DISCHRGVBUS_RISE) {
+		dev_dbg(omap->base, "DISCHRGVBUS Rise\n");
+		ctrl |=3D USBOTGSS_UTMI_OTG_CTRL_DISCHRGVBUS;
+	}
+
+	if (reg & USBOTGSS_IRQ1_IDPULLUP_RISE) {
+		dev_dbg(omap->base, "IDPULLUP Rise\n");
+		ctrl |=3D USBOTGSS_UTMI_OTG_CTRL_IDPULLUP;
+	}
+
+	if (reg & USBOTGSS_IRQ1_DRVVBUS_FALL) {
+		dev_dbg(omap->base, "DRVVBUS Fall\n");
+		ctrl &=3D ~USBOTGSS_UTMI_OTG_CTRL_DRVVBUS;
+	}
+
+	if (reg & USBOTGSS_IRQ1_CHRGVBUS_FALL) {
+		dev_dbg(omap->base, "CHRGVBUS Fall\n");
+		ctrl &=3D ~USBOTGSS_UTMI_OTG_CTRL_CHRGVBUS;
+	}
+
+	if (reg & USBOTGSS_IRQ1_DISCHRGVBUS_FALL) {
+		dev_dbg(omap->base, "DISCHRGVBUS Fall\n");
+		ctrl &=3D ~USBOTGSS_UTMI_OTG_CTRL_DISCHRGVBUS;
+	}
+
+	if (reg & USBOTGSS_IRQ1_IDPULLUP_FALL) {
+		dev_dbg(omap->base, "IDPULLUP Fall\n");
+		ctrl &=3D ~USBOTGSS_UTMI_OTG_CTRL_IDPULLUP;
+	}
+
+	dwc3_writel(omap->base, USBOTGSS_UTMI_OTG_CTRL, ctrl);
+
+	spin_unlock(&omap->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit dwc3_omap_probe(struct platform_device *pdev)
+{
+	struct platform_device	*dwc3;
+	struct dwc3_omap	*omap;
+	struct resource		*res;
+
+	int			ret =3D -ENOMEM;
+	int			irq;
+
+	u32			reg;
+
+	void __iomem		*base;
+	void			*context;
+
+	omap =3D kzalloc(sizeof(*omap), GFP_KERNEL);
+	if (!omap) {
+		dev_err(&pdev->dev, "not enough memory\n");
+		goto err0;
+	}
+
+	platform_set_drvdata(pdev, omap);
+
+	irq =3D platform_get_irq(pdev, 1);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "missing IRQ resource\n");
+		ret =3D -EINVAL;
+		goto err1;
+	}
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "missing memory base resource\n");
+		ret =3D -EINVAL;
+		goto err1;
+	}
+
+	base =3D ioremap_nocache(res->start, resource_size(res));
+	if (!base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		goto err1;
+	}
+
+	dwc3 =3D platform_device_alloc("dwc3-omap", -1);
+	if (!dwc3) {
+		dev_err(&pdev->dev, "couldn't allocate dwc3 device\n");
+		goto err2;
+	}
+
+	context =3D kzalloc(resource_size(res), GFP_KERNEL);
+	if (!context) {
+		dev_err(&pdev->dev, "couldn't allocate dwc3 context memory\n");
+		goto err3;
+	}
+
+	spin_lock_init(&omap->lock);
+	dma_set_coherent_mask(&dwc3->dev, pdev->dev.coherent_dma_mask);
+
+	dwc3->dev.parent =3D &pdev->dev;
+	dwc3->dev.dma_mask =3D pdev->dev.dma_mask;
+	dwc3->dev.dma_parms =3D pdev->dev.dma_parms;
+	omap->resource_size =3D resource_size(res);
+	omap->context	=3D context;
+	omap->dev	=3D &pdev->dev;
+	omap->irq	=3D irq;
+	omap->base	=3D base;
+	omap->dwc3	=3D dwc3;
+
+	/* check the DMA Status */
+	reg =3D dwc3_readl(omap->base, USBOTGSS_SYSCONFIG);
+	omap->dma_status =3D !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
+
+	ret =3D request_irq(omap->irq, dwc3_omap_interrupt, 0,
+			"dwc3-wrapper", omap);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request IRQ #%d --> %d\n",
+				omap->irq, ret);
+		goto err4;
+	}
+
+	/* enable all IRQs */
+	dwc3_writel(omap->base, USBOTGSS_IRQENABLE_SET_0, 0x01);
+
+	reg =3D (USBOTGSS_IRQ1_DMADISABLECLR |
+			USBOTGSS_IRQ1_OEVT |
+			USBOTGSS_IRQ1_DRVVBUS_RISE |
+			USBOTGSS_IRQ1_CHRGVBUS_RISE |
+			USBOTGSS_IRQ1_DISCHRGVBUS_RISE |
+			USBOTGSS_IRQ1_IDPULLUP_RISE |
+			USBOTGSS_IRQ1_DRVVBUS_FALL |
+			USBOTGSS_IRQ1_CHRGVBUS_FALL |
+			USBOTGSS_IRQ1_DISCHRGVBUS_FALL |
+			USBOTGSS_IRQ1_IDPULLUP_FALL);
+
+	dwc3_writel(omap->base, USBOTGSS_IRQENABLE_SET_1, reg);
+
+	ret =3D platform_device_add_resources(dwc3, pdev->resource,
+			pdev->num_resources);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't add resources to dwc3 device\n");
+		goto err5;
+	}
+
+	ret =3D platform_device_add(dwc3);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register dwc3 device\n");
+		goto err5;
+	}
+
+	return 0;
+
+err5:
+	free_irq(omap->irq, omap);
+
+err4:
+	kfree(omap->context);
+
+err3:
+	platform_device_put(dwc3);
+
+err2:
+	iounmap(base);
+
+err1:
+	kfree(omap);
+
+err0:
+	return ret;
+}
+
+static int __devexit dwc3_omap_remove(struct platform_device *pdev)
+{
+	struct dwc3_omap	*omap =3D platform_get_drvdata(pdev);
+
+	platform_device_unregister(omap->dwc3);
+
+	free_irq(omap->irq, omap);
+	iounmap(omap->base);
+
+	kfree(omap->context);
+	kfree(omap);
+
+	return 0;
+}
+
+static const struct of_device_id of_dwc3_matach[] =3D {
+	{
+		"ti,dwc3",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_dwc3_matach);
+
+static struct platform_driver dwc3_omap_driver =3D {
+	.probe		=3D dwc3_omap_probe,
+	.remove		=3D __devexit_p(dwc3_omap_remove),
+	.driver		=3D {
+		.name	=3D "omap-dwc3",
+		.pm	=3D DEV_PM_OPS,
+		.of_match_table	=3D of_dwc3_matach,
+	},
+};
+
+MODULE_AUTHOR("Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("DesignWare USB3 OMAP Glue Layer");
+
+static int __devinit dwc3_omap_init(void)
+{
+	return platform_driver_register(&dwc3_omap_driver);
+}
+module_init(dwc3_omap_init);
+
+static void __exit dwc3_omap_exit(void)
+{
+	platform_driver_unregister(&dwc3_omap_driver);
+}
+module_exit(dwc3_omap_exit);
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
new file mode 100644
index 0000000..2578595
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -0,0 +1,219 @@
+/**
+ * dwc3-pci.c - PCI Specific glue layer
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+/* FIXME define these in <linux/pci_ids.h> */
+#define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3	0xabcd
+
+#define DWC3_PCI_DEVS_POSSIBLE	32
+
+struct dwc3_pci {
+	struct device		*dev;
+	struct platform_device	*dwc3;
+};
+
+static DECLARE_BITMAP(dwc3_pci_devs, DWC3_PCI_DEVS_POSSIBLE);
+
+static int dwc3_pci_get_device_id(struct dwc3_pci *glue)
+{
+	int		id;
+
+again:
+	id =3D find_first_zero_bit(dwc3_pci_devs, DWC3_PCI_DEVS_POSSIBLE);
+	if (id < DWC3_PCI_DEVS_POSSIBLE) {
+		int old;
+
+		old =3D test_and_set_bit(id, dwc3_pci_devs);
+		if (old)
+			goto again;
+	} else {
+		dev_err(glue->dev, "no space for new device\n");
+		id =3D -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void dwc3_pci_put_device_id(struct dwc3_pci *glue, int id)
+{
+	int			ret;
+
+	if (id < 0)
+		return;
+
+	ret =3D test_bit(id, dwc3_pci_devs);
+	WARN(!ret, "Device: %s\nID %d not in use\n",
+			dev_driver_string(glue->dev), id);
+	clear_bit(id, dwc3_pci_devs);
+}
+
+static int __devinit dwc3_pci_probe(struct pci_dev *pci,
+		const struct pci_device_id *id)
+{
+	struct resource		res[2];
+	struct platform_device	*dwc3;
+	struct dwc3_pci		*glue;
+	int			ret =3D -ENOMEM;
+	int			devid;
+
+	glue =3D kzalloc(sizeof(*glue), GFP_KERNEL);
+	if (!glue) {
+		dev_err(&pci->dev, "not enough memory\n");
+		goto err0;
+	}
+
+	glue->dev	=3D &pci->dev;
+
+	ret =3D pci_enable_device(pci);
+	if (ret) {
+		dev_err(&pci->dev, "failed to enable pci device\n");
+		goto err1;
+	}
+
+	pci_set_power_state(pci, PCI_D0);
+	pci_set_master(pci);
+
+	devid =3D dwc3_pci_get_device_id(glue);
+	if (devid < 0)
+		goto err2;
+
+	dwc3 =3D platform_device_alloc("dwc3-pci", devid);
+	if (!dwc3) {
+		dev_err(&pci->dev, "couldn't allocate dwc3 device\n");
+		goto err3;
+	}
+
+	memset(res, 0x00, sizeof(struct resource) * ARRAY_SIZE(res));
+
+	res[0].start	=3D pci_resource_start(pci, 0);
+	res[0].end	=3D pci_resource_end(pci, 0);
+	res[0].name	=3D "dwc_usb3";
+	res[0].flags	=3D IORESOURCE_MEM;
+
+	res[1].start	=3D pci->irq;
+	res[1].name	=3D "dwc_usb3";
+	res[1].flags	=3D IORESOURCE_IRQ;
+
+	ret =3D platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
+	if (ret) {
+		dev_err(&pci->dev, "couldn't add resources to dwc3 device\n");
+		goto err4;
+	}
+
+	pci_set_drvdata(pci, glue);
+
+	dma_set_coherent_mask(&dwc3->dev, pci->dev.coherent_dma_mask);
+
+	dwc3->dev.dma_mask =3D pci->dev.dma_mask;
+	dwc3->dev.dma_parms =3D pci->dev.dma_parms;
+	dwc3->dev.parent =3D &pci->dev;
+	glue->dwc3	=3D dwc3;
+
+	ret =3D platform_device_add(dwc3);
+	if (ret) {
+		dev_err(&pci->dev, "failed to register dwc3 device\n");
+		goto err4;
+	}
+
+	return 0;
+
+err4:
+	pci_set_drvdata(pci, NULL);
+	platform_device_put(dwc3);
+
+err3:
+	dwc3_pci_put_device_id(glue, devid);
+
+err2:
+	pci_disable_device(pci);
+
+err1:
+	kfree(pci);
+
+err0:
+	return ret;
+}
+
+static void __devexit dwc3_pci_remove(struct pci_dev *pci)
+{
+	struct dwc3_pci	*glue =3D pci_get_drvdata(pci);
+
+	dwc3_pci_put_device_id(glue, glue->dwc3->id);
+	platform_device_unregister(glue->dwc3);
+	pci_set_drvdata(pci, NULL);
+	pci_disable_device(pci);
+	kfree(glue);
+}
+
+static DEFINE_PCI_DEVICE_TABLE(dwc3_pci_id_table) =3D {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS,
+				PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3),
+	},
+	{  }	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
+
+static struct pci_driver dwc3_pci_driver =3D {
+	.name		=3D "pci-dwc3",
+	.id_table	=3D dwc3_pci_id_table,
+	.probe		=3D dwc3_pci_probe,
+	.remove		=3D __devexit_p(dwc3_pci_remove),
+};
+
+MODULE_AUTHOR("Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("DesignWare USB3 PCI Glue Layer");
+
+static int __devinit dwc3_pci_init(void)
+{
+	return pci_register_driver(&dwc3_pci_driver);
+}
+module_init(dwc3_pci_init);
+
+static void __exit dwc3_pci_exit(void)
+{
+	pci_unregister_driver(&dwc3_pci_driver);
+}
+module_exit(dwc3_pci_exit);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
new file mode 100644
index 0000000..4698fe0
--- /dev/null
+++ b/drivers/usb/dwc3/ep0.c
@@ -0,0 +1,782 @@
+/**
+ * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/dma-mapping.h>
+
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+
+#include "core.h"
+#include "gadget.h"
+#include "io.h"
+
+static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
+		const struct dwc3_event_depevt *event);
+
+static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
+{
+	switch (state) {
+	case EP0_UNCONNECTED:
+		return "Unconnected";
+	case EP0_IDLE:
+		return "Idle";
+	case EP0_IN_DATA_PHASE:
+		return "IN Data Phase";
+	case EP0_OUT_DATA_PHASE:
+		return "OUT Data Phase";
+	case EP0_IN_WAIT_GADGET:
+		return "IN Wait Gadget";
+	case EP0_OUT_WAIT_GADGET:
+		return "OUT Wait Gadget";
+	case EP0_IN_WAIT_NRDY:
+		return "IN Wait NRDY";
+	case EP0_OUT_WAIT_NRDY:
+		return "OUT Wait NRDY";
+	case EP0_IN_STATUS_PHASE:
+		return "IN Status Phase";
+	case EP0_OUT_STATUS_PHASE:
+		return "OUT Status Phase";
+	case EP0_STALL:
+		return "Stall";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t=
 buf_dma,
+		u32 len)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_trb_hw		*trb_hw;
+	struct dwc3_trb			trb;
+	struct dwc3_ep			*dep;
+
+	int				ret;
+
+	dep =3D dwc->eps[epnum];
+
+	trb_hw =3D dwc->ep0_trb;
+	memset(&trb, 0, sizeof(trb));
+
+	switch (dwc->ep0state) {
+	case EP0_IDLE:
+		trb.trbctl =3D DWC3_TRBCTL_CONTROL_SETUP;
+		break;
+
+	case EP0_IN_WAIT_NRDY:
+	case EP0_OUT_WAIT_NRDY:
+	case EP0_IN_STATUS_PHASE:
+	case EP0_OUT_STATUS_PHASE:
+		if (dwc->three_stage_setup)
+			trb.trbctl =3D DWC3_TRBCTL_CONTROL_STATUS3;
+		else
+			trb.trbctl =3D DWC3_TRBCTL_CONTROL_STATUS2;
+
+		if (dwc->ep0state =3D=3D EP0_IN_WAIT_NRDY)
+			dwc->ep0state =3D EP0_IN_STATUS_PHASE;
+		else if (dwc->ep0state =3D=3D EP0_OUT_WAIT_NRDY)
+			dwc->ep0state =3D EP0_OUT_STATUS_PHASE;
+		break;
+
+	case EP0_IN_WAIT_GADGET:
+		dwc->ep0state =3D EP0_IN_WAIT_NRDY;
+		return 0;
+		break;
+
+	case EP0_OUT_WAIT_GADGET:
+		dwc->ep0state =3D EP0_OUT_WAIT_NRDY;
+		return 0;
+
+		break;
+
+	case EP0_IN_DATA_PHASE:
+	case EP0_OUT_DATA_PHASE:
+		trb.trbctl =3D DWC3_TRBCTL_CONTROL_DATA;
+		break;
+
+	default:
+		dev_err(dwc->dev, "%s() can't in state %d\n", __func__,
+				dwc->ep0state);
+		return -EINVAL;
+	}
+
+	trb.bplh =3D buf_dma;
+	trb.length =3D len;
+
+	trb.hwo	=3D 1;
+	trb.lst	=3D 1;
+	trb.ioc	=3D 1;
+	trb.isp_imi =3D 1;
+
+	dwc3_trb_to_hw(&trb, trb_hw);
+
+	memset(&params, 0, sizeof(params));
+	params.param0.depstrtxfer.transfer_desc_addr_high =3D
+		upper_32_bits(dwc->ep0_trb_addr);
+	params.param1.depstrtxfer.transfer_desc_addr_low =3D
+		lower_32_bits(dwc->ep0_trb_addr);
+
+	ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number,
+			DWC3_DEPCMD_STARTTRANSFER, &params);
+	if (ret < 0) {
+		dev_dbg(dwc->dev, "failed to send STARTTRANSFER command\n");
+		return ret;
+	}
+
+	dep->res_trans_idx =3D dwc3_gadget_ep_get_transfer_index(dwc,
+			dep->number);
+
+	return 0;
+}
+
+static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
+		struct dwc3_request *req)
+{
+	struct dwc3		*dwc =3D dep->dwc;
+	int			ret;
+
+	req->request.actual	=3D 0;
+	req->request.status	=3D -EINPROGRESS;
+	req->direction		=3D dep->direction;
+	req->epnum		=3D dep->number;
+
+	list_add_tail(&req->list, &dep->request_list);
+	dwc3_map_buffer_to_dma(req);
+
+	ret =3D dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
+			req->request.length);
+	if (ret < 0) {
+		list_del(&req->list);
+		dwc3_unmap_buffer_from_dma(req);
+	}
+
+	return ret;
+}
+
+int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *reque=
st,
+		gfp_t gfp_flags)
+{
+	struct dwc3_request		*req =3D to_dwc3_request(request);
+	struct dwc3_ep			*dep =3D to_dwc3_ep(ep);
+	struct dwc3			*dwc =3D dep->dwc;
+
+	unsigned long			flags;
+
+	int				ret;
+
+	switch (dwc->ep0state) {
+	case EP0_IN_DATA_PHASE:
+	case EP0_IN_WAIT_GADGET:
+	case EP0_IN_WAIT_NRDY:
+	case EP0_IN_STATUS_PHASE:
+		dep =3D dwc->eps[1];
+		break;
+
+	case EP0_OUT_DATA_PHASE:
+	case EP0_OUT_WAIT_GADGET:
+	case EP0_OUT_WAIT_NRDY:
+	case EP0_OUT_STATUS_PHASE:
+		dep =3D dwc->eps[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dep->desc) {
+		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s\n",
+				request, dep->name);
+		ret =3D -ESHUTDOWN;
+		goto out;
+	}
+
+	/* we share one TRB for ep0/1 */
+	if (!list_empty(&dwc->eps[0]->request_list) ||
+			!list_empty(&dwc->eps[1]->request_list) ||
+			dwc->ep0_status_pending) {
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	dev_vdbg(dwc->dev, "queueing request %p to %s length %d, state '%s'\n=
",
+			request, dep->name, request->length,
+			dwc3_ep0_state_string(dwc->ep0state));
+
+	ret =3D __dwc3_gadget_ep0_queue(dep, req);
+
+out:
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
+{
+	/* stall is always issued on EP0 */
+	__dwc3_gadget_ep_set_halt(dwc->eps[0], 1);
+	dwc->eps[0]->flags &=3D ~DWC3_EP_STALL;
+	dwc->ep0state =3D EP0_IDLE;
+	dwc3_ep0_out_start(dwc);
+}
+
+void dwc3_ep0_out_start(struct dwc3 *dwc)
+{
+	struct dwc3_ep			*dep;
+	int				ret;
+
+	dep =3D dwc->eps[0];
+
+	ret =3D dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8);
+	WARN_ON(ret < 0);
+}
+
+/*
+ * Send a zero length packet for the status phase of the control trans=
fer
+ */
+static void dwc3_ep0_do_setup_status(struct dwc3 *dwc,
+		const struct dwc3_event_depevt *event)
+{
+	struct dwc3_ep			*dep;
+	int				ret;
+	u32				epnum;
+
+	epnum =3D event->endpoint_number;
+	dep =3D dwc->eps[epnum];
+
+	if (epnum)
+		dwc->ep0state =3D EP0_IN_STATUS_PHASE;
+	else
+		dwc->ep0state =3D EP0_OUT_STATUS_PHASE;
+
+	/*
+	 * Not sure Why I need a buffer for a zero transfer. Maybe the
+	 * HW reacts strange on a NULL pointer
+	 */
+	ret =3D dwc3_ep0_start_trans(dwc, epnum, dwc->ctrl_req_addr, 0);
+	if (ret) {
+		dev_dbg(dwc->dev, "failed to start transfer, stalling\n");
+		dwc3_ep0_stall_and_restart(dwc);
+	}
+}
+
+static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIn=
dex_le)
+{
+	struct dwc3_ep		*dep;
+	u32			windex =3D le16_to_cpu(wIndex_le);
+	u32			epnum;
+
+	epnum =3D (windex & USB_ENDPOINT_NUMBER_MASK) << 1;
+	if ((windex & USB_ENDPOINT_DIR_MASK) =3D=3D USB_DIR_IN)
+		epnum |=3D 1;
+
+	dep =3D dwc->eps[epnum];
+	if (dep->flags & DWC3_EP_ENABLED)
+		return dep;
+
+	return NULL;
+}
+
+static void dwc3_ep0_send_status_response(struct dwc3 *dwc)
+{
+	u32 epnum;
+
+	if (dwc->ep0state =3D=3D EP0_IN_DATA_PHASE)
+		epnum =3D 1;
+	else
+		epnum =3D 0;
+
+	dwc3_ep0_start_trans(dwc, epnum, dwc->ctrl_req_addr,
+			dwc->ep0_usb_req.length);
+	dwc->ep0_status_pending =3D 1;
+}
+
+/*
+ * ch 9.4.5
+ */
+static int dwc3_ep0_handle_status(struct dwc3 *dwc, struct usb_ctrlreq=
uest *ctrl)
+{
+	struct dwc3_ep		*dep;
+	u32			recip;
+	u16			usb_status =3D 0;
+	__le16			*response_pkt;
+
+	recip =3D ctrl->bRequestType & USB_RECIP_MASK;
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		/*
+		 * We are self-powered. U1/U2/LTM will be set later
+		 * once we handle this states. RemoteWakeup is 0 on SS
+		 */
+		usb_status |=3D dwc->is_selfpowered << USB_DEVICE_SELF_POWERED;
+		break;
+
+	case USB_RECIP_INTERFACE:
+		/*
+		 * Function Remote Wake Capable	D0
+		 * Function Remote Wakeup	D1
+		 */
+		break;
+
+	case USB_RECIP_ENDPOINT:
+		dep =3D dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
+		if (!dep)
+		       return -EINVAL;
+
+		if (dep->flags & DWC3_EP_STALL)
+			usb_status =3D 1 << USB_ENDPOINT_HALT;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	response_pkt =3D (__le16 *) dwc->setup_buf;
+	*response_pkt =3D cpu_to_le16(usb_status);
+	dwc->ep0_usb_req.length =3D sizeof(*response_pkt);
+	dwc3_ep0_send_status_response(dwc);
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	struct dwc3_ep		*dep;
+	u32			recip;
+	u32			wValue;
+	u32			wIndex;
+	u32			reg;
+	int			ret;
+	u32			mode;
+
+	wValue =3D le16_to_cpu(ctrl->wValue);
+	wIndex =3D le16_to_cpu(ctrl->wIndex);
+	recip =3D ctrl->bRequestType & USB_RECIP_MASK;
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+
+		/*
+		 * 9.4.1 says only only for SS, in AddressState only for
+		 * default control pipe
+		 */
+		switch (wValue) {
+		case USB_DEVICE_U1_ENABLE:
+		case USB_DEVICE_U2_ENABLE:
+		case USB_DEVICE_LTM_ENABLE:
+			if (dwc->dev_state !=3D DWC3_CONFIGURED_STATE)
+				return -EINVAL;
+			if (dwc->speed !=3D DWC3_DSTS_SUPERSPEED)
+				return -EINVAL;
+		}
+
+		/* XXX add U[12] & LTM */
+		switch (wValue) {
+		case USB_DEVICE_REMOTE_WAKEUP:
+			break;
+		case USB_DEVICE_U1_ENABLE:
+			break;
+		case USB_DEVICE_U2_ENABLE:
+			break;
+		case USB_DEVICE_LTM_ENABLE:
+			break;
+
+		case USB_DEVICE_TEST_MODE:
+			if ((wIndex & 0xff) !=3D 0)
+				return -EINVAL;
+			if (!set)
+				return -EINVAL;
+
+			mode =3D wIndex >> 8;
+			reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
+			reg &=3D ~DWC3_DCTL_TSTCTRL_MASK;
+
+			switch (mode) {
+			case TEST_J:
+			case TEST_K:
+			case TEST_SE0_NAK:
+			case TEST_PACKET:
+			case TEST_FORCE_EN:
+				reg |=3D mode << 1;
+				break;
+			default:
+				return -EINVAL;
+			}
+			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case USB_RECIP_INTERFACE:
+		switch (wValue) {
+		case USB_INTRF_FUNC_SUSPEND:
+			if (wIndex & USB_INTRF_FUNC_SUSPEND_LP)
+				/* XXX enable Low power suspend */
+				;
+			if (wIndex & USB_INTRF_FUNC_SUSPEND_RW)
+				/* XXX enable remote wakeup */
+				;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case USB_RECIP_ENDPOINT:
+		switch (wValue) {
+		case USB_ENDPOINT_HALT:
+
+			dep =3D  dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
+			if (!dep)
+				return -EINVAL;
+			ret =3D __dwc3_gadget_ep_set_halt(dep, set);
+			if (ret)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	};
+
+	dwc->ep0state =3D EP0_IN_WAIT_NRDY;
+
+	return 0;
+}
+
+static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlreque=
st *ctrl)
+{
+	int ret =3D 0;
+	u32 addr;
+	u32 reg;
+
+	addr =3D le16_to_cpu(ctrl->wValue);
+	if (addr > 127)
+		return -EINVAL;
+
+	switch (dwc->dev_state) {
+	case DWC3_DEFAULT_STATE:
+	case DWC3_ADDRESS_STATE:
+		/*
+		 * Not sure if we should program DevAddr now or later
+		 */
+		reg =3D dwc3_readl(dwc->regs, DWC3_DCFG);
+		reg &=3D ~(DWC3_DCFG_DEVADDR_MASK);
+		reg |=3D DWC3_DCFG_DEVADDR(addr);
+		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
+		if (addr)
+			dwc->dev_state =3D DWC3_ADDRESS_STATE;
+		else
+			dwc->dev_state =3D DWC3_DEFAULT_STATE;
+		break;
+
+	case DWC3_CONFIGURED_STATE:
+		ret =3D -EINVAL;
+		break;
+	}
+	dwc->ep0state =3D EP0_IN_WAIT_NRDY;
+	return ret;
+}
+
+static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequ=
est *ctrl)
+{
+	int ret;
+
+	spin_unlock(&dwc->lock);
+	ret =3D dwc->gadget_driver->setup(&dwc->gadget, ctrl);
+	spin_lock(&dwc->lock);
+	return ret;
+}
+
+static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlreques=
t *ctrl)
+{
+	u32 cfg;
+	int ret;
+
+	cfg =3D le16_to_cpu(ctrl->wValue);
+
+	switch (dwc->dev_state) {
+	case DWC3_DEFAULT_STATE:
+		return -EINVAL;
+		break;
+
+	case DWC3_ADDRESS_STATE:
+		ret =3D dwc3_ep0_delegate_req(dwc, ctrl);
+		/* if the cfg matches and the cfg is non zero */
+		if (!ret && cfg)
+			dwc->dev_state =3D DWC3_CONFIGURED_STATE;
+		break;
+
+	case DWC3_CONFIGURED_STATE:
+		ret =3D dwc3_ep0_delegate_req(dwc, ctrl);
+		if (!cfg)
+			dwc->dev_state =3D DWC3_ADDRESS_STATE;
+		break;
+	}
+	return 0;
+}
+
+static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlreque=
st *ctrl)
+{
+	int ret;
+
+	switch (ctrl->bRequest) {
+	case USB_REQ_GET_STATUS:
+		dev_vdbg(dwc->dev, "USB_REQ_GET_STATUS\n");
+		ret =3D dwc3_ep0_handle_status(dwc, ctrl);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+		dev_vdbg(dwc->dev, "USB_REQ_CLEAR_FEATURE\n");
+		ret =3D dwc3_ep0_handle_feature(dwc, ctrl, 0);
+		break;
+	case USB_REQ_SET_FEATURE:
+		dev_vdbg(dwc->dev, "USB_REQ_SET_FEATURE\n");
+		ret =3D dwc3_ep0_handle_feature(dwc, ctrl, 1);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		dev_vdbg(dwc->dev, "USB_REQ_SET_ADDRESS\n");
+		ret =3D dwc3_ep0_set_address(dwc, ctrl);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		dev_vdbg(dwc->dev, "USB_REQ_SET_CONFIGURATION\n");
+		ret =3D dwc3_ep0_set_config(dwc, ctrl);
+		break;
+	default:
+		dev_vdbg(dwc->dev, "Forwarding to gadget driver\n");
+		ret =3D dwc3_ep0_delegate_req(dwc, ctrl);
+		break;
+	};
+
+	return ret;
+}
+
+static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
+		const struct dwc3_event_depevt *event)
+{
+	struct usb_ctrlrequest *ctrl =3D dwc->ctrl_req;
+	int ret;
+	u32 len;
+
+	if (!dwc->gadget_driver)
+		goto err;
+
+	len =3D le16_to_cpu(ctrl->wLength);
+	if (!len) {
+		dwc->ep0state =3D EP0_IN_WAIT_GADGET;
+		dwc->three_stage_setup =3D 0;
+	} else {
+		dwc->three_stage_setup =3D 1;
+		if (ctrl->bRequestType & USB_DIR_IN)
+			dwc->ep0state =3D EP0_IN_DATA_PHASE;
+		else
+			dwc->ep0state =3D EP0_OUT_DATA_PHASE;
+	}
+
+	if ((ctrl->bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDARD)
+		ret =3D dwc3_ep0_std_request(dwc, ctrl);
+	else
+		ret =3D dwc3_ep0_delegate_req(dwc, ctrl);
+
+	if (ret >=3D 0)
+		return;
+
+err:
+	dwc3_ep0_stall_and_restart(dwc);
+}
+
+static void dwc3_ep0_complete_data(struct dwc3 *dwc,
+		const struct dwc3_event_depevt *event)
+{
+	struct dwc3_request	*r =3D NULL;
+	struct usb_request	*ur;
+	struct dwc3_trb		trb;
+	struct dwc3_ep		*dep;
+	u32			transfered;
+	u8			epnum;
+
+	epnum =3D event->endpoint_number;
+	dep =3D dwc->eps[epnum];
+
+	if (!dwc->ep0_status_pending) {
+		r =3D next_request(&dep->request_list);
+		ur =3D &r->request;
+	} else {
+		ur =3D &dwc->ep0_usb_req;
+		dwc->ep0_status_pending =3D 0;
+	}
+
+	dwc3_trb_to_nat(dwc->ep0_trb, &trb);
+
+	transfered =3D ur->length - trb.length;
+	ur->actual +=3D transfered;
+
+	if ((epnum & 1) && ur->actual < ur->length) {
+		/* for some reason we did not get everything out */
+
+		dwc3_ep0_stall_and_restart(dwc);
+		dwc3_gadget_giveback(dep, r, -ECONNRESET);
+	} else {
+		/*
+		 * handle the case where we have to send a zero packet. This
+		 * seems to be case when req.length > maxpacket. Could it be?
+		 */
+		/* The transfer is complete, wait for HOST */
+		if (epnum & 1)
+			dwc->ep0state =3D EP0_IN_WAIT_NRDY;
+		else
+			dwc->ep0state =3D EP0_OUT_WAIT_NRDY;
+
+		if (r)
+			dwc3_gadget_giveback(dep, r, 0);
+	}
+}
+
+static void dwc3_ep0_complete_req(struct dwc3 *dwc,
+		const struct dwc3_event_depevt *event)
+{
+	struct dwc3_request	*r;
+	struct dwc3_ep		*dep;
+	u8			epnum;
+
+	epnum =3D event->endpoint_number;
+	dep =3D dwc->eps[epnum];
+
+	if (!list_empty(&dep->request_list)) {
+		r =3D next_request(&dep->request_list);
+
+		dwc3_gadget_giveback(dep, r, 0);
+	}
+
+	dwc->ep0state =3D EP0_IDLE;
+	dwc3_ep0_out_start(dwc);
+}
+
+static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
+			const struct dwc3_event_depevt *event)
+{
+	switch (dwc->ep0state) {
+	case EP0_IDLE:
+		dwc3_ep0_inspect_setup(dwc, event);
+		break;
+
+	case EP0_IN_DATA_PHASE:
+	case EP0_OUT_DATA_PHASE:
+		dwc3_ep0_complete_data(dwc, event);
+		break;
+
+	case EP0_IN_STATUS_PHASE:
+	case EP0_OUT_STATUS_PHASE:
+		dwc3_ep0_complete_req(dwc, event);
+		break;
+
+	case EP0_IN_WAIT_NRDY:
+	case EP0_OUT_WAIT_NRDY:
+	case EP0_IN_WAIT_GADGET:
+	case EP0_OUT_WAIT_GADGET:
+	case EP0_UNCONNECTED:
+	case EP0_STALL:
+		break;
+	}
+}
+
+static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
+		const struct dwc3_event_depevt *event)
+{
+	switch (dwc->ep0state) {
+	case EP0_IN_WAIT_GADGET:
+		dwc->ep0state =3D EP0_IN_WAIT_NRDY;
+		break;
+	case EP0_OUT_WAIT_GADGET:
+		dwc->ep0state =3D EP0_OUT_WAIT_NRDY;
+		break;
+
+	case EP0_IN_WAIT_NRDY:
+	case EP0_OUT_WAIT_NRDY:
+		dwc3_ep0_do_setup_status(dwc, event);
+		break;
+
+	case EP0_IDLE:
+	case EP0_IN_STATUS_PHASE:
+	case EP0_OUT_STATUS_PHASE:
+	case EP0_IN_DATA_PHASE:
+	case EP0_OUT_DATA_PHASE:
+	case EP0_UNCONNECTED:
+	case EP0_STALL:
+		break;
+	}
+}
+
+void dwc3_ep0_interrupt(struct dwc3 *dwc,
+		const const struct dwc3_event_depevt *event)
+{
+	u8			epnum =3D event->endpoint_number;
+
+	dev_dbg(dwc->dev, "%s while ep%d%s in state '%s'\n",
+			dwc3_ep_event_string(event->endpoint_event),
+			epnum, (epnum & 1) ? "in" : "out",
+			dwc3_ep0_state_string(dwc->ep0state));
+
+	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		dwc3_ep0_xfer_complete(dwc, event);
+		break;
+
+	case DWC3_DEPEVT_XFERNOTREADY:
+		dwc3_ep0_xfernotready(dwc, event);
+		break;
+
+	case DWC3_DEPEVT_XFERINPROGRESS:
+	case DWC3_DEPEVT_RXTXFIFOEVT:
+	case DWC3_DEPEVT_STREAMEVT:
+	case DWC3_DEPEVT_EPCMDCMPLT:
+		break;
+	}
+}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
new file mode 100644
index 0000000..de5f0af
--- /dev/null
+++ b/drivers/usb/dwc3/gadget.c
@@ -0,0 +1,2063 @@
+/**
+ * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/dma-mapping.h>
+
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+
+#include "core.h"
+#include "gadget.h"
+#include "io.h"
+
+#define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
+
+void dwc3_map_buffer_to_dma(struct dwc3_request *req)
+{
+	struct dwc3			*dwc =3D req->dep->dwc;
+
+	if (req->request.dma =3D=3D DMA_ADDR_INVALID) {
+		req->request.dma =3D dma_map_single(dwc->dev, req->request.buf,
+				req->request.length, req->direction
+				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		req->mapped =3D true;
+	} else {
+		dma_sync_single_for_device(dwc->dev, req->request.dma,
+				req->request.length, req->direction
+				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		req->mapped =3D false;
+	}
+}
+
+void dwc3_unmap_buffer_from_dma(struct dwc3_request *req)
+{
+	struct dwc3			*dwc =3D req->dep->dwc;
+
+	if (req->mapped) {
+		dma_unmap_single(dwc->dev, req->request.dma,
+				req->request.length, req->direction
+				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		req->mapped =3D 0;
+	} else {
+		dma_sync_single_for_cpu(dwc->dev, req->request.dma,
+				req->request.length, req->direction
+				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	}
+}
+
+void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *re=
q,
+		int status)
+{
+	struct dwc3			*dwc =3D dep->dwc;
+
+	if (req->queued) {
+		dep->busy_slot++;
+		/*
+		 * Skip LINK TRB. We can't use req->trb and check for
+		 * DWC3_TRBCTL_LINK_TRB because it points the TRB we just
+		 * completed (not the LINK TRB).
+		 */
+		if (((dep->busy_slot & DWC3_TRB_MASK) =3D=3D DWC3_TRB_NUM - 1) &&
+				usb_endpoint_xfer_isoc(dep->desc))
+			dep->busy_slot++;
+	}
+	list_del(&req->list);
+
+	if (req->request.status =3D=3D -EINPROGRESS)
+		req->request.status =3D status;
+
+	dwc3_unmap_buffer_from_dma(req);
+
+	dev_dbg(dwc->dev, "request %p from %s completed %d/%d =3D=3D=3D> %d\n=
",
+			req, dep->name, req->request.actual,
+			req->request.length, status);
+
+	spin_unlock(&dwc->lock);
+	req->request.complete(&req->dep->endpoint, &req->request);
+	spin_lock(&dwc->lock);
+}
+
+static const char *dwc3_gadget_ep_cmd_string(u8 cmd)
+{
+	switch (cmd) {
+	case DWC3_DEPCMD_DEPSTARTCFG:
+		return "Start New Configuration";
+	case DWC3_DEPCMD_ENDTRANSFER:
+		return "End Transfer";
+	case DWC3_DEPCMD_UPDATETRANSFER:
+		return "Update Transfer";
+	case DWC3_DEPCMD_STARTTRANSFER:
+		return "Start Transfer";
+	case DWC3_DEPCMD_CLEARSTALL:
+		return "Clear Stall";
+	case DWC3_DEPCMD_SETSTALL:
+		return "Set Stall";
+	case DWC3_DEPCMD_GETSEQNUMBER:
+		return "Get Data Sequence Number";
+	case DWC3_DEPCMD_SETTRANSFRESOURCE:
+		return "Set Endpoint Transfer Resource";
+	case DWC3_DEPCMD_SETEPCONFIG:
+		return "Set Endpoint Configuration";
+	default:
+		return "UNKNOWN command";
+	}
+}
+
+int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
+		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
+{
+	struct dwc3_ep		*dep =3D dwc->eps[ep];
+	unsigned long		timeout =3D 500;
+	u32			reg;
+
+	dev_vdbg(dwc->dev, "%s: cmd '%s' params %08x %08x %08x\n",
+			dep->name,
+			dwc3_gadget_ep_cmd_string(cmd), params->param0.raw,
+			params->param1.raw, params->param2.raw);
+
+	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0.raw);
+	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1.raw);
+	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR2(ep), params->param2.raw);
+
+	dwc3_writel(dwc->regs, DWC3_DEPCMD(ep), cmd | DWC3_DEPCMD_CMDACT);
+	do {
+		reg =3D dwc3_readl(dwc->regs, DWC3_DEPCMD(ep));
+		if (!(reg & DWC3_DEPCMD_CMDACT)) {
+			dev_vdbg(dwc->dev, "CMD Compl Status %d DEPCMD %04x\n",
+					((reg & 0xf000) >> 12), reg);
+			return 0;
+		}
+
+		/*
+		 * XXX Figure out a sane timeout here. 500ms is way too much.
+		 * We can't sleep here, because it is also called from
+		 * interrupt context.
+		 */
+		timeout--;
+		if (!timeout)
+			return -ETIMEDOUT;
+
+		mdelay(1);
+	} while (1);
+}
+
+static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
+		struct dwc3_trb_hw *trb)
+{
+	u32		offset =3D trb - dep->trb_pool;
+
+	return dep->trb_pool_dma + offset;
+}
+
+static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
+{
+	struct dwc3		*dwc =3D dep->dwc;
+
+	if (dep->trb_pool)
+		return 0;
+
+	if (dep->number =3D=3D 0 || dep->number =3D=3D 1)
+		return 0;
+
+	dep->trb_pool =3D dma_alloc_coherent(dwc->dev,
+			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+			&dep->trb_pool_dma, GFP_KERNEL);
+	if (!dep->trb_pool) {
+		dev_err(dep->dwc->dev, "failed to allocate trb pool for %s\n",
+				dep->name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void dwc3_free_trb_pool(struct dwc3_ep *dep)
+{
+	struct dwc3		*dwc =3D dep->dwc;
+
+	dma_free_coherent(dwc->dev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+			dep->trb_pool, dep->trb_pool_dma);
+
+	dep->trb_pool =3D NULL;
+	dep->trb_pool_dma =3D 0;
+}
+
+static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *=
dep)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	u32			cmd;
+
+	memset(&params, 0x00, sizeof(params));
+
+	if (dep->number !=3D 1) {
+		cmd =3D DWC3_DEPCMD_DEPSTARTCFG;
+		/* XferRscIdx =3D=3D 0 for ep0 and 2 for the remaining */
+		if (dep->number > 1)
+			cmd |=3D DWC3_DEPCMD_PARAM(2);
+
+		return dwc3_send_gadget_ep_cmd(dwc, 0, cmd, &params);
+	}
+
+	return 0;
+}
+
+static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep =
*dep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+
+	memset(&params, 0x00, sizeof(params));
+
+	params.param0.depcfg.ep_type =3D usb_endpoint_type(desc);
+	params.param0.depcfg.max_packet_size =3D
+		le16_to_cpu(desc->wMaxPacketSize);
+
+	params.param1.depcfg.xfer_complete_enable =3D true;
+	params.param1.depcfg.xfer_not_ready_enable =3D true;
+
+	if (usb_endpoint_xfer_isoc(desc))
+		params.param1.depcfg.xfer_in_progress_enable =3D true;
+
+	/*
+	 * We are doing 1:1 mapping for endpoints, meaning
+	 * Physical Endpoints 2 maps to Logical Endpoint 2 and
+	 * so on. We consider the direction bit as part of the physical
+	 * endpoint number. So USB endpoint 0x81 is 0x03.
+	 */
+	params.param1.depcfg.ep_number =3D dep->number;
+
+	/*
+	 * We must use the lower 16 TX FIFOs even though
+	 * HW might have more
+	 */
+	if (dep->direction)
+		params.param0.depcfg.fifo_number =3D dep->number >> 1;
+
+	if (desc->bInterval) {
+		params.param1.depcfg.binterval_m1 =3D desc->bInterval - 1;
+		dep->interval =3D 1 << (desc->bInterval - 1);
+	}
+
+	return dwc3_send_gadget_ep_cmd(dwc, dep->number,
+			DWC3_DEPCMD_SETEPCONFIG, &params);
+}
+
+static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3=
_ep *dep)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+
+	memset(&params, 0x00, sizeof(params));
+
+	params.param0.depxfercfg.number_xfer_resources =3D 1;
+
+	return dwc3_send_gadget_ep_cmd(dwc, dep->number,
+			DWC3_DEPCMD_SETTRANSFRESOURCE, &params);
+}
+
+/**
+ * __dwc3_gadget_ep_enable - Initializes a HW endpoint
+ * @dep: endpoint to be initialized
+ * @desc: USB Endpoint Descriptor
+ *
+ * Caller should take care of locking
+ */
+static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	struct dwc3		*dwc =3D dep->dwc;
+	u32			reg;
+	int			ret =3D -ENOMEM;
+
+	if (!(dep->flags & DWC3_EP_ENABLED)) {
+		ret =3D dwc3_gadget_start_config(dwc, dep);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D dwc3_gadget_set_ep_config(dwc, dep, desc);
+	if (ret)
+		return ret;
+
+	if (!(dep->flags & DWC3_EP_ENABLED)) {
+		struct dwc3_trb_hw	*trb_st_hw;
+		struct dwc3_trb_hw	*trb_link_hw;
+		struct dwc3_trb		trb_link;
+
+		ret =3D dwc3_gadget_set_xfer_resource(dwc, dep);
+		if (ret)
+			return ret;
+
+		dep->desc =3D desc;
+		dep->type =3D usb_endpoint_type(desc);
+		dep->flags |=3D DWC3_EP_ENABLED;
+
+		reg =3D dwc3_readl(dwc->regs, DWC3_DALEPENA);
+		reg |=3D DWC3_DALEPENA_EP(dep->number);
+		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
+
+		if (!usb_endpoint_xfer_isoc(desc))
+			return 0;
+
+		memset(&trb_link, 0, sizeof(trb_link));
+
+		/* Link TRB for ISOC. The HWO but is never reset */
+		trb_st_hw =3D &dep->trb_pool[0];
+
+		trb_link.bplh =3D dwc3_trb_dma_offset(dep, trb_st_hw);
+		trb_link.trbctl =3D DWC3_TRBCTL_LINK_TRB;
+		trb_link.hwo =3D true;
+
+		trb_link_hw =3D &dep->trb_pool[DWC3_TRB_NUM - 1];
+		dwc3_trb_to_hw(&trb_link, trb_link_hw);
+	}
+
+	return 0;
+}
+
+static void dwc3_gadget_nuke_reqs(struct dwc3_ep *dep, const int statu=
s)
+{
+	struct dwc3_request		*req;
+
+	while (!list_empty(&dep->request_list)) {
+		req =3D next_request(&dep->request_list);
+
+		dwc3_gadget_giveback(dep, req, status);
+	}
+	/* nuke queued TRBs as well on command complete */
+	dep->flags |=3D DWC3_EP_WILL_SHUTDOWN;
+}
+
+/**
+ * __dwc3_gadget_ep_disable - Disables a HW endpoint
+ * @dep: the endpoint to disable
+ *
+ * Caller should take care of locking
+ */
+static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum);
+static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
+{
+	struct dwc3		*dwc =3D dep->dwc;
+	u32			reg;
+
+	dep->flags &=3D ~DWC3_EP_ENABLED;
+	dwc3_stop_active_transfer(dwc, dep->number);
+	dwc3_gadget_nuke_reqs(dep, -ESHUTDOWN);
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_DALEPENA);
+	reg &=3D ~DWC3_DALEPENA_EP(dep->number);
+	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
+
+	dep->desc =3D NULL;
+	dep->type =3D 0;
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------=
------- */
+
+static int dwc3_gadget_ep0_enable(struct usb_ep *ep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	return -EINVAL;
+}
+
+static int dwc3_gadget_ep0_disable(struct usb_ep *ep)
+{
+	return -EINVAL;
+}
+
+/* -------------------------------------------------------------------=
------- */
+
+static int dwc3_gadget_ep_enable(struct usb_ep *ep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
+	unsigned long			flags;
+	int				ret;
+
+	if (!ep || !desc || desc->bDescriptorType !=3D USB_DT_ENDPOINT) {
+		pr_debug("dwc3: invalid parameters\n");
+		return -EINVAL;
+	}
+
+	if (!desc->wMaxPacketSize) {
+		pr_debug("dwc3: missing wMaxPacketSize\n");
+		return -EINVAL;
+	}
+
+	dep =3D to_dwc3_ep(ep);
+	dwc =3D dep->dwc;
+
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		strncat(dep->name, "-control", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		strncat(dep->name, "-isoc", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		strncat(dep->name, "-bulk", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		strncat(dep->name, "-int", sizeof(dep->name));
+		break;
+	default:
+		dev_err(dwc->dev, "invalid endpoint transfer type\n");
+	}
+
+	if (dep->flags & DWC3_EP_ENABLED) {
+		dev_WARN_ONCE(dwc->dev, true, "%s is already enabled\n",
+				dep->name);
+		return 0;
+	}
+
+	dev_vdbg(dwc->dev, "Enabling %s\n", dep->name);
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	ret =3D __dwc3_gadget_ep_enable(dep, desc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static int dwc3_gadget_ep_disable(struct usb_ep *ep)
+{
+	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
+	unsigned long			flags;
+	int				ret;
+
+	if (!ep) {
+		pr_debug("dwc3: invalid parameters\n");
+		return -EINVAL;
+	}
+
+	dep =3D to_dwc3_ep(ep);
+	dwc =3D dep->dwc;
+
+	if (!(dep->flags & DWC3_EP_ENABLED)) {
+		dev_WARN_ONCE(dwc->dev, true, "%s is already disabled\n",
+				dep->name);
+		return 0;
+	}
+
+	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
+			dep->number >> 1,
+			(dep->number & 1) ? "in" : "out");
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	ret =3D __dwc3_gadget_ep_disable(dep);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep =
*ep,
+	gfp_t gfp_flags)
+{
+	struct dwc3_request		*req;
+	struct dwc3_ep			*dep =3D to_dwc3_ep(ep);
+	struct dwc3			*dwc =3D dep->dwc;
+
+	req =3D kzalloc(sizeof(*req), gfp_flags);
+	if (!req) {
+		dev_err(dwc->dev, "not enough memory\n");
+		return NULL;
+	}
+
+	req->epnum	=3D dep->number;
+	req->dep	=3D dep;
+	req->request.dma =3D DMA_ADDR_INVALID;
+
+	return &req->request;
+}
+
+static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
+		struct usb_request *request)
+{
+	struct dwc3_request		*req =3D to_dwc3_request(request);
+
+	kfree(req);
+}
+
+/*
+ * dwc3_prepare_trbs - setup TRBs from requests
+ * @dep: endpoint for which requests are being prepared
+ * @starting: true if the endpoint is idle and no requests are queued.
+ *
+ * The functions goes through the requests list and setups TRBs for th=
e
+ * transfers. The functions returns once there are not more TRBs avail=
able or
+ * it run out of requests.
+ */
+static struct dwc3_request *dwc3_prepare_trbs(struct dwc3_ep *dep,
+		bool starting)
+{
+	struct dwc3_request	*req, *n, *ret =3D NULL;
+	struct dwc3_trb_hw	*trb_hw;
+	struct dwc3_trb		trb;
+	u32			trbs_left;
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
+
+	/* the first request must not be queued */
+	trbs_left =3D (dep->busy_slot - dep->free_slot) & DWC3_TRB_MASK;
+	/*
+	 * if busy & slot are equal than it is either full or empty. If we ar=
e
+	 * starting to proceed requests then we are empty. Otherwise we ar
+	 * full and don't do anything
+	 */
+	if (!trbs_left) {
+		if (!starting)
+			return NULL;
+		trbs_left =3D DWC3_TRB_NUM;
+		/*
+		 * In case we start from scratch, we queue the ISOC requests
+		 * starting from slot 1. This is done because we use ring
+		 * buffer and have no LST bit to stop us. Instead, we place
+		 * IOC bit TRB_NUM/4. We try to avoid to having an interrupt
+		 * after the first request so we start at slot 1 and have
+		 * 7 requests proceed before we hit the first IOC.
+		 * Other transfer types don't use the ring buffer and are
+		 * processed from the first TRB until the last one. Since we
+		 * don't wrap around we have to start at the beginning.
+		 */
+		if (usb_endpoint_xfer_isoc(dep->desc)) {
+			dep->busy_slot =3D 1;
+			dep->free_slot =3D 1;
+		} else {
+			dep->busy_slot =3D 0;
+			dep->free_slot =3D 0;
+		}
+	}
+
+	/* The last TRB is a link TRB, not used for xfer */
+	if ((trbs_left <=3D 1) && usb_endpoint_xfer_isoc(dep->desc))
+		return NULL;
+
+	list_for_each_entry_safe(req, n, &dep->request_list, list) {
+		unsigned int last_one =3D 0;
+		unsigned int cur_slot;
+
+		trb_hw =3D &dep->trb_pool[dep->free_slot & DWC3_TRB_MASK];
+		cur_slot =3D dep->free_slot;
+		dep->free_slot++;
+
+		/* Skip the LINK-TRB on ISOC */
+		if (((cur_slot & DWC3_TRB_MASK) =3D=3D DWC3_TRB_NUM - 1) &&
+				usb_endpoint_xfer_isoc(dep->desc))
+			continue;
+
+		dwc3_gadget_move_request_queued(req);
+		memset(&trb, 0, sizeof(trb));
+		trbs_left--;
+
+		/* Is our TRB pool empty? */
+		if (!trbs_left)
+			last_one =3D 1;
+		/* Is this the last request? */
+		if (list_empty(&dep->request_list))
+			last_one =3D 1;
+
+		/*
+		 * FIXME we shouldn't need to set LST bit always but we are
+		 * facing some weird problem with the Hardware where it doesn't
+		 * complete even though it has been previously started.
+		 *
+		 * While we're debugging the problem, as a workaround to
+		 * multiple TRBs handling, use only one TRB at a time.
+		 */
+		last_one =3D 1;
+
+		req->trb =3D trb_hw;
+		if (!ret)
+			ret =3D req;
+
+		trb.bplh =3D req->request.dma;
+
+		if (usb_endpoint_xfer_isoc(dep->desc)) {
+			trb.isp_imi =3D true;
+			trb.csp =3D true;
+		} else {
+			trb.lst =3D last_one;
+		}
+
+		switch (usb_endpoint_type(dep->desc)) {
+		case USB_ENDPOINT_XFER_CONTROL:
+			trb.trbctl =3D DWC3_TRBCTL_CONTROL_SETUP;
+			break;
+
+		case USB_ENDPOINT_XFER_ISOC:
+			trb.trbctl =3D DWC3_TRBCTL_ISOCHRONOUS;
+
+			/* IOC every DWC3_TRB_NUM / 4 so we can refill */
+			if (!(cur_slot % (DWC3_TRB_NUM / 4)))
+				trb.ioc =3D last_one;
+			break;
+
+		case USB_ENDPOINT_XFER_BULK:
+		case USB_ENDPOINT_XFER_INT:
+			trb.trbctl =3D DWC3_TRBCTL_NORMAL;
+			break;
+		default:
+			/*
+			 * This is only possible with faulty memory because we
+			 * checked it already :)
+			 */
+			BUG();
+		}
+
+		trb.length	=3D req->request.length;
+		trb.hwo =3D true;
+
+		dwc3_trb_to_hw(&trb, trb_hw);
+		req->trb_dma =3D dwc3_trb_dma_offset(dep, trb_hw);
+
+		if (last_one)
+			break;
+	}
+
+	return ret;
+}
+
+static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_pa=
ram,
+		int start_new)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_request		*req;
+	struct dwc3			*dwc =3D dep->dwc;
+	int				ret;
+	u32				cmd;
+
+	if (start_new && (dep->flags & DWC3_EP_BUSY)) {
+		dev_vdbg(dwc->dev, "%s: endpoint busy\n", dep->name);
+		return -EBUSY;
+	}
+	dep->flags &=3D ~DWC3_EP_PENDING_REQUEST;
+
+	/*
+	 * If we are getting here after a short-out-packet we don't enqueue a=
ny
+	 * new requests as we try to set the IOC bit only on the last request=
=2E
+	 */
+	if (start_new) {
+		if (list_empty(&dep->req_queued))
+			dwc3_prepare_trbs(dep, start_new);
+
+		/* req points to the first request which will be sent */
+		req =3D next_request(&dep->req_queued);
+	} else {
+		/*
+		 * req points to the first request where HWO changed
+		 * from 0 to 1
+		 */
+		req =3D dwc3_prepare_trbs(dep, start_new);
+	}
+	if (!req) {
+		dep->flags |=3D DWC3_EP_PENDING_REQUEST;
+		return 0;
+	}
+
+	memset(&params, 0, sizeof(params));
+	params.param0.depstrtxfer.transfer_desc_addr_high =3D
+		upper_32_bits(req->trb_dma);
+	params.param1.depstrtxfer.transfer_desc_addr_low =3D
+		lower_32_bits(req->trb_dma);
+
+	if (start_new)
+		cmd =3D DWC3_DEPCMD_STARTTRANSFER;
+	else
+		cmd =3D DWC3_DEPCMD_UPDATETRANSFER;
+
+	cmd |=3D DWC3_DEPCMD_PARAM(cmd_param);
+	ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+	if (ret < 0) {
+		dev_dbg(dwc->dev, "failed to send STARTTRANSFER command\n");
+
+		/*
+		 * FIXME we need to iterate over the list of requests
+		 * here and stop, unmap, free and del each of the linked
+		 * requests instead of we do now.
+		 */
+		dwc3_unmap_buffer_from_dma(req);
+		list_del(&req->list);
+		return ret;
+	}
+
+	dep->flags |=3D DWC3_EP_BUSY;
+	dep->res_trans_idx =3D dwc3_gadget_ep_get_transfer_index(dwc,
+			dep->number);
+	if (!dep->res_trans_idx)
+		printk_once(KERN_ERR "%s() res_trans_idx is invalid\n", __func__);
+	return 0;
+}
+
+static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_req=
uest *req)
+{
+	req->request.actual	=3D 0;
+	req->request.status	=3D -EINPROGRESS;
+	req->direction		=3D dep->direction;
+	req->epnum		=3D dep->number;
+
+	/*
+	 * We only add to our list of requests now and
+	 * start consuming the list once we get XferNotReady
+	 * IRQ.
+	 *
+	 * That way, we avoid doing anything that we don't need
+	 * to do now and defer it until the point we receive a
+	 * particular token from the Host side.
+	 *
+	 * This will also avoid Host cancelling URBs due to too
+	 * many NACKs.
+	 */
+	dwc3_map_buffer_to_dma(req);
+	list_add_tail(&req->list, &dep->request_list);
+
+	/*
+	 * There is one special case: XferNotReady with
+	 * empty list of requests. We need to kick the
+	 * transfer here in that situation, otherwise
+	 * we will be NAKing forever.
+	 *
+	 * If we get XferNotReady before gadget driver
+	 * has a chance to queue a request, we will ACK
+	 * the IRQ but won't be able to receive the data
+	 * until the next request is queued. The following
+	 * code is handling exactly that.
+	 */
+	if (dep->flags & DWC3_EP_PENDING_REQUEST) {
+		int ret;
+		int start_trans;
+
+		start_trans =3D 1;
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+				dep->flags & DWC3_EP_BUSY)
+			start_trans =3D 0;
+
+		ret =3D  __dwc3_gadget_kick_transfer(dep, 0, start_trans);
+		if (ret && ret !=3D -EBUSY) {
+			struct dwc3	*dwc =3D dep->dwc;
+
+			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
+					dep->name);
+		}
+	};
+
+	return 0;
+}
+
+static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request =
*request,
+	gfp_t gfp_flags)
+{
+	struct dwc3_request		*req =3D to_dwc3_request(request);
+	struct dwc3_ep			*dep =3D to_dwc3_ep(ep);
+	struct dwc3			*dwc =3D dep->dwc;
+
+	unsigned long			flags;
+
+	int				ret;
+
+	if (!dep->desc) {
+		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s\n",
+				request, ep->name);
+		return -ESHUTDOWN;
+	}
+
+	dev_vdbg(dwc->dev, "queing request %p to %s length %d\n",
+			request, ep->name, request->length);
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	ret =3D __dwc3_gadget_ep_queue(dep, req);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
+		struct usb_request *request)
+{
+	struct dwc3_request		*req =3D to_dwc3_request(request);
+	struct dwc3_request		*r =3D NULL;
+
+	struct dwc3_ep			*dep =3D to_dwc3_ep(ep);
+	struct dwc3			*dwc =3D dep->dwc;
+
+	unsigned long			flags;
+	int				ret =3D 0;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	list_for_each_entry(r, &dep->request_list, list) {
+		if (r =3D=3D req)
+			break;
+	}
+
+	if (r !=3D req) {
+		list_for_each_entry(r, &dep->req_queued, list) {
+			if (r =3D=3D req)
+				break;
+		}
+		if (r =3D=3D req) {
+			/* wait until it is processed */
+			dwc3_stop_active_transfer(dwc, dep->number);
+			goto out0;
+		}
+		dev_err(dwc->dev, "request %p was not queued to %s\n",
+				request, ep->name);
+		ret =3D -EINVAL;
+		goto out0;
+	}
+
+	/* giveback the request */
+	dwc3_gadget_giveback(dep, req, -ECONNRESET);
+
+out0:
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value)
+{
+	struct dwc3_gadget_ep_cmd_params	params;
+	struct dwc3				*dwc =3D dep->dwc;
+	int					ret;
+
+	memset(&params, 0x00, sizeof(params));
+
+	if (value) {
+		if (dep->number =3D=3D 0 || dep->number =3D=3D 1)
+			dwc->ep0state =3D EP0_STALL;
+
+		ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number,
+			DWC3_DEPCMD_SETSTALL, &params);
+		if (ret)
+			dev_err(dwc->dev, "failed to %s STALL on %s\n",
+					value ? "set" : "clear",
+					dep->name);
+		else
+			dep->flags |=3D DWC3_EP_STALL;
+	} else {
+		ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number,
+			DWC3_DEPCMD_CLEARSTALL, &params);
+		if (ret)
+			dev_err(dwc->dev, "failed to %s STALL on %s\n",
+					value ? "set" : "clear",
+					dep->name);
+		else
+			dep->flags &=3D ~DWC3_EP_STALL;
+	}
+	return ret;
+}
+
+static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
+{
+	struct dwc3_ep			*dep =3D to_dwc3_ep(ep);
+	struct dwc3			*dwc =3D dep->dwc;
+
+	unsigned long			flags;
+
+	int				ret;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	if (usb_endpoint_xfer_isoc(dep->desc)) {
+		dev_err(dwc->dev, "%s is of Isochronous type\n", dep->name);
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D __dwc3_gadget_ep_set_halt(dep, value);
+out:
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
+{
+	struct dwc3_ep			*dep =3D to_dwc3_ep(ep);
+
+	dep->flags |=3D DWC3_EP_WEDGE;
+
+	return usb_ep_set_halt(ep);
+}
+
+/* -------------------------------------------------------------------=
------- */
+
+static struct usb_endpoint_descriptor dwc3_gadget_ep0_desc =3D {
+	.bLength	=3D USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =3D USB_DT_ENDPOINT,
+	.bmAttributes	=3D USB_ENDPOINT_XFER_CONTROL,
+};
+
+static const struct usb_ep_ops dwc3_gadget_ep0_ops =3D {
+	.enable		=3D dwc3_gadget_ep0_enable,
+	.disable	=3D dwc3_gadget_ep0_disable,
+	.alloc_request	=3D dwc3_gadget_ep_alloc_request,
+	.free_request	=3D dwc3_gadget_ep_free_request,
+	.queue		=3D dwc3_gadget_ep0_queue,
+	.dequeue	=3D dwc3_gadget_ep_dequeue,
+	.set_halt	=3D dwc3_gadget_ep_set_halt,
+	.set_wedge	=3D dwc3_gadget_ep_set_wedge,
+};
+
+static const struct usb_ep_ops dwc3_gadget_ep_ops =3D {
+	.enable		=3D dwc3_gadget_ep_enable,
+	.disable	=3D dwc3_gadget_ep_disable,
+	.alloc_request	=3D dwc3_gadget_ep_alloc_request,
+	.free_request	=3D dwc3_gadget_ep_free_request,
+	.queue		=3D dwc3_gadget_ep_queue,
+	.dequeue	=3D dwc3_gadget_ep_dequeue,
+	.set_halt	=3D dwc3_gadget_ep_set_halt,
+	.set_wedge	=3D dwc3_gadget_ep_set_wedge,
+};
+
+/* -------------------------------------------------------------------=
------- */
+
+static int dwc3_gadget_get_frame(struct usb_gadget *g)
+{
+	struct dwc3		*dwc =3D gadget_to_dwc(g);
+	u32			reg;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_DSTS);
+	return DWC3_DSTS_SOFFN(reg);
+}
+
+static int dwc3_gadget_wakeup(struct usb_gadget *g)
+{
+	struct dwc3		*dwc =3D gadget_to_dwc(g);
+
+	unsigned long		timeout;
+	unsigned long		flags;
+
+	u32			reg;
+
+	int			ret =3D 0;
+
+	u8			link_state;
+	u8			speed;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	/*
+	 * According to the Databook Remote wakeup request should
+	 * be issued only when the device is in early suspend state.
+	 *
+	 * We can check that via USB Link State bits in DSTS register.
+	 */
+	reg =3D dwc3_readl(dwc->regs, DWC3_DSTS);
+
+	speed =3D reg & DWC3_DSTS_CONNECTSPD;
+	if (speed =3D=3D DWC3_DSTS_SUPERSPEED) {
+		dev_dbg(dwc->dev, "no wakeup on SuperSpeed\n");
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	link_state =3D DWC3_DSTS_USBLNKST(reg);
+
+	switch (link_state) {
+	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
+	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
+		break;
+	default:
+		dev_dbg(dwc->dev, "can't wakeup from link state %d\n",
+				link_state);
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
+
+	/*
+	 * Switch link state to Recovery. In HS/FS/LS this means
+	 * RemoteWakeup Request
+	 */
+	reg |=3D DWC3_DCTL_ULSTCHNG_RECOVERY;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	/* wait for at least 2000us */
+	usleep_range(2000, 2500);
+
+	/* write zeroes to Link Change Request */
+	reg &=3D ~DWC3_DCTL_ULSTCHNGREQ_MASK;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	/* pool until Link State change to ON */
+	timeout =3D jiffies + msecs_to_jiffies(100);
+
+	while (!(time_after(jiffies, timeout))) {
+		reg =3D dwc3_readl(dwc->regs, DWC3_DSTS);
+
+		/* in HS, means ON */
+		if (DWC3_DSTS_USBLNKST(reg) =3D=3D DWC3_LINK_STATE_U0)
+			break;
+	}
+
+	if (DWC3_DSTS_USBLNKST(reg) !=3D DWC3_LINK_STATE_U0) {
+		dev_err(dwc->dev, "failed to send remote wakeup\n");
+		ret =3D -EINVAL;
+	}
+
+out:
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
+		int is_selfpowered)
+{
+	struct dwc3		*dwc =3D gadget_to_dwc(g);
+
+	dwc->is_selfpowered =3D !!is_selfpowered;
+
+	return 0;
+}
+
+static void dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
+{
+	u32			reg;
+	unsigned long		timeout =3D 500;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
+	if (is_on)
+		reg |=3D DWC3_DCTL_RUN_STOP;
+	else
+		reg &=3D ~DWC3_DCTL_RUN_STOP;
+
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	do {
+		reg =3D dwc3_readl(dwc->regs, DWC3_DSTS);
+		if (is_on) {
+			if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+				break;
+		} else {
+			if (reg & DWC3_DSTS_DEVCTRLHLT)
+				break;
+		}
+		/*
+		 * XXX reduce the 500ms delay
+		 */
+		timeout--;
+		if (!timeout)
+			break;
+		mdelay(1);
+	} while (1);
+
+	dev_vdbg(dwc->dev, "gadget %s data soft-%s\n",
+			dwc->gadget_driver
+			? dwc->gadget_driver->function : "no-function",
+			is_on ? "connect" : "disconnect");
+}
+
+static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
+{
+	struct dwc3		*dwc =3D gadget_to_dwc(g);
+	unsigned long		flags;
+
+	is_on =3D !!is_on;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_gadget_run_stop(dwc, is_on);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+
+static int dwc3_gadget_start(struct usb_gadget *g,
+		struct usb_gadget_driver *driver)
+{
+	struct dwc3		*dwc =3D gadget_to_dwc(g);
+	struct dwc3_ep		*dep;
+	unsigned long		flags;
+	int			ret =3D 0;
+	u32			reg;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	if (dwc->gadget_driver) {
+		dev_err(dwc->dev, "%s is already bound to %s\n",
+				dwc->gadget.name,
+				dwc->gadget_driver->driver.name);
+		ret =3D -EBUSY;
+		goto err0;
+	}
+
+	dwc->gadget_driver	=3D driver;
+	dwc->gadget.dev.driver	=3D &driver->driver;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	/*
+	 * REVISIT: power down scale might be different
+	 * depending on PHY used, need to pass that via platform_data
+	 */
+	reg |=3D DWC3_GCTL_PWRDNSCALE(0x61a)
+		| DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_DEVICE);
+	reg &=3D ~DWC3_GCTL_DISSCRAMBLE;
+
+	/*
+	 * WORKAROUND: DWC3 revisions <1.90a have a bug
+	 * when The device fails to connect at SuperSpeed
+	 * and falls back to high-speed mode which causes
+	 * the device to enter in a Connect/Disconnect loop
+	 */
+	if (dwc->revision < DWC3_REVISION_190A)
+		reg |=3D DWC3_GCTL_U2RSTECN;
+
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &=3D ~(DWC3_DCFG_SPEED_MASK);
+	reg |=3D DWC3_DCFG_SUPERSPEED;
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
+	/* Start with SuperSpeed Default */
+	dwc3_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(512);
+
+	dep =3D dwc->eps[0];
+	ret =3D __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
+		goto err0;
+	}
+
+	dep =3D dwc->eps[1];
+	ret =3D __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
+		goto err1;
+	}
+
+	/* begin to receive SETUP packets */
+	dwc->ep0state =3D EP0_IDLE;
+	dwc3_ep0_out_start(dwc);
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+
+err1:
+	__dwc3_gadget_ep_disable(dwc->eps[0]);
+
+err0:
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static int dwc3_gadget_stop(struct usb_gadget *g,
+		struct usb_gadget_driver *driver)
+{
+	struct dwc3		*dwc =3D gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	__dwc3_gadget_ep_disable(dwc->eps[0]);
+	__dwc3_gadget_ep_disable(dwc->eps[1]);
+
+	dwc->gadget_driver	=3D NULL;
+	dwc->gadget.dev.driver	=3D NULL;
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+static const struct usb_gadget_ops dwc3_gadget_ops =3D {
+	.get_frame		=3D dwc3_gadget_get_frame,
+	.wakeup			=3D dwc3_gadget_wakeup,
+	.set_selfpowered	=3D dwc3_gadget_set_selfpowered,
+	.pullup			=3D dwc3_gadget_pullup,
+	.udc_start		=3D dwc3_gadget_start,
+	.udc_stop		=3D dwc3_gadget_stop,
+};
+
+/* -------------------------------------------------------------------=
------- */
+
+static int __devinit dwc3_gadget_init_endpoints(struct dwc3 *dwc)
+{
+	struct dwc3_ep			*dep;
+	u8				epnum;
+
+	INIT_LIST_HEAD(&dwc->gadget.ep_list);
+
+	for (epnum =3D 0; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
+		dep =3D kzalloc(sizeof(*dep), GFP_KERNEL);
+		if (!dep) {
+			dev_err(dwc->dev, "can't allocate endpoint %d\n",
+					epnum);
+			return -ENOMEM;
+		}
+
+		dep->dwc =3D dwc;
+		dep->number =3D epnum;
+		dwc->eps[epnum] =3D dep;
+
+		snprintf(dep->name, sizeof(dep->name), "ep%d%s", epnum >> 1,
+				(epnum & 1) ? "in" : "out");
+		dep->endpoint.name =3D dep->name;
+		dep->direction =3D (epnum & 1);
+
+		if (epnum =3D=3D 0 || epnum =3D=3D 1) {
+			dep->endpoint.maxpacket =3D 512;
+			dep->endpoint.ops =3D &dwc3_gadget_ep0_ops;
+			if (!epnum)
+				dwc->gadget.ep0 =3D &dep->endpoint;
+		} else {
+			int		ret;
+
+			dep->endpoint.maxpacket =3D 1024;
+			dep->endpoint.ops =3D &dwc3_gadget_ep_ops;
+			list_add_tail(&dep->endpoint.ep_list,
+					&dwc->gadget.ep_list);
+
+			ret =3D dwc3_alloc_trb_pool(dep);
+			if (ret) {
+				dev_err(dwc->dev, "%s: failed to allocate TRB pool\n", dep->name);
+				return ret;
+			}
+		}
+		INIT_LIST_HEAD(&dep->request_list);
+		INIT_LIST_HEAD(&dep->req_queued);
+	}
+
+	return 0;
+}
+
+static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
+{
+	struct dwc3_ep			*dep;
+	u8				epnum;
+
+	for (epnum =3D 0; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
+		dep =3D dwc->eps[epnum];
+		dwc3_free_trb_pool(dep);
+
+		if (epnum !=3D 0 && epnum !=3D 1)
+			list_del(&dep->endpoint.ep_list);
+
+		kfree(dep);
+	}
+}
+
+static void dwc3_gadget_release(struct device *dev)
+{
+	dev_dbg(dev, "%s\n", __func__);
+}
+
+/* -------------------------------------------------------------------=
------- */
+static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *de=
p,
+		const struct dwc3_event_depevt *event, int status)
+{
+	struct dwc3_request	*req;
+	struct dwc3_trb         trb;
+	unsigned int		count;
+	unsigned int		s_pkt =3D 0;
+
+	do {
+		req =3D next_request(&dep->req_queued);
+		if (!req)
+			break;
+
+		dwc3_trb_to_nat(req->trb, &trb);
+
+		if (trb.hwo) {
+			dev_err(dwc->dev, "%s's TRB (%p) still owned by HW\n",
+					dep->name, req->trb);
+			continue;
+		}
+		count =3D trb.length;
+
+		if (dep->direction) {
+			if (count) {
+				dev_err(dwc->dev, "incomplete IN transfer %s\n",
+						dep->name);
+				status =3D -ECONNRESET;
+			}
+		} else {
+			if (count && (event->status & DEPEVT_STATUS_SHORT))
+				s_pkt =3D 1;
+		}
+
+		/*
+		 * We assume here we will always receive the entire data block
+		 * which we should receive. Meaning, if we program RX to
+		 * receive 4K but we receive only 2K, we assume that's all we
+		 * should receive and we simply bounce the request back to the
+		 * gadget driver for further processing.
+		 */
+		req->request.actual +=3D req->request.length - count;
+		dwc3_gadget_giveback(dep, req, status);
+		if (s_pkt)
+			break;
+		if ((event->status & DEPEVT_STATUS_LST) && trb.lst)
+			break;
+		if ((event->status & DEPEVT_STATUS_IOC) && trb.ioc)
+			break;
+	} while (1);
+
+	if ((event->status & DEPEVT_STATUS_IOC) && trb.ioc)
+		return 0;
+	return 1;
+}
+
+static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
+		struct dwc3_ep *dep, const struct dwc3_event_depevt *event,
+		int start_new)
+{
+	unsigned		status =3D 0;
+	int			clean_busy;
+
+	if (event->status & DEPEVT_STATUS_BUSERR)
+		status =3D -ECONNRESET;
+
+	clean_busy =3D  dwc3_cleanup_done_reqs(dwc, dep, event, status);
+	if (clean_busy)
+		dep->flags &=3D ~DWC3_EP_BUSY;
+}
+
+static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
+		struct dwc3_ep *dep, const struct dwc3_event_depevt *event)
+{
+	u32 uf;
+
+	if (list_empty(&dep->request_list)) {
+		dev_vdbg(dwc->dev, "ISOC ep %s run out for requests.\n",
+			dep->name);
+		return;
+	}
+
+	if (event->parameters) {
+		u32 mask;
+
+		mask =3D ~(dep->interval - 1);
+		uf =3D event->parameters & mask;
+		/* 4 micro frames in the future */
+		uf +=3D dep->interval * 4;
+	} else {
+		uf =3D 0;
+	}
+
+	__dwc3_gadget_kick_transfer(dep, uf, 1);
+}
+
+static void dwc3_process_ep_cmd_complete(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	struct dwc3 *dwc =3D dep->dwc;
+	struct dwc3_event_depevt mod_ev =3D *event;
+
+	/*
+	 * We were asked to remove one requests. It is possible that this
+	 * request and a few other were started together and have the same
+	 * transfer index. Since we stopped the complete endpoint we don't
+	 * know how many requests were already completed (and not yet)
+	 * reported and how could be done (later). We purge them all until
+	 * the end of the list.
+	 */
+	mod_ev.status =3D DEPEVT_STATUS_LST;
+	dwc3_cleanup_done_reqs(dwc, dep, &mod_ev, -ESHUTDOWN);
+	dep->flags &=3D ~DWC3_EP_BUSY;
+	/* pending requets are ignored and are queued on XferNotReady */
+
+	if (dep->flags & DWC3_EP_WILL_SHUTDOWN) {
+		while (!list_empty(&dep->req_queued)) {
+			struct dwc3_request	*req;
+
+			req =3D next_request(&dep->req_queued);
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		}
+		dep->flags &=3D DWC3_EP_WILL_SHUTDOWN;
+	}
+}
+
+static void dwc3_ep_cmd_compl(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	u32 param =3D event->parameters;
+	u32 cmd_type =3D (param >> 8) & ((1 << 5) - 1);
+
+	switch (cmd_type) {
+	case DWC3_DEPCMD_ENDTRANSFER:
+		dwc3_process_ep_cmd_complete(dep, event);
+		break;
+	case DWC3_DEPCMD_STARTTRANSFER:
+		dep->res_trans_idx =3D param & 0x7f;
+		break;
+	default:
+		printk(KERN_ERR "%s() unknown /unexpected type: %d\n",
+				__func__, cmd_type);
+		break;
+	};
+}
+
+static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
+		const struct dwc3_event_depevt *event)
+{
+	struct dwc3_ep		*dep;
+	u8			epnum =3D event->endpoint_number;
+
+	dep =3D dwc->eps[epnum];
+
+	dev_vdbg(dwc->dev, "%s: %s\n", dep->name,
+			dwc3_ep_event_string(event->endpoint_event));
+
+	if (epnum =3D=3D 0 || epnum =3D=3D 1) {
+		dwc3_ep0_interrupt(dwc, event);
+		return;
+	}
+
+	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (usb_endpoint_xfer_isoc(dep->desc)) {
+			dev_dbg(dwc->dev, "%s is an Isochronous endpoint\n",
+					dep->name);
+			return;
+		}
+
+		dwc3_endpoint_transfer_complete(dwc, dep, event, 1);
+		break;
+	case DWC3_DEPEVT_XFERINPROGRESS:
+		if (!usb_endpoint_xfer_isoc(dep->desc)) {
+			dev_dbg(dwc->dev, "%s is not an Isochronous endpoint\n",
+					dep->name);
+			return;
+		}
+
+		dwc3_endpoint_transfer_complete(dwc, dep, event, 0);
+		break;
+	case DWC3_DEPEVT_XFERNOTREADY:
+		if (usb_endpoint_xfer_isoc(dep->desc)) {
+			dwc3_gadget_start_isoc(dwc, dep, event);
+		} else {
+			int ret;
+
+			dev_vdbg(dwc->dev, "%s: reason %s\n",
+					dep->name, event->status
+					? "Transfer Active"
+					: "Transfer Not Active");
+
+			ret =3D __dwc3_gadget_kick_transfer(dep, 0, 1);
+			if (!ret || ret =3D=3D -EBUSY)
+				return;
+
+			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
+					dep->name);
+		}
+
+		break;
+	case DWC3_DEPEVT_RXTXFIFOEVT:
+		dev_dbg(dwc->dev, "%s FIFO Overrun\n", dep->name);
+		break;
+	case DWC3_DEPEVT_STREAMEVT:
+		dev_dbg(dwc->dev, "%s Stream Event\n", dep->name);
+		break;
+	case DWC3_DEPEVT_EPCMDCMPLT:
+		dwc3_ep_cmd_compl(dep, event);
+		break;
+	}
+}
+
+static void dwc3_disconnect_gadget(struct dwc3 *dwc)
+{
+	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
+		spin_unlock(&dwc->lock);
+		dwc->gadget_driver->disconnect(&dwc->gadget);
+		spin_lock(&dwc->lock);
+	}
+}
+
+static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum)
+{
+	struct dwc3_ep *dep;
+	struct dwc3_gadget_ep_cmd_params params;
+	u32 cmd;
+	int ret;
+
+	dep =3D dwc->eps[epnum];
+
+	if (dep->res_trans_idx) {
+		cmd =3D DWC3_DEPCMD_ENDTRANSFER;
+		cmd |=3D DWC3_DEPCMD_HIPRI_FORCERM | DWC3_DEPCMD_CMDIOC;
+		cmd |=3D DWC3_DEPCMD_PARAM(dep->res_trans_idx);
+		memset(&params, 0, sizeof(params));
+		ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+		WARN_ON_ONCE(ret);
+	}
+}
+
+static void dwc3_stop_active_transfers(struct dwc3 *dwc)
+{
+	u32 epnum;
+
+	for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
+		struct dwc3_ep *dep;
+
+		dep =3D dwc->eps[epnum];
+		if (!(dep->flags & DWC3_EP_ENABLED))
+			continue;
+
+		__dwc3_gadget_ep_disable(dep);
+	}
+}
+
+static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
+{
+	u32 epnum;
+
+	for (epnum =3D 1; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
+		struct dwc3_ep *dep;
+		struct dwc3_gadget_ep_cmd_params params;
+		int ret;
+
+		dep =3D dwc->eps[epnum];
+
+		if (!(dep->flags & DWC3_EP_STALL))
+			continue;
+
+		dep->flags &=3D ~DWC3_EP_STALL;
+
+		memset(&params, 0, sizeof(params));
+		ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number,
+				DWC3_DEPCMD_CLEARSTALL, &params);
+		WARN_ON_ONCE(ret);
+	}
+}
+
+static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
+{
+	dev_vdbg(dwc->dev, "%s\n", __func__);
+#if 0
+	XXX
+	U1/U2 is powersave optimization. Skip it for now. Anyway we need to
+	enable it before we can disable it.
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg &=3D ~DWC3_DCTL_INITU1ENA;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	reg &=3D ~DWC3_DCTL_INITU2ENA;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+#endif
+
+	dwc3_stop_active_transfers(dwc);
+	dwc3_disconnect_gadget(dwc);
+
+	dwc->gadget.speed =3D USB_SPEED_UNKNOWN;
+}
+
+static void dwc3_gadget_usb3_phy_power(struct dwc3 *dwc, int on)
+{
+	u32			reg;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+
+	if (on)
+		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
+	else
+		reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+}
+
+static void dwc3_gadget_usb2_phy_power(struct dwc3 *dwc, int on)
+{
+	u32			reg;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+
+	if (on)
+		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
+	else
+		reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+}
+
+static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
+{
+	u32			reg;
+
+	dev_vdbg(dwc->dev, "%s\n", __func__);
+
+	/* Enable PHYs */
+	dwc3_gadget_usb2_phy_power(dwc, true);
+	dwc3_gadget_usb3_phy_power(dwc, true);
+
+	if (dwc->gadget.speed !=3D USB_SPEED_UNKNOWN)
+		dwc3_disconnect_gadget(dwc);
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg &=3D ~DWC3_DCTL_TSTCTRL_MASK;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	dwc3_stop_active_transfers(dwc);
+	dwc3_clear_stall_all_ep(dwc);
+
+	/* Reset device address to zero */
+	reg =3D dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &=3D ~(DWC3_DCFG_DEVADDR_MASK);
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
+	/*
+	 * Wait for RxFifo to drain
+	 *
+	 * REVISIT probably shouldn't wait forever.
+	 * In case Hardware ends up in a screwed up
+	 * case, we error out, notify the user and,
+	 * maybe, WARN() or BUG() but leave the rest
+	 * of the kernel working fine.
+	 *
+	 * REVISIT the below is rather CPU intensive,
+	 * maybe we should read and if it doesn't work
+	 * sleep (not busy wait) for a few useconds.
+	 *
+	 * REVISIT why wait until the RXFIFO is empty anyway?
+	 */
+	while (!(dwc3_readl(dwc->regs, DWC3_DSTS)
+				& DWC3_DSTS_RXFIFOEMPTY))
+		cpu_relax();
+}
+
+static void dwc3_update_ram_clk_sel(struct dwc3 *dwc, u32 speed)
+{
+	u32 reg;
+	u32 usb30_clock =3D DWC3_GCTL_CLK_BUS;
+
+	/*
+	 * We change the clock only at SS but I dunno why I would want to do
+	 * this. Maybe it becomes part of the power saving plan.
+	 */
+
+	if (speed !=3D DWC3_DSTS_SUPERSPEED)
+		return;
+
+	/*
+	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogramme=
d
+	 * each time on Connect Done.
+	 */
+	if (!usb30_clock)
+		return;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg |=3D DWC3_GCTL_RAMCLKSEL(usb30_clock);
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
+static void dwc3_gadget_disable_phy(struct dwc3 *dwc, u8 speed)
+{
+	switch (speed) {
+	case USB_SPEED_SUPER:
+		dwc3_gadget_usb2_phy_power(dwc, false);
+		break;
+	case USB_SPEED_HIGH:
+	case USB_SPEED_FULL:
+	case USB_SPEED_LOW:
+		dwc3_gadget_usb3_phy_power(dwc, false);
+		break;
+	}
+}
+
+static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
+	int			ret;
+	u32			reg;
+	u8			speed;
+
+	dev_vdbg(dwc->dev, "%s\n", __func__);
+
+	memset(&params, 0x00, sizeof(params));
+
+	dwc->ep0state =3D EP0_IDLE;
+	reg =3D dwc3_readl(dwc->regs, DWC3_DSTS);
+	speed =3D reg & DWC3_DSTS_CONNECTSPD;
+	dwc->speed =3D speed;
+
+	dwc3_update_ram_clk_sel(dwc, speed);
+
+	switch (speed) {
+	case DWC3_DCFG_SUPERSPEED:
+		dwc3_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(512);
+		dwc->gadget.ep0->maxpacket =3D 512;
+		dwc->gadget.speed =3D USB_SPEED_SUPER;
+		break;
+	case DWC3_DCFG_HIGHSPEED:
+		dwc3_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(64);
+		dwc->gadget.ep0->maxpacket =3D 64;
+		dwc->gadget.speed =3D USB_SPEED_HIGH;
+		break;
+	case DWC3_DCFG_FULLSPEED2:
+	case DWC3_DCFG_FULLSPEED1:
+		dwc3_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(64);
+		dwc->gadget.ep0->maxpacket =3D 64;
+		dwc->gadget.speed =3D USB_SPEED_FULL;
+		break;
+	case DWC3_DCFG_LOWSPEED:
+		dwc3_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(8);
+		dwc->gadget.ep0->maxpacket =3D 8;
+		dwc->gadget.speed =3D USB_SPEED_LOW;
+		break;
+	}
+
+	/* Disable unneded PHY */
+	dwc3_gadget_disable_phy(dwc, dwc->gadget.speed);
+
+	dep =3D dwc->eps[0];
+	ret =3D __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
+		return;
+	}
+
+	dep =3D dwc->eps[1];
+	ret =3D __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
+		return;
+	}
+
+	/*
+	 * Configure PHY via GUSB3PIPECTLn if required.
+	 *
+	 * Update GTXFIFOSIZn
+	 *
+	 * In both cases reset values should be sufficient.
+	 */
+}
+
+static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
+{
+	dev_vdbg(dwc->dev, "%s\n", __func__);
+
+	/*
+	 * TODO take core out of low power mode when that's
+	 * implemented.
+	 */
+
+	dwc->gadget_driver->resume(&dwc->gadget);
+}
+
+static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
+		unsigned int evtinfo)
+{
+	dev_vdbg(dwc->dev, "%s\n", __func__);
+
+	/*  The fith bit says SuperSpeed yes or no. */
+	dwc->link_state =3D evtinfo & DWC3_LINK_STATE_MASK;
+}
+
+static void dwc3_gadget_interrupt(struct dwc3 *dwc,
+		const struct dwc3_event_devt *event)
+{
+	switch (event->type) {
+	case DWC3_DEVICE_EVENT_DISCONNECT:
+		dwc3_gadget_disconnect_interrupt(dwc);
+		break;
+	case DWC3_DEVICE_EVENT_RESET:
+		dwc3_gadget_reset_interrupt(dwc);
+		break;
+	case DWC3_DEVICE_EVENT_CONNECT_DONE:
+		dwc3_gadget_conndone_interrupt(dwc);
+		break;
+	case DWC3_DEVICE_EVENT_WAKEUP:
+		dwc3_gadget_wakeup_interrupt(dwc);
+		break;
+	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
+		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
+		break;
+	case DWC3_DEVICE_EVENT_EOPF:
+		dev_vdbg(dwc->dev, "End of Periodic Frame\n");
+		break;
+	case DWC3_DEVICE_EVENT_SOF:
+		dev_vdbg(dwc->dev, "Start of Periodic Frame\n");
+		break;
+	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
+		dev_vdbg(dwc->dev, "Erratic Error\n");
+		break;
+	case DWC3_DEVICE_EVENT_CMD_CMPL:
+		dev_vdbg(dwc->dev, "Command Complete\n");
+		break;
+	case DWC3_DEVICE_EVENT_OVERFLOW:
+		dev_vdbg(dwc->dev, "Overflow\n");
+		break;
+	default:
+		dev_dbg(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
+	}
+}
+
+static void dwc3_process_event_entry(struct dwc3 *dwc,
+		const union dwc3_event *event)
+{
+	/* Endpoint IRQ, handle it and return early */
+	if (event->type.is_devspec =3D=3D 0) {
+		/* depevt */
+		return dwc3_endpoint_interrupt(dwc, &event->depevt);
+	}
+
+	switch (event->type.type) {
+	case DWC3_EVENT_TYPE_DEV:
+		dwc3_gadget_interrupt(dwc, &event->devt);
+		break;
+	/* REVISIT what to do with Carkit and I2C events ? */
+	default:
+		dev_err(dwc->dev, "UNKNOWN IRQ type %d\n", event->raw);
+	}
+}
+
+static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
+{
+	struct dwc3_event_buffer *evt;
+	int left;
+	u32 count;
+
+	count =3D dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(buf));
+	count &=3D DWC3_GEVNTCOUNT_MASK;
+	if (!count)
+		return IRQ_NONE;
+
+	evt =3D dwc->ev_buffs[buf];
+	left =3D count;
+
+	while (left > 0) {
+		union dwc3_event event;
+
+		memcpy(&event.raw, (evt->buf + evt->lpos), sizeof(event.raw));
+		dwc3_process_event_entry(dwc, &event);
+		/*
+		 * XXX we wrap around correctly to the next entry as almost all
+		 * entries are 4 bytes in size. There is one entry which has 12
+		 * bytes which is a regular entry followed by 8 bytes data. ATM
+		 * I don't know how things are organized if were get next to the
+		 * a boundary so I worry about that once we try to handle that.
+		 */
+		evt->lpos =3D (evt->lpos + 4) % DWC3_EVENT_BUFFERS_SIZE;
+		left -=3D 4;
+
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(buf), 4);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
+{
+	struct dwc3			*dwc =3D _dwc;
+	int				i;
+	irqreturn_t			ret =3D IRQ_NONE;
+
+	spin_lock(&dwc->lock);
+
+	for (i =3D 0; i < DWC3_EVENT_BUFFERS_NUM; i++) {
+		irqreturn_t status;
+
+		status =3D dwc3_process_event_buf(dwc, i);
+		if (status =3D=3D IRQ_HANDLED)
+			ret =3D status;
+	}
+
+	spin_unlock(&dwc->lock);
+
+	return ret;
+}
+
+/**
+ * dwc3_gadget_init - Initializes gadget related registers
+ * @dwc: Pointer to out controller context structure
+ *
+ * Returns 0 on success otherwise negative errno.
+ */
+int __devinit dwc3_gadget_init(struct dwc3 *dwc)
+{
+	u32					reg;
+	int					ret;
+	int					irq;
+
+	dwc->ctrl_req =3D dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req)=
,
+			&dwc->ctrl_req_addr, GFP_KERNEL);
+	if (!dwc->ctrl_req) {
+		dev_err(dwc->dev, "failed to allocate ctrl request\n");
+		ret =3D -ENOMEM;
+		goto err0;
+	}
+
+	dwc->ep0_trb =3D dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+			&dwc->ep0_trb_addr, GFP_KERNEL);
+	if (!dwc->ep0_trb) {
+		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
+		ret =3D -ENOMEM;
+		goto err1;
+	}
+
+	dwc->setup_buf =3D dma_alloc_coherent(dwc->dev,
+			sizeof(*dwc->setup_buf) * 2,
+			&dwc->setup_buf_addr, GFP_KERNEL);
+	if (!dwc->setup_buf) {
+		dev_err(dwc->dev, "failed to allocate setup buffer\n");
+		ret =3D -ENOMEM;
+		goto err2;
+	}
+
+	dev_set_name(&dwc->gadget.dev, "gadget");
+
+	dwc->gadget.ops			=3D &dwc3_gadget_ops;
+	dwc->gadget.is_dualspeed	=3D true;
+	dwc->gadget.speed		=3D USB_SPEED_UNKNOWN;
+	dwc->gadget.dev.parent		=3D dwc->dev;
+
+	dma_set_coherent_mask(&dwc->gadget.dev, dwc->dev->coherent_dma_mask);
+
+	dwc->gadget.dev.dma_parms	=3D dwc->dev->dma_parms;
+	dwc->gadget.dev.dma_mask	=3D dwc->dev->dma_mask;
+	dwc->gadget.dev.release		=3D dwc3_gadget_release;
+	dwc->gadget.name		=3D "dwc3-gadget";
+
+	/*
+	 * REVISIT: Here we should clear all pending IRQs to be
+	 * sure we're starting from a well known location.
+	 */
+
+	ret =3D dwc3_gadget_init_endpoints(dwc);
+	if (ret)
+		goto err3;
+
+	irq =3D platform_get_irq(to_platform_device(dwc->dev), 0);
+
+	ret =3D request_irq(irq, dwc3_interrupt, IRQF_SHARED,
+			"dwc3", dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+				irq, ret);
+		goto err4;
+	}
+
+	/* Enable all but Start and End of Frame IRQs */
+	reg =3D (DWC3_DEVTEN_VNDRDEVTSTRCVEDEN |
+			DWC3_DEVTEN_EVNTOVERFLOWEN |
+			DWC3_DEVTEN_CMDCMPLTEN |
+			DWC3_DEVTEN_ERRTICERREN |
+			DWC3_DEVTEN_WKUPEVTEN |
+			DWC3_DEVTEN_ULSTCNGEN |
+			DWC3_DEVTEN_CONNECTDONEEN |
+			DWC3_DEVTEN_USBRSTEN |
+			DWC3_DEVTEN_DISCONNEVTEN);
+	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
+
+	ret =3D device_register(&dwc->gadget.dev);
+	if (ret) {
+		dev_err(dwc->dev, "failed to register gadget device\n");
+		put_device(&dwc->gadget.dev);
+		goto err5;
+	}
+
+	ret =3D usb_add_gadget_udc(dwc->dev, &dwc->gadget);
+	if (ret) {
+		dev_err(dwc->dev, "failed to register udc\n");
+		goto err6;
+	}
+
+	return 0;
+
+err6:
+	device_unregister(&dwc->gadget.dev);
+
+err5:
+	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
+	free_irq(irq, dwc);
+
+err4:
+	dwc3_gadget_free_endpoints(dwc);
+
+err3:
+	dma_free_coherent(dwc->dev, sizeof(*dwc->setup_buf) * 2,
+			dwc->setup_buf, dwc->setup_buf_addr);
+
+err2:
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+			dwc->ep0_trb, dwc->ep0_trb_addr);
+
+err1:
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+			dwc->ctrl_req, dwc->ctrl_req_addr);
+
+err0:
+	return ret;
+}
+
+void dwc3_gadget_exit(struct dwc3 *dwc)
+{
+	int			irq;
+	int			i;
+
+	usb_del_gadget_udc(&dwc->gadget);
+	irq =3D platform_get_irq(to_platform_device(dwc->dev), 0);
+
+	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
+	free_irq(irq, dwc);
+
+	for (i =3D 0; i < ARRAY_SIZE(dwc->eps); i++)
+		__dwc3_gadget_ep_disable(dwc->eps[i]);
+
+	dwc3_gadget_free_endpoints(dwc);
+
+	dma_free_coherent(dwc->dev, sizeof(*dwc->setup_buf) * 2,
+			dwc->setup_buf, dwc->setup_buf_addr);
+
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+			dwc->ep0_trb, dwc->ep0_trb_addr);
+
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+			dwc->ctrl_req, dwc->ctrl_req_addr);
+
+	device_unregister(&dwc->gadget.dev);
+}
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
new file mode 100644
index 0000000..ccfc109
--- /dev/null
+++ b/drivers/usb/dwc3/gadget.h
@@ -0,0 +1,292 @@
+/**
+ * gadget.h - DesignWare USB3 DRD Gadget Header
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __DRIVERS_USB_DWC3_GADGET_H
+#define __DRIVERS_USB_DWC3_GADGET_H
+
+#include <linux/list.h>
+#include <linux/usb/gadget.h>
+#include "io.h"
+
+struct dwc3;
+#define to_dwc3_ep(ep)		(container_of(ep, struct dwc3_ep, endpoint))
+#define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
+
+/**
+ * struct dwc3_gadget_ep_depcfg_param1 - DEPCMDPAR0 for DEPCFG command
+ * @interrupt_number: self-explanatory
+ * @reserved7_5: set to zero
+ * @xfer_complete_enable: event generated when transfer completed
+ * @xfer_in_progress_enable: event generated when transfer in progress
+ * @xfer_not_ready_enable: event generated when transfer not read
+ * @fifo_error_enable: generates events when FIFO Underrun (IN eps)
+ *	or FIFO Overrun (OUT) eps
+ * @reserved_12: set to zero
+ * @stream_event_enable: event generated on stream
+ * @reserved14_15: set to zero
+ * @binterval_m1: bInterval minus 1
+ * @stream_capable: this EP is capable of handling streams
+ * @ep_number: self-explanatory
+ * @bulk_based: Set to =E2=80=981=E2=80=99 if this isochronous endpoin=
t represents a bulk
+ *	data stream that ignores the relationship of bus time to the
+ *	intervals programmed in TRBs.
+ * @fifo_based: Set to =E2=80=981=E2=80=99 if this isochronous endpoin=
t represents a
+ *	FIFO-based data stream where TRBs have fixed values and are never
+ *	written back by the core.
+ */
+struct dwc3_gadget_ep_depcfg_param1 {
+	u32	interrupt_number:5;
+	u32	reserved7_5:3;		/* set to zero */
+	u32	xfer_complete_enable:1;
+	u32	xfer_in_progress_enable:1;
+	u32	xfer_not_ready_enable:1;
+	u32	fifo_error_enable:1;	/* IN-underrun, OUT-overrun */
+	u32	reserved12:1;		/* set to zero */
+	u32	stream_event_enable:1;
+	u32	reserved14_15:2;
+	u32	binterval_m1:8;		/* bInterval minus 1 */
+	u32	stream_capable:1;
+	u32	ep_number:5;
+	u32	bulk_based:1;
+	u32	fifo_based:1;
+} __packed;
+
+/**
+ * struct dwc3_gadget_ep_depcfg_param0 - Parameter 0 for DEPCFG
+ * @reserved0: set to zero
+ * @ep_type: Endpoint Type (control, bulk, iso, interrupt)
+ * @max_packet_size: max packet size in bytes
+ * @reserved16_14: set to zero
+ * @fifo_number: self-explanatory
+ * @burst_size: burst size minus 1
+ * @data_sequence_number: Must be 0 when an endpoint is initially conf=
igured
+ *	May be non-zero when an endpoint is configured after a power transi=
tion
+ *	that requires a save/restore.
+ * @ignore_sequence_number: Set to =E2=80=981=E2=80=99 to avoid resett=
ing the sequence
+ *	number. This setting is used by software to modify the DEPEVTEN
+ *	event enable bits without modifying other endpoint settings.
+ */
+struct dwc3_gadget_ep_depcfg_param0 {
+	u32	reserved0:1;
+	u32	ep_type:2;
+	u32	max_packet_size:11;
+	u32	reserved16_14:3;
+	u32	fifo_number:5;
+	u32	burst_size:4;
+	u32	data_sequence_number:5;
+	u32	ignore_sequence_number:1;
+} __packed;
+
+/**
+ * struct dwc3_gadget_ep_depxfercfg_param0 - Parameter 0 of DEPXFERCFG
+ * @number_xfer_resources: Defines the number of Transfer Resources al=
located
+ *	to this endpoint.  This field must be set to 1.
+ * @reserved16_31: set to zero;
+ */
+struct dwc3_gadget_ep_depxfercfg_param0 {
+	u32		number_xfer_resources:16;
+	u32		reserved16_31:16;
+} __packed;
+
+/**
+ * struct dwc3_gadget_ep_depstrtxfer_param1 - Parameter 1 of DEPSTRTXF=
ER
+ * @transfer_desc_addr_low: Indicates the lower 32 bits of the externa=
l
+ *	memory's start address for the transfer descriptor. Because TRBs
+ *	must be aligned to a 16-byte boundary, the lower 4 bits of this
+ *	address must be 0.
+ */
+struct dwc3_gadget_ep_depstrtxfer_param1 {
+	u32		transfer_desc_addr_low;
+} __packed;
+
+/**
+ * struct dwc3_gadget_ep_depstrtxfer_param1 - Parameter 1 of DEPSTRTXF=
ER
+ * @transfer_desc_addr_high: Indicates the higher 32 bits of the exter=
nal
+ *	memory=E2=80=99s start address for the transfer descriptor.
+ */
+struct dwc3_gadget_ep_depstrtxfer_param0 {
+	u32		transfer_desc_addr_high;
+} __packed;
+
+struct dwc3_gadget_ep_cmd_params {
+	union {
+		u32	raw;
+	} param2;
+
+	union {
+		u32	raw;
+		struct dwc3_gadget_ep_depcfg_param1 depcfg;
+		struct dwc3_gadget_ep_depstrtxfer_param1 depstrtxfer;
+	} param1;
+
+	union {
+		u32	raw;
+		struct dwc3_gadget_ep_depcfg_param0 depcfg;
+		struct dwc3_gadget_ep_depxfercfg_param0 depxfercfg;
+		struct dwc3_gadget_ep_depstrtxfer_param0 depstrtxfer;
+	} param0;
+} __packed;
+
+/* -------------------------------------------------------------------=
------- */
+
+struct dwc3_request {
+	struct usb_request	request;
+	struct list_head	list;
+	struct dwc3_ep		*dep;
+
+	u8			epnum;
+	struct dwc3_trb_hw	*trb;
+	dma_addr_t		trb_dma;
+
+	unsigned		direction:1;
+	unsigned		mapped:1;
+	unsigned		queued:1;
+};
+#define to_dwc3_request(r)	(container_of(r, struct dwc3_request, reque=
st))
+
+static inline struct dwc3_request *next_request(struct list_head *list=
)
+{
+	if (list_empty(list))
+		return NULL;
+
+	return list_first_entry(list, struct dwc3_request, list);
+}
+
+static inline void dwc3_gadget_move_request_queued(struct dwc3_request=
 *req)
+{
+	struct dwc3_ep		*dep =3D req->dep;
+
+	req->queued =3D true;
+	list_move_tail(&req->list, &dep->req_queued);
+}
+
+#if defined(CONFIG_USB_GADGET_DWC3) || defined(CONFIG_USB_GADGET_DWC3_=
MODULE)
+int dwc3_gadget_init(struct dwc3 *dwc);
+void dwc3_gadget_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_gadget_init(struct dwc3 *dwc) { return 0; }
+static inline void dwc3_gadget_exit(struct dwc3 *dwc) { }
+#endif
+
+void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *re=
q,
+		int status);
+
+void dwc3_ep0_interrupt(struct dwc3 *dwc, const struct dwc3_event_depe=
vt *event);
+void dwc3_ep0_out_start(struct dwc3 *dwc);
+int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *reque=
st,
+		gfp_t gfp_flags);
+int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value);
+int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
+		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params);
+void dwc3_map_buffer_to_dma(struct dwc3_request *req);
+void dwc3_unmap_buffer_from_dma(struct dwc3_request *req);
+
+/**
+ * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
+ * @dwc: DesignWare USB3 Pointer
+ * @number: DWC endpoint number
+ *
+ * Caller should take care of locking
+ */
+static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3 *dwc, =
u8 number)
+{
+	u32			res_id;
+
+	res_id =3D dwc3_readl(dwc->regs, DWC3_DEPCMD(number));
+
+	return DWC3_DEPCMD_GET_RSC_IDX(res_id);
+}
+
+/**
+ * dwc3_gadget_event_string - returns event name
+ * @event: the event code
+ */
+static inline const char *dwc3_gadget_event_string(u8 event)
+{
+	switch (event) {
+	case DWC3_DEVICE_EVENT_DISCONNECT:
+		return "Disconnect";
+	case DWC3_DEVICE_EVENT_RESET:
+		return "Reset";
+	case DWC3_DEVICE_EVENT_CONNECT_DONE:
+		return "Connection Done";
+	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
+		return "Link Status Change";
+	case DWC3_DEVICE_EVENT_WAKEUP:
+		return "WakeUp";
+	case DWC3_DEVICE_EVENT_EOPF:
+		return "End-Of-Frame";
+	case DWC3_DEVICE_EVENT_SOF:
+		return "Start-Of-Frame";
+	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
+		return "Erratic Error";
+	case DWC3_DEVICE_EVENT_CMD_CMPL:
+		return "Command Complete";
+	case DWC3_DEVICE_EVENT_OVERFLOW:
+		return "Overflow";
+	}
+
+	return "UNKNOWN";
+}
+
+/**
+ * dwc3_ep_event_string - returns event name
+ * @event: then event code
+ */
+static inline const char *dwc3_ep_event_string(u8 event)
+{
+	switch (event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		return "Transfer Complete";
+	case DWC3_DEPEVT_XFERINPROGRESS:
+		return "Transfer In-Progress";
+	case DWC3_DEPEVT_XFERNOTREADY:
+		return "Transfer Not Ready";
+	case DWC3_DEPEVT_RXTXFIFOEVT:
+		return "FIFO";
+	case DWC3_DEPEVT_STREAMEVT:
+		return "Stream";
+	case DWC3_DEPEVT_EPCMDCMPLT:
+		return "Endpoint Command Complete";
+	}
+
+	return "UNKNOWN";
+}
+
+#endif /* __DRIVERS_USB_DWC3_GADGET_H */
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
new file mode 100644
index 0000000..0c4e2a9
--- /dev/null
+++ b/drivers/usb/dwc3/io.h
@@ -0,0 +1,55 @@
+/**
+ * io.h - DesignWare USB3 DRD IO Header
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www=
=2Eti.com
+ * All rights reserved.
+ *
+ * Authors: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
+ *	    Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. The names of the above-listed copyright holders may not be used
+ *    to endorse or promote products derived from this software withou=
t
+ *    specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of =
the
+ * GNU General Public License ("GPL") version 2, as published by the F=
ree
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS
+ * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMIT=
ED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIA=
L,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY=
 OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __DRIVERS_USB_DWC3_IO_H
+#define __DRIVERS_USB_DWC3_IO_H
+
+#include <asm/io.h>
+
+static inline u32 dwc3_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static inline void dwc3_writel(void __iomem *base, u32 offset, u32 val=
ue)
+{
+	writel(value, base + offset);
+}
+
+#endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 5a084b9..bb799d5 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -303,6 +303,18 @@ config USB_PXA_U2O
 	  PXA9xx Processor series include a high speed USB2.0 device
 	  controller, which support high speed and full speed USB peripheral.
=20
+config USB_GADGET_DWC3
+	tristate "DesignWare USB3.0 (DRD) Controller"
+	depends on USB_DWC3
+	select USB_GADGET_DUALSPEED
+	select USB_GADGET_SUPERSPEED
+	help
+	  DesignWare USB3.0 controller is a SuperSpeed USB3.0 Controller
+	  which can be configured for peripheral-only, host-only, hub-only
+	  and Dual-Role operation. This Controller was first integrated into
+	  the OMAP5 series of processors. More information about the OMAP5
+	  version of this controller, refer to http://www.ti.com/omap5.
+
 #
 # Controllers available in both integrated and discrete versions
 #
--=20
1.7.6.396.ge0613

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
