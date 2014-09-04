From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7-evm: fixes for mux and VTT control
Date: Thu, 4 Sep 2014 08:23:26 -0500
Message-ID: <1409837008-32144-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, rogerq@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

The following series was inspired in part by http://marc.info/?l=linux-omap&m=140974309205295&w=2
causing me to try and do an audit of pinctrl configurations on the platform.

Further, failures on latest board updates in the automated farm also
caused identification of a fix which was yet to be send to upstream
from product kernel. Slightly unrelated patches in this series.

So here they are..
based on v3.17-rc1:
before-dra7xx-evm:  Boot FAIL: http://paste.ubuntu.org.cn/1477597
(fails can be at different times though.. random crashes without VTT is usual)..
after-dra7xx-evm:  Boot PASS: http://paste.ubuntu.org.cn/1477596

Lokesh Vutla (1):
  ARM: dts: dra7-evm: Add vtt regulator support

Nishanth Menon (1):
  ARM: dts: dra7-evm: Fix spi1 mux documentation

 arch/arm/boot/dts/dra7-evm.dts |   39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
1.7.9.5
