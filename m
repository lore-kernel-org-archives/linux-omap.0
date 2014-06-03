From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 00/14] irqchip: crossbar: driver fixes
Date: Tue, 3 Jun 2014 12:59:43 +0530
Message-ID: <1401780597-4735-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49728 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbaFCHcI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2014 03:32:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk, r.sricharan@ti.com

This series does some cleanup and provides support for
hardwired IRQ and crossbar definitions.

On certain platforms such as DRA7, SPIs 0, 1, 2, 3, 5, 6, 10,
131, 132, 133 are direct wired to hardware blocks bypassing
crossbar. This quirky implementation is *NOT* supposed to be the
expectation of crossbar hardware usage. This series adds support
to represent such hard-wired irqs through DT and avoid generic
allocation/programming of crossbar in the driver.

This way of supporting hard-wired irqs was a result of
the below discussions.
http://www.spinics.net/lists/arm-kernel/msg329946.html

Based on linux-next next-20140602 tag + Tony's omap-for-v3.16/crossbar branch.

Nishanth Menon (11):
  irqchip: crossbar: remove IS_ERR_VALUE check
  irqchip: crossbar: fix sparse warnings
  irqchip: crossbar: fix checkpatch warning
  irqchip: crossbar: fix kerneldoc warning
  irqchip: crossbar: fix memory leak incase of invalid entry
  irqchip: crossbar: return proper error value
  irqchip: crossbar: change the goto naming
  irqchip: crossbar: introduce ti,max-crossbar-sources to identify
    valid crossbar mapping
  irqchip: crossbar: introduce centralized check for crossbar write
  Documentation: dt: OMAP: crossbar: add description for interrupt
    consumer
  irqchip: crossbar allow for quirky hardware with direct hardwiring of
    GIC

Rajendra Nayak (1):
  irqchip: crossbar: DRA7: Fix unused crossbar list

Sricharan R (2):
  irqchip: crossbar: set cb pointer to null in case of error
  irqchip: crossbar: Add kerneldoc for crossbar_domain_unmap callback

 .../devicetree/bindings/arm/omap/crossbar.txt      |   27 +++++
 drivers/irqchip/irq-crossbar.c                     |  127 +++++++++++++++-----
 2 files changed, 125 insertions(+), 29 deletions(-)

-- 
1.7.9.5

