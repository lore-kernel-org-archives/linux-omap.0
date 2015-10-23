From: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
Subject: [PATCH 0/5] Device tree support for AM35xx M-USB driver
Date: Fri, 23 Oct 2015 17:42:51 +0200
Message-ID: <562A557B.4090501@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The M-USB drivers glue code for AM35xx SOCs does not yet support device
trees.

In legacy kernels, it was left to the respective board_ file to set up
some necessary data structures before calling am35x_probe(). To support
initialization using a DT, this now needs to be done in am35x.c.

These data structures including a set of four pointers to CPU-specific
helper functions from the mach-omap2 directory.

Unfortunately those functions are only declared locally under
arch/arm/mach-omap2/, and they can not easily be moved over to am35x.c.
(While they just set a few bits in some system control module registers,
they call functions from control.c to access the SCM. These control.c
functions are also declared locally in mach-omap2 and not exported,
and use some static variables and several other local include files.)

So if we want these four functions to be accessible from the driver glue
code, their declarations have to be moved to the include/ hierarchy and
their names need to be exported. This makes it possible to use the am35x
M-USB driver as a kernel module.

The patch defines a new device 'compatible' name (am35x-musb) to
differentiate it from omap3-musb. It also adds clock name declarations
for interface and function clock to the device tree, so the am35x
glue code's clk_get() calls can find them.

Rolf Peukert (5):
  Make am35x helper function declarations accessible
  Export am35x helper functions
  Add device tree support for M-USB on AM35xx SOCs
  Use new MUSB device name in AM3517 device tree.
  Add some information about the new DT device name

 Documentation/devicetree/bindings/usb/omap-usb.txt | 35 +++++++++++
 arch/arm/boot/dts/am3517.dtsi                      |  4 +-
 arch/arm/mach-omap2/omap_phy_internal.c            |  4 ++
 arch/arm/mach-omap2/usb.h                          |  5 --
 drivers/usb/musb/am35x.c                           | 73
++++++++++++++++++++++
 include/linux/platform_data/usb-omap.h             |  5 ++
 6 files changed, 120 insertions(+), 6 deletions(-)

-- 
2.4.10
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
