From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 00/17] Add support for Tegra210 AGIC
Date: Wed, 4 May 2016 17:25:13 +0100
Message-ID: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The Tegra210 has a 2nd level interrupt controller located in a separate
power domain to the main GIC interrupt controller and hence requires
runtime-pm support.

Add a platform driver for the GICs that require runtime-pm and make the
necessary changes to the genirq and irqdomain core to support IRQ chips
that require runtime-pm.

Please note that although as the subject states this adds support for
the Tegra210 AGIC, in this current version there is really nothing
specific in this series for Tegra. However, rather than changing the
subject I opted to keep it the same so people recognise this is a
continuation of that work.

Changes since V2:
- Corrected RPM support for irqchips in genirq core as pointed out by
  Kevin Hilman.
- Corrected patch to save the irq type when mapping the interrupt.
- Dropped changes to DT binding documentation and added patch to prevent
  early init of GICs if the 'clocks' and/or 'power-domains' DT
  properties are present (as we have discussed).
- Moved platform driver code into it's own source file.
- Separate changes for preparing for the platform driver into 3 patches
  in an attempt to make it more readable!
- Added fix for checking an interrupt descriptor is valid during IRQ
  setup.

Changes since V1:
- Updated GIC to only WARN and not return an error if configuring a PPI
  fails but will still return an error if an SPI fails (per discussion
  with Marc).
- Dropped change to mask sense bits for GIC-v3 (as this is not
  necessary)
- Split patch to avoid setting interrupt type when mapping the IRQ into
  two patches per TGLX's feedback.
- Changed name of irqchip device structure to "parent_device"
- Moved call to irq_chip_pm_get() outside of chip_bus_lock().
- Dropped patch to remove clock names from GIC DT documentation and
  added AGIC clock names.
- Update GIC platform driver to look-up clocks names from static list.

Jon Hunter (17):
  irqchip/gic: Don't unnecessarily write the IRQ configuration
  irqchip/gic: WARN if setting the interrupt type for a PPI fails
  irqchip: Mask the non-type/sense bits when translating an IRQ
  irqdomain: Fix handling of type settings for existing mappings
  genirq: Look-up trigger type if not specified by caller
  irqdomain: Don't set type when mapping an IRQ
  genirq: Ensure IRQ descriptor is valid when setting-up the IRQ
  genirq: Add runtime power management support for IRQ chips
  irqchip/gic: Don't initialise chip if mapping IO space fails
  irqchip/gic: Remove static irq_chip definition for eoimode1
  irqchip/gic: Return an error if GIC initialisation fails
  irqchip/gic: Pass GIC pointer to save/restore functions
  irqchip/gic: Don't allow early initialisation if GIC requires RPM
  irqchip/gic: Add helper function for configuring a GIC via device-tree
  irqchip/gic: Split GIC init in preparation for platform driver
  irqchip/gic: Prepare for adding platform driver
  irqchip/gic: Add platform driver for non-root GICs that require RPM

 drivers/irqchip/Kconfig          |   6 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-crossbar.c   |   2 +-
 drivers/irqchip/irq-gic-common.c |  19 ++-
 drivers/irqchip/irq-gic-pm.c     | 241 ++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c        | 277 +++++++++++++++++++++++----------------
 drivers/irqchip/irq-gic.h        |  63 +++++++++
 drivers/irqchip/irq-tegra.c      |   2 +-
 include/linux/irq.h              |   4 +
 include/linux/irqdomain.h        |   3 +
 kernel/irq/chip.c                |  35 +++++
 kernel/irq/internals.h           |   1 +
 kernel/irq/irqdomain.c           |  58 ++++++--
 kernel/irq/manage.c              |  40 +++++-
 14 files changed, 617 insertions(+), 135 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-pm.c
 create mode 100644 drivers/irqchip/irq-gic.h

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
