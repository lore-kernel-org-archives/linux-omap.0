From: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 0/1] ARM: dts: am335x: Fix UARTs length
Date: Wed, 24 Jul 2019 14:23:28 +0200
Message-ID: <20190724122329.21231-1-manu@freebsd.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
List-Id: linux-omap@vger.kernel.org

For some reason the uart region size were set to 0x2000 while the TRM clearly
specify that the size is 0x1000.
I guess this is not a problem on Linux but for FreeBSD the resource manager will
not allow the mapping when the region declared in the parents is less that the one
declared in the child.

Emmanuel Vadot (1):
  ARM: dts: am335x: Fix UARTs length

 arch/arm/boot/dts/am33xx-l4.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.22.0
