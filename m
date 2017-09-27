From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/2] memory: Introduce ti-emif-sram driver
Date: Tue, 26 Sep 2017 19:03:53 -0500
Message-ID: <20170927000355.30597-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This is v4 of the series introduces a ti-emif-sram driver to be used on
am335x and am437x, based on v4.14-rc1. This version addresses some
comments from Russell King and Johan Hovold in v3 found here [1].

The main change in this version is dropping the additions to the
arch/arm/kernel/asm-offsets.c file and instead generating our own local
"emif-asm-offsets.h" using the same strategy in the drivers/memory Makefile.
This keeps our driver changes out of the arch or platform code and is a
cleaner implementation. Otherwise some small fixups based on comments from
Johan in v3 were done.

This code is required for low-power modes to work on AM335x and AM437x and a
forthcoming PM series for those platforms will depend on this series. After
both this and the PM series are reviewed I will send the necessary device tree
changes for both, but in the meantime all remaining patches for am335x and
am437x PM can be found here [2].

Regards,
Dave

[1] https://www.spinics.net/lists/linux-omap/msg138314.html
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.14/amx3-suspend-v4

Dave Gerlach (2):
  Documentation: dt: Update ti,emif bindings
  memory: ti-emif-sram: introduce relocatable suspend/resume handlers

 .../bindings/memory-controllers/ti/emif.txt        |  18 +-
 drivers/memory/.gitignore                          |   1 +
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |  20 ++
 drivers/memory/emif-asm-offsets.c                  |  22 ++
 drivers/memory/emif.h                              |  17 ++
 drivers/memory/ti-emif-pm.c                        | 339 +++++++++++++++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 ++++++++++++++++++++
 include/linux/ti-emif-sram.h                       | 148 +++++++++
 9 files changed, 908 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/.gitignore
 create mode 100644 drivers/memory/emif-asm-offsets.c
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 include/linux/ti-emif-sram.h

-- 
2.13.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
