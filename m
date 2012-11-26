From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 0/5] Device Paths introduced and applied to generic hub
 and panda
Date: Mon, 26 Nov 2012 12:45:29 +0000
Message-ID: <20121126123427.18106.4112.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

NB this is against usb-next at 3.7-rc6

The following series introduces "wildcard device paths" as discussed recently;
in particular the wildcard idea is from Alan Stern.

First the API is introduced for generating, comparing and registering
the wildcard device paths.  I put them in drivers/base for now but if
that seems wrong it's easy to move.  They are a default n CONFIG_ option.

Then I remove the ehci-omap existing regulator support completely.

Third I add optional regulator support to the usb generic hub.  This uses
wildcard device path APIs to look for a regulator that matches the hub.
Again the support is optional on a default n CONFIG_ option.  If the
regulator is found, then it is enabled for the lifetime of the matching
logical hub object.

Board support for OMAP4 Panda is added which provides regulators with the
correct wildcard name to match the ehci-omap.0 root hub object.  The
wildcard name is registered so it will be used as a literal on any matching
generated device path.

Lastly there's a config delta on omap2plus_defconfig which enables EHCI,
which is otherwise disabled by default.

The end result is that the SMSC HUB+ETH chip is off by default at boot, and
is powered cleanly for the lifecycle of the ehci-hcd root hub object.

Comments welcome, this is my first attempt at turning the discussion of the
last few days into an implementation, it is working here well on Panda ES.

-Andy

---

Andy Green (5):
      drivers : introduce device_path api
      usb: omap ehci: remove all regulator control from ehci omap
      usb: hub: add device_path regulator control to generic hub
      omap4: panda: add smsc95xx regulator and reset dependent on root hub
      config omap2plus add ehci bits


 arch/arm/configs/omap2plus_defconfig   |   42 +++----
 arch/arm/mach-omap2/Kconfig            |    1 
 arch/arm/mach-omap2/board-omap4panda.c |   90 +++++++++++++---
 drivers/base/Kconfig                   |    6 +
 drivers/base/Makefile                  |    2 
 drivers/base/core.c                    |    2 
 drivers/base/path.c                    |  181 ++++++++++++++++++++++++++++++++
 drivers/usb/core/Kconfig               |   10 ++
 drivers/usb/core/hub.c                 |   26 ++++-
 drivers/usb/host/ehci-omap.c           |   33 ------
 include/linux/device.h                 |   12 ++
 11 files changed, 327 insertions(+), 78 deletions(-)
 create mode 100644 drivers/base/path.c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
