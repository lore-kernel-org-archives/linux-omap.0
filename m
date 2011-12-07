From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/4] ARM: OMAP2+: Interrupt controllers adaptation to DT
Date: Wed, 7 Dec 2011 21:50:45 +0100
Message-ID: <1323291049-24964-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58678 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab1LGUvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 15:51:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony and Rob,

Here is the series to take advantage of the new DT interrupt init mechanism.
Thanks to Mark's CONFIG_MULTI_IRQ_HANDLER series, OMAP4 just has to
use the default GIC binding and does not need some OMAP specific hacks
anymore.
OMAP2 and 3 are using a simple interrupt controller that can thus expose
a simpler binding.

This series is based on rmk/devel-stable branch to get Mark's series +
a couple of OMAP fixes.

An extra fix is needed before for the board-generic.c file: 
[PATCH] ARM: OMAP2+: board-generic: Add missing handle_irq

The series with all the dependencies merged is available here for reference:
git://gitorious.org/omap-pm/linux.git for_3.3/2_dt_irq

Regards,
Benoit


Benoit Cousson (4):
  arm/dts: OMAP4: Update DTS file with new GIC bindings
  ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
  arm/dts: OMAP3: Add interrupt-controller bindings for INTC
  ARM: OMAP2+: board-generic: Use of_irq_init API

 .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++++++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 ++-
 arch/arm/boot/dts/omap4.dtsi                       |    3 +-
 arch/arm/mach-omap2/board-generic.c                |   30 +++++++++--------
 arch/arm/mach-omap2/common.h                       |   10 ++++++
 arch/arm/mach-omap2/irq.c                          |   35 ++++++++++++++++++--
 6 files changed, 91 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt

