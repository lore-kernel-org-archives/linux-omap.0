From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Two ti-sysc driver fixes for v5.3 merge window
Date: Wed,  1 May 2019 14:41:27 -0700
Message-ID: <20190501214129.12572-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few fixes for the am335x d_can boot issue Sebastian reported for
Beaglebone.

Regards,

Tony


Tony Lindgren (2):
  ARM: dts: Configure osc clock for d_can on am335x
  bus: ti-sysc: Handle devices with no control registers

 arch/arm/boot/dts/am33xx-l4.dtsi | 14 ++++++--------
 arch/arm/boot/dts/am437x-l4.dtsi |  4 ----
 drivers/bus/ti-sysc.c            | 23 +++++++++++------------
 3 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.21.0
