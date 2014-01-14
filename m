From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv4 0/7] omap hwspinlock dt support
Date: Mon, 13 Jan 2014 18:19:17 -0600
Message-ID: <1389658764-39199-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This is an updated series mainly addressing Mark Rutland's comments
about hwlock specifier being always one-cell. The series adds the
support for #hwlock-cells property and adds a simple default OF
translate function.

The DTS patches from previous series have already been merged, and
needs this property to be added. This is handled in a separate series
that only deals with OMAP hwspinlock DTS patches.

The series, along with the DTS patches, is tested on top of v3.13-rc8
plus Tero's v13 clock DT series and Tony's 3.14 staged branches. The
validation on OMAP5, DRA7, AM437 requires Tero's series with couple of
additional base patches for AM43xx. AM43xx functionality needs a hwmod
fix [1] for creating the associated omap_device as well.

The validation logs on all the applicable OMAP SoCs are at:
  OMAP4 - http://paste2.org/YJ7ZwG80
  OMAP5 - http://paste2.org/c6vO96b9
  DRA7  - http://paste2.org/tHvxN439
  AM33x - http://paste2.org/AjCv0U4t
  AM43x - http://paste2.org/2AKIPa55

The kernel with the test patches plus the various pulled in branches
is here for reference (not for merging)
https://github.com/sumananna/omap-kernel/commits/hwspinlock/3.13-rc8-v4-test

[1] http://marc.info/?l=linux-omap&m=138939747524820&w=2

Changes new in v4:
- The DT bindings are split into separate patches, and updated to
  add comments about #hwlock-cells (Patches 1 & 2)
- Fixed a registration issue with repeated module installation and
  removal. (Patch 3)
- Added a new OF helper to support #hwlock-cells in addition to the
  previous OF functions (Patch 4). The OMAP adaptation patch is
  updated to use the default translate function (Patch 5)
- Updated hwspinlock documentation to adjust for the structure
  changes and the new api additions. (Patches 3, 4)
- Added build support for AM335x, AM43xx and DRA7xx (Patch 7)
- The AM335/AM43x fix patch is unchanged (Patch 6)

v3:
- Removed the DT property hwlock-base-id and associated OF helper
- Added changes in core to support requesting a specific hwlock using
  phandle + args approach
- Revised both the common and OMAP DT bindings document
http://marc.info/?l=linux-omap&m=138143992932197&w=2

v2:
- Added a new common DT binding documentation and OF helpers.
- Revised OMAP DT parse support to use the new OF helper (Patch2)
- OMAP5 hwspinlock support including the hwmod entry and DT node
- Add AM335x support to OMAP hwspinlock driver, including a fix
  needed in driver given that AM335 spinlock module requires s/w wakeup
- AM335 DT node for spinlock, and a hwmod change to enable smart-idle
  for AM335.
- OMAP4 DT node patch is unchanged
http://marc.info/?l=linux-omap&m=137944644112727&w=2

v1:
- Add DT parse support to OMAP hwspinlock driver
- Add OMAP4 DT node and bindings information
http://marc.info/?l=linux-omap&m=137823082308009&w=2

Suman Anna (7):
  Documentation: dt: add common bindings for hwspinlock
  Documentation: dt: add the omap hwspinlock bindings document
  hwspinlock/core: maintain a list of registered hwspinlock banks
  hwspinlock/core: add common OF helpers
  hwspinlock/omap: add support for dt nodes
  hwspinlock/omap: enable module before reading SYSSTATUS register
  hwspinlock/omap: enable build for AM33xx, AM43xx & DRA7xx

 .../devicetree/bindings/hwlock/hwlock.txt          |  52 +++++++
 .../devicetree/bindings/hwlock/omap-hwspinlock.txt |  24 ++++
 Documentation/hwspinlock.txt                       |  36 ++++-
 MAINTAINERS                                        |   1 -
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/hwspinlock.c                   |  60 --------
 drivers/hwspinlock/Kconfig                         |   2 +-
 drivers/hwspinlock/hwspinlock_core.c               | 159 ++++++++++++++++++++-
 drivers/hwspinlock/hwspinlock_internal.h           |   6 +
 drivers/hwspinlock/omap_hwspinlock.c               |  39 +++--
 include/linux/hwspinlock.h                         |  20 ++-
 11 files changed, 321 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
 delete mode 100644 arch/arm/mach-omap2/hwspinlock.c

-- 
1.8.4.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
