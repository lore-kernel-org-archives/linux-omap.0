From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v8 0/5] OMAP GPMC DT bindings
Date: Fri, 14 Dec 2012 11:36:39 +0100
Message-ID: <1355481404-27695-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:57566 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579Ab2LNKhN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 05:37:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>

This is a series of patches to support GPMC peripherals on OMAP boards.

Tested on Linus' master +
omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)

Generated from linux-next as of today, resolving one trivial include
file rebase conflict.

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

Version 6:

 - Dropped "bch8-am335xrbl-compatible" mode again. As discussed with
   Avinash, the ELM issue will be solved subsequently in s separate
   series.
 - re-added a patch to bail out of automatic GPMC instanciation in
   case of DT boot.
 - re-added the "of_node" addition in mtd_nand_omap2.h in 2/5

Version 7: comments from Jon Hunter, all affecting the documentation:

 - add num-wait pins properties as they are marked 'required'
 - make reg sizes consistent
 - AM335x only has 2 wait-pins

Version 8: comments from Grant, thanks to Jon for the summary of all
the derivates:

 - Added specific compatible strings for different derivates of OMAPs
 - Renamed num-cs to gpmc,num-cs
 - Renamed num-waitpins to gpmc,num-waitpins


Daniel Mack (5):
  ARM: OMAP: gpmc: don't create devices from initcall on DT
  mtd: omap-nand: pass device_node in platform data
  ARM: OMAP: gpmc-nand: drop __init annotation
  ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
  ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  84 ++++++++++
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  76 +++++++++
 arch/arm/mach-omap2/gpmc-nand.c                    |  15 +-
 arch/arm/mach-omap2/gpmc.c                         | 182 ++++++++++++++++++++-
 drivers/mtd/nand/omap2.c                           |   4 +-
 include/linux/platform_data/mtd-nand-omap2.h       |   4 +-
 6 files changed, 355 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

-- 
1.7.11.7

