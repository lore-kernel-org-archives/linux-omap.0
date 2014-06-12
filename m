From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 0/2] ARM: dts: dra7: Add crossbar dt support
Date: Thu, 12 Jun 2014 17:35:45 +0530
Message-ID: <1402574747-14359-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58633 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933662AbaFLMH7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2014 08:07:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com

This series introduces DT support for crossbar device and
changes dra7 peripherals to use crossbar number instead of irq.

This depends on below driver fixes and cleanup series.

https://lkml.org/lkml/2014/6/12/232

[V2] Rebased on 3.15 mainline.

R Sricharan (2):
  ARM: dts: DRA7: Add routable-irqs property for gic node
  ARM: dts: DRA7: Add crossbar device binding

 arch/arm/boot/dts/dra7.dtsi |  134 ++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 58 deletions(-)

-- 
1.7.9.5

