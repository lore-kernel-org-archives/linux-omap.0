From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/19] OMAP: more clock/powerdomain/hwmod patches for 2.6.34
Date: Mon, 15 Feb 2010 18:24:31 -0700
Message-ID: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57393 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab0BPB05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Here are some more OMAP clock, clockdomain, powerdomain, and hwmod
patches intended for 2.6.34, posted in case anyone has any comments.


- Paul

---

Abhijit Pagare (1):
      ARM: OMAP4 clock domain: Add check for avoiding dependency related update.

Kevin Hilman (4):
      OMAP: omap_device: add omap_device_is_valid()
      OMAP: omap_device: when 'called from invalid state', print state
      OMAP3: clock: use std _MASK suffix for CM_FCLKEN_IVA2 defines
      OMAP2/3: PRCM: fix misc. compiler warnings

Mike Turquette (1):
      OMAP3630: Clock: Workaround for DPLL HS divider limitation

Ranjith Lohithakshan (2):
      OMAP2/3 clock: Extend find_idlest() to pass back idle state value
      AM35xx: Add clock support for new modules on AM35xx

Richard Woodruff (1):
      OMAP3 clock: introduce DPLL4 Jtype

Sanjeev Premi (1):
      OMAP3 clock: Check return values for clk_get()

Tero Kristo (1):
      OMAP3: Clock: Added IDLEST definitions for SGX

Thara Gopinath (5):
      OMAP2/3 PM: Adding powerdomain APIs for reading the next logic and mem state
      OMAP3 PM: Defining .pwrsts_logic_ret field for core power domain structure
      OMAP3 PM: Adding counters for power domain logic off and mem off during retention.
      OMAP3: hwmod: support to specify the offset position of various SYSCONFIG register bits.
      OMAP: HWMOD: Add support for early device register into omap device layer

Vishwanath BS (3):
      OMAP3 clock: Remove FreqSel for 3630
      OMAP3 clock: Introduce 3630 DPLL4 HSDivider changes
      OMAP3 clock: add support for 192Mhz DPLL4M2 output


 arch/arm/mach-omap2/Makefile                  |    3 
 arch/arm/mach-omap2/clkt2xxx_apll.c           |    2 
 arch/arm/mach-omap2/clock.c                   |   25 +-
 arch/arm/mach-omap2/clock.h                   |    6 
 arch/arm/mach-omap2/clock2xxx.c               |    5 
 arch/arm/mach-omap2/clock34xx.c               |  167 +++++++++++
 arch/arm/mach-omap2/clock34xx.h               |    7 
 arch/arm/mach-omap2/clock34xx_data.c          |  381 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock44xx_data.c          |    1 
 arch/arm/mach-omap2/clockdomain.c             |   30 ++
 arch/arm/mach-omap2/cm-regbits-34xx.h         |   28 ++
 arch/arm/mach-omap2/cm.h                      |    3 
 arch/arm/mach-omap2/dpll3xxx.c                |   78 +++++
 arch/arm/mach-omap2/id.c                      |    3 
 arch/arm/mach-omap2/omap_hwmod.c              |  100 ++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.c  |   44 +++
 arch/arm/mach-omap2/pm-debug.c                |    5 
 arch/arm/mach-omap2/pm34xx.c                  |    2 
 arch/arm/mach-omap2/powerdomain.c             |   98 ++++++
 arch/arm/mach-omap2/powerdomains34xx.h        |    2 
 arch/arm/mach-omap2/prcm.c                    |   18 +
 arch/arm/plat-omap/include/plat/clock.h       |   16 +
 arch/arm/plat-omap/include/plat/cpu.h         |    2 
 arch/arm/plat-omap/include/plat/omap_device.h |    7 
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |   73 ++++-
 arch/arm/plat-omap/include/plat/powerdomain.h |    4 
 arch/arm/plat-omap/include/plat/prcm.h        |    3 
 arch/arm/plat-omap/omap_device.c              |   61 +++-
 28 files changed, 1077 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_data.c

