From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v8 0/4] hwspinlock core & omap dt support
Date: Wed, 4 Mar 2015 20:01:12 -0600
Message-ID: <1425520876-37826-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

This is the latest version of the hwspinlock dt support series,
rebased onto v4.0-rc1 and addressing the long discussion on the
bindings in v7 [1]. I really hope that this series can make it 
into 4.1. 

Mark,
Can you please provide your Acked-by for the binding documents
so that Ohad can pick up the patches for the next merge window?

Following are the main changes in v8 w.r.t v7:
- Revised the generic hwspinlock bindings to remove hwlock-base-id and
  hwlock-num-locks properties, and added the optional hwlock-names
  property.
- Updated the core device tree patch to remove of_hwspin_lock_get_base_id()
  and of_hwspin_lock_get_num_locks() functions. Reworked the
  of_hwspin_lock_get_id() API to not use the list of registered hwspinlock
  banks, but rely on the hwspinlock radix tree itself to perform deferred
  probing and pargs lock specifier validation. The last of the two were
  added in v6, but dropped in v7, and are now restored.
- Updated the OMAP hwspinlock binding and DT support patches for the
  absence of the v7's mandatory hwlock-base-id property.
- Changed the order of patches slightly to lump the core changes together
  and the OMAP hwspinlock changes together.

The validation logs on all the applicable OMAP SoCs are at:
  OMAP4	     : http://pastebin.ubuntu.com/10533448/
  OMAP5      : http://pastebin.ubuntu.com/10533710/
  DRA7 (X15) : http://pastebin.ubuntu.com/10533486/
  AM33xx     : http://pastebin.ubuntu.com/10533623/
  AM43xx     : http://pastebin.ubuntu.com/10533538/

The above logs are generated with some additional test patches staged
here for reference,
https://github.com/sumananna/omap-kernel/commits/hwspinlock/test/4.0-rc1-dt-v8

regards
Suman

[1] https://patchwork.kernel.org/patch/5635201/

---
v7:
http://marc.info/?l=linux-omap&m=142126914027417&w=2
- Dropped the patch "hwspinlock/core: maintain a list of registered
  hwspinlock banks"
- Updated generic hwspinlock bindings to make hwlock-base-id property
  mandatory.
- Updated the OMAP hwspinlock binding and DT support patches to correct
  for the mandatory hwlock-base-id property.
- Updated the common OF helpers patch to move the of_hwspin_lock_get_base_id()
  and of_hwspin_lock_get_num_locks() functions into the internal header,
  these are no longer exported, but available for platform implementations.
  of_hwspin_lock_get_id() is also simplified now.

v6:
http://marc.info/?l=linux-omap&m=141055365213895&w=2
- of_hwspin_lock_request_specific() is replaced
  with of_hwspin_lock_get_id(). of_hwspin_lock_simple_xlate() is
  made internal, and of_hwspin_lock_get_base_id() is added.
- Updated the OMAP hwspinlock DT support patch to assign base-id
  from DT if present
- RFC patches adding the concept of reserved locks and return code
  change convention dropped.

v5:
http://marc.info/?l=linux-omap&m=139890478402807&w=2
- Rebased v4 patches plus additional RFC patches.
- Added back the patch to support DT-based hwlock-base-id property,
  for registration purposes.
- RFC patches introducing the concept of reserved locks.
- Staged patches for converting return convention to better support
  deferred probing of client drivers.

v4:
- The DT bindings are split into separate patches, and updated to
  add comments about #hwlock-cells
- Fixed a registration issue with repeated module installation and
  removal.
- Added a new OF helper to support #hwlock-cells in addition to the
  previous OF functions. The OMAP adaptation patch is updated to use
  the default translate function
- Updated hwspinlock documentation to adjust for the structure
  changes and the new api additions.
- Added build support for AM335x, AM43xx and DRA7xx
http://marc.info/?l=linux-omap&m=138965904015225&w=2

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

---

Suman Anna (4):
  Documentation: dt: add common bindings for hwspinlock
  hwspinlock/core: add device tree support
  Documentation: dt: add the omap hwspinlock bindings document
  hwspinlock/omap: add support for dt nodes

 .../devicetree/bindings/hwlock/hwlock.txt          | 59 ++++++++++++++++
 .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 26 +++++++
 Documentation/hwspinlock.txt                       | 10 +++
 MAINTAINERS                                        |  1 -
 arch/arm/mach-omap2/Makefile                       |  3 -
 arch/arm/mach-omap2/hwspinlock.c                   | 60 ----------------
 drivers/hwspinlock/hwspinlock_core.c               | 79 ++++++++++++++++++++++
 drivers/hwspinlock/omap_hwspinlock.c               | 17 +++--
 include/linux/hwspinlock.h                         |  7 ++
 9 files changed, 194 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
 delete mode 100644 arch/arm/mach-omap2/hwspinlock.c

-- 
2.3.0
