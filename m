From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 0/7] DRIVERS: IRQCHIP: Add support for crossbar IP
Date: Wed, 30 Oct 2013 20:27:13 +0530
Message-ID: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Some socs have a large number of interrupts requests to service
the needs of its many peripherals and subsystems. All of the interrupt
requests lines from the subsystems are not needed at the same
time, so they have to be muxed to the controllers appropriately.
In such places a interrupt controllers are preceded by an
IRQ CROSSBAR that provides flexibility in muxing the device interrupt
requests to the controller inputs.

This series models the peripheral interrupts that can be routed through
the crossbar to the GIC as 'routable-irqs'. The routable irqs are added
in a separate linear domain inside the GIC. The registered routable domain's
callback are invoked as a part of the GIC's callback, which in turn should
allocate a free irq line and configure the IP accordingly. So every peripheral
in the dts files mentions the fixed crossbar number as its interrupt. A free
gic line for that gets allocated and configured when the peripheral interrupts
are mapped.

The minimal crossbar driver to track and allocate free GIC lines and configure the
crossbar is added here, along with the DT bindings.

V2:
   Addressed Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> comments and
   Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

   Split updating the DRA7.dtsi file for adding the routable-irqs
   property in to a separate patch

Previous discussions that led to this is at
	https://lkml.org/lkml/2013/9/18/540

The V1 post of these patches is at
        https://lkml.org/lkml/2013/9/30/283

Sricharan R (7):
  DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable irqs
  DRIVERS: IRQCHIP: CROSSBAR: Add support for Crossbar IP
  ARM: DTS: DRA: Add crossbar device binding
  ARM: DTS: DRA: Replace peripheral interrupt numbers with crossbar
    inputs.
  ARM: DTS: DRA7: Add routable-irqs property for gic node
  ARM: OMAP4+: Correct Wakeup-gen code to use physical irq number
  ARM: DRA: Enable Crossbar IP support for DRA7XX

 Documentation/devicetree/bindings/arm/gic.txt      |    6 +
 .../devicetree/bindings/arm/omap/crossbar.txt      |   41 ++--
 arch/arm/boot/dts/dra7.dtsi                        |  102 ++++++----
 arch/arm/mach-omap2/Kconfig                        |    2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |    4 +-
 arch/arm/mach-omap2/omap4-common.c                 |    4 +
 drivers/irqchip/Kconfig                            |    8 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-crossbar.c                     |  206 ++++++++++++++++++++
 drivers/irqchip/irq-gic.c                          |   83 +++++++-
 include/linux/irqchip/arm-gic.h                    |    8 +-
 include/linux/irqchip/irq-crossbar.h               |   11 ++
 12 files changed, 401 insertions(+), 75 deletions(-)
 create mode 100644 drivers/irqchip/irq-crossbar.c
 create mode 100644 include/linux/irqchip/irq-crossbar.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
