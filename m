From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] omap hwspinlock dt support
Date: Tue, 3 Sep 2013 12:52:42 -0500
Message-ID: <1378230762-54895-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds the device tree support to the OMAP hwspinlock
driver. The series is based on 3.11 kernel, and currently adds
the DT node for OMAP4. Since all the OMAP SoCs on which hwspinlock
is supported are currently DT-boot only, I have combined the dt
parsing support and removing the mach-omap2/hwspinlock.c cleanup
into the first patch. This mandates that a DT node be defined
to use a hwspinlock on an OMAP SoC, even though the 3.11 kernel
could instantiate the devices normally even in a DT-boot mode.

The DT binding documentation is added using the folder name 
hwlock (same name from the MSM HW Mutex driver support series
in [1]).

[1] https://lkml.org/lkml/2013/8/14/528

Suman Anna (2):
  hwspinlock/omap: add support for dt nodes
  ARM: dts: OMAP4: Add hwspinlock node

 .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 28 ++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  6 +++
 arch/arm/mach-omap2/Makefile                       |  3 --
 arch/arm/mach-omap2/hwspinlock.c                   | 60 ----------------------
 drivers/hwspinlock/omap_hwspinlock.c               | 21 ++++++--
 5 files changed, 51 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
 delete mode 100644 arch/arm/mach-omap2/hwspinlock.c

-- 
1.8.3.3
