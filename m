From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Drop legacy booting for omap4 for v3.11,
 boot with device tree only
Date: Fri, 17 May 2013 12:17:46 -0700
Message-ID: <20130517191304.468.73487.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18695 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756634Ab3EQTRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 15:17:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are patches against v3.10-rc1 to drop omap4 legacy booting as
things are now working well enough for booting omap4 with device
tree.

We already have am33xx and omap5 booting with device tree only,
and converting omap4 is relatively easy with just two board-*.c
files merged as we have not accepted any new board-*.c files for
quite some time now.

By working "well enough" I mean that I can use my omap4 panda-es
with device tree with a Motorola LapDock with HDMI, DVI, HID, USB
and WLAN using v3.10-rc1 and the patches in this series plus some
extra patches that are driver related.

Of course some things will need more work, like PM. But that
has not yet been fully working for omap4 anyways, and that
work can now be combined with omap5 PM work to some extent.

Regards,

Tony


FYI, the extra patches I'm using in addition to these are:

1. GPIO regression fix (needed at least for SDP nfsroot)

   ab6ec0fb (gpio/omap: ensure gpio context is initialised)

2. HSMMC DT pbias fix

  [PATCH] mmc: omap_hsmmc: Fix the DT pbias workaround for MMC controllers 2 to 5

3. WL12XX support patches

   [PATCH 0/3] WLAN support for omap4 when booted with devicetree

4. USB host support for panda dts changes

   ARM: dts: omap4-panda: Add USB Host support

5. Fix for LapDock enumeration

   usb: musb: Fix LapDock enumeration on omap for boot and slow cable insertion

---

Tony Lindgren (6):
      ARM: OMAP2+: Remove board-4430sdp.c
      ARM: OMAP2+: Remove board-omap4panda.c
      ARM: OMAP2+: Remove legacy mux data for omap4
      ARM: OMAP2+: Remove omap4 pdata from hsmmc.c
      ARM: OMAP2+: Remove omap4 pdata for USB
      ARM: OMAP2+: Remove omap4 ocp2scp pdata


 arch/arm/mach-omap2/Kconfig                |   22 
 arch/arm/mach-omap2/Makefile               |    3 
 arch/arm/mach-omap2/board-4430sdp.c        |  765 ----------------
 arch/arm/mach-omap2/board-omap4panda.c     |  455 ---------
 arch/arm/mach-omap2/devices.c              |  123 ---
 arch/arm/mach-omap2/hsmmc.c                |  103 --
 arch/arm/mach-omap2/mux.h                  |    3 
 arch/arm/mach-omap2/mux44xx.c              | 1356 ----------------------------
 arch/arm/mach-omap2/mux44xx.h              |  298 ------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 
 arch/arm/mach-omap2/usb-host.c             |  194 ----
 arch/arm/mach-omap2/usb-musb.c             |    3 
 drivers/bus/omap-ocp2scp.c                 |   60 -
 include/linux/platform_data/omap_ocp2scp.h |   31 -
 14 files changed, 10 insertions(+), 3427 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-4430sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-omap4panda.c
 delete mode 100644 arch/arm/mach-omap2/mux44xx.c
 delete mode 100644 arch/arm/mach-omap2/mux44xx.h
 delete mode 100644 include/linux/platform_data/omap_ocp2scp.h

-- 
Signature
