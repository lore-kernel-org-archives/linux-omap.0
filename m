From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv12 0/9] OMAP3+: PRCM chain handler
Date: Thu, 15 Dec 2011 14:36:09 -0700
Message-ID: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40988 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1LOVhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:37:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This is a repost of Tero's PRCM chain handler patch set with a few changes:

- A new mux patch has been added to place hwmod mux entries with
  OMAP_DEVICE_PAD_WAKEUP set into the dynamic list

- Several OCP barriers have been added to PRM writes to try to protect
  against races between PRM register writes and the MPU

- Kerneldoc documentation has been added

- The pending IRQ test functions have been split into per-SoC versions

- Some patches have been rearranged and merged to avoid churn

- The PRM IRQ handler is now installed on OMAP4

This updated series has been tested on OMAP3530 BeagleBoard in dynamic idle
with off-mode enabled, although the functions that do dynamic IRQ mapping
have not been tested.

I've preserved Signed-off-by:s and other tags, even though the patches
have been rearranged.  Any further testing would be appreciated, and if any
Signed-off-by: or other tag does not belong, please advise and I'll remove it.
I'd like to send Tony a pull request for this tomorrow.

Original series description follows:

From: Tero Kristo <t-kristo@ti.com>

PRCM chain handler is adding a support to the omap3+ kernel that
allows different drivers to use PRCM interrupt events for their
own purposes, typically this means IO wakeups. This work was
attempted to integrate as its own driver at some point of
the evolution of this set, however this was now postponed as
the lacking support is basically blocking a few drivers.

---

tk_prm_chain_handler_devel_3.3
   text	   data	    bss	    dec	    hex	filename
6476701	 671380	5588224	12736305	 c25731	vmlinux.omap2plus_defconfig.orig
6483705	 671468	5588224	12743397	 c272e5	vmlinux.omap2plus_defconfig.patched


Govindraj R (1):
      ARM: OMAP2+: hwmod: Add API to enable IO ring wakeup

Paul Walmsley (2):
      ARM: OMAP2+: mux: add wakeup-capable hwmod mux entries to dynamic list
      ARM: OMAP3/4: PRM: add functions to read pending IRQs, PRM barrier

Tero Kristo (6):
      ARM: OMAP: PRCM: add support for chain interrupt handler
      ARM: OMAP: PRCM: add suspend prepare / finish support
      ARM: OMAP2+: mux: add support for PAD wakeup interrupts
      ARM: OMAP: hwmod: add support for selecting mpu_irq for each wakeup pad
      ARM: OMAP3: pm: use prcm chain handler
      ARM: OMAP4: PRM: use PRCM interrupt handler


 arch/arm/mach-omap2/Makefile                 |    5 
 arch/arm/mach-omap2/mux.c                    |   89 +++++++
 arch/arm/mach-omap2/omap_hwmod.c             |  102 ++++++++
 arch/arm/mach-omap2/pm34xx.c                 |  115 ++++-----
 arch/arm/mach-omap2/prcm-common.h            |   75 ++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |   97 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    9 +
 arch/arm/mach-omap2/prm44xx.c                |  116 +++++++++
 arch/arm/mach-omap2/prm44xx.h                |    8 +
 arch/arm/mach-omap2/prm_common.c             |  320 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 
 11 files changed, 860 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm_common.c

