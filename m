From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v5 0/4] OMAP GPMC DT bindings
Date: Wed, 28 Nov 2012 15:38:25 +0100
Message-ID: <1354113509-7972-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:60468 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277Ab2K1Oih (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 09:38:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, Daniel Mack <zonque@gmail.com>

This is a series of patches to support GPMC peripherals on OMAP boards.

Depends on Linus' master +
omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)

The only supported peripheral for now is NAND, but other types would be
easy to add.

Version 2 addresses details pointed out by Jon Hunter, Afzal Mohammed
and Rob Herring:

 - add "reg" and "ti,hwmod" properties to Documentation
 - use generic of_mtd functions and the property names defined by them,
   namely "nand-bus-width" and "nand-ecc-mode"
 - reduce the default register space size in the Documentation to 8K,
   as found in the hwmod code
 - switch to a DT layout based on ranges and address translation.
   Although this property is not currently looked at as long as the
   handling code still uses the runtime calculation methods, we now
   have these values in the bindings, eventually allowing us to
   switch the implementation with less pain.

Version 3 includes fixes pointed out by Jon Hunter:

 - better documentation of the 'ranges' property to describe the
   fact that it's representing the CS lines
 - GPMC_CS_CONFIGx -> GPMC_CONFIGx in comments
 - drop interrupt-parent from example bindings
 - add of_node_put() at the end of the child iteration

Version 4 fixes compilation for !CONFIG_MTD_NAND and includes more
details from Jon Hunter and Avinash, Philip:

 - Add "num-cs" and "num-waitpins" properties, which will eventually
   be used to get rid of GPMC_CS_NUM
 - Better description of generic nand DT properties
 - Dropped patch 3/4 as an equivalent fix was already merged
 - Added ti,nand-ecc-use-elm property

Version 5 with regards to Avinash, Philip and Peter Korsgaard:

 - Re-add accidentially forgotten
   Documentation/devicetree/bindings/bus/ti-gpmc.txt
 - Rename "software" ecc mode to "sw"
 - Initialize gpmc_nand_data->is_elm_used to 'true' rather than 1
 - Drop ti,nand-ecc-use-elm binding in favor of a new ecc mode
   named "bch8-am335xrbl-compatible"
 - Add two more patches for section mismatch fixups

Daniel Mack (4):
  mtd: omap-nand: pass device_node in platform data
  ARM: OMAP: gpmc-nand: drop __init annotation
  ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
  ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  76 +++++++++
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  81 +++++++++
 arch/arm/mach-omap2/gpmc-nand.c                    |  15 +-
 arch/arm/mach-omap2/gpmc.c                         | 181 ++++++++++++++++++++-
 drivers/mtd/nand/omap2.c                           |   4 +-
 5 files changed, 348 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

-- 
1.7.11.7

