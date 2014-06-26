From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V4 0/2] arm: dts: dra7: add crossbar dt support
Date: Thu, 26 Jun 2014 12:55:29 +0530
Message-ID: <1403767532-19290-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com, tglx@linutronix.de, jason@lakedaemon.net, joe@perches.com
List-Id: linux-omap@vger.kernel.org

This series introduces DT support for crossbar device and
changes dra7 peripherals to use crossbar number instead of irq.

This depends on below driver fixes and cleanup series.
http://marc.info/?l=linux-omap&m=140376708127157&w=2

[V2] Rebased on 3.15 mainline.
[V3] Added ti,irqs-skip property and ti,irqs-safe-map property to
     crossbar dt node.
[V4] Introduced macros MAX_SOURCES and DIRECT_IRQ

R Sricharan (2):
  arm: dts: dra7: add routable-irqs property for gic node
  arm: dts: dra7: add crossbar device binding

 arch/arm/boot/dts/dra7.dtsi |  139 +++++++++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 58 deletions(-)

-- 
1.7.9.5
