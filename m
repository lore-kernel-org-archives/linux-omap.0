From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] ARM: dts: OMAP3630+: Add ABB device nodes
Date: Wed, 29 Jan 2014 17:46:12 -0600
Message-ID: <1391039177-25284-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Now that clock nodes have been merged to master,
refresh of the series meant for all TI platforms using ABB.
Originally posted [1], I will restart with v1.

dt bindings and driver is already in upstream, and only the dt node is missing.

NOTE: dra7 support depends on [2] - but dt can get sequenced as needed.

This series is based on:
master     0e47c96 Merge tag 'for-linus-20140127' of git://git.infradead.org/linux-mtd
Testing was performed on next-20140123[3]

Andrii.Tseglytskyi (3):
  ARM: dts: OMAP36xx: Add device node for ABB
  ARM: dts: OMAP4: Add device nodes for ABB
  ARM: dts: OMAP5: Add device nodes for ABB

Nishanth Menon (1):
  ARM: dts: DRA7: Add device nodes for ABB

 arch/arm/boot/dts/dra7.dtsi     |  132 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap36xx.dtsi |   20 ++++++
 arch/arm/boot/dts/omap4.dtsi    |   26 ++++++++
 arch/arm/boot/dts/omap443x.dtsi |   26 ++++++++
 arch/arm/boot/dts/omap4460.dtsi |   37 +++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   63 +++++++++++++++++++
 6 files changed, 304 insertions(+)

[1] http://marc.info/?l=linux-omap&m=136751535923806&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/log/?h=topic/ti-abb
[3] https://patchwork.kernel.org/patch/3530111/

-- 
1.7.9.5
