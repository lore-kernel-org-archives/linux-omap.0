From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] arm: dts: complete dm816x device tree
Date: Thu, 22 Oct 2015 11:19:05 +0200
Message-ID: <5628AA09.506@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In order to fix support for the dm816x platform, add missing bits in
the dm816x dtsi.

The last patch adds support for the omap4-hwspinlock.

Neil Armstrong (4):
  arm: dts: add dm816x missing #mbox-cells
  arm: dts: add dm816x missing spi DT dma handles
  arm: dts: add dm816x pwm property to timers
  arm: dts: Add omap4-hwspinlock support in dm816x

 arch/arm/boot/dts/dm816x.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
1.9.1
