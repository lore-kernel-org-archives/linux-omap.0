From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v6 0/2] memory: Introduce ti-emif-sram driver
Date: Thu, 30 Nov 2017 16:56:06 -0600
Message-ID: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Russell King <linux@armlinux.org.uk>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

This is a resend of v5 of this series found here [1]. It introduces
relocatable PM handlers for the emif that are copied to sram and
run from there during low power mode entry.

The patches still have the previous ACKs but have a small change to
accomodate a change made by Tony in commit cd57dc5a2099 ("ARM: dts:
Add missing hwmod related nodes for am33xx"). If there are objections
to this let me know ASAP.

Now that a hwmod is present for the am335x EMIF, on probe fail the call to
pm_runtime_put_sync causes the board to hang. In fact, this emif driver should
never alter the PM state of the hardware at all through normal kernel calls, it
is the job of the suspend handlers that are added, that is the whole point of
this driver. Because of this, I have dropped all runtime pm calls, as any
change to the PM state while the kernel is running is dangerous as we may shut
of the memory controller. It makes the most sense just to drop runtime PM from
the driver entirely. Besides that patch is unchanged.

This code is required for low-power modes to work on AM335x and AM437x and a
forthcoming PM series for those platforms will depend on this series. After
both this and the PM series are reviewed I will send the necessary device tree
changes for both, but in the meantime all remaining patches for am335x and
am437x PM can be found here [2].

Regards,
Dave

[1] https://www.spinics.net/lists/arm-kernel/msg611537.html
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.15/amx3-suspend-v6

Dave Gerlach (2):
  Documentation: dt: Update ti,emif bindings
  memory: ti-emif-sram: introduce relocatable suspend/resume handlers

 .../bindings/memory-controllers/ti/emif.txt        |  17 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   8 +
 drivers/memory/Makefile.asm-offsets                |   5 +
 drivers/memory/emif-asm-offsets.c                  |  92 ++++++
 drivers/memory/emif.h                              |  17 ++
 drivers/memory/ti-emif-pm.c                        | 325 ++++++++++++++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 +++++++++++++++++++++
 include/linux/ti-emif-sram.h                       |  69 +++++
 9 files changed, 876 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/Makefile.asm-offsets
 create mode 100644 drivers/memory/emif-asm-offsets.c
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 include/linux/ti-emif-sram.h

-- 
2.15.0
