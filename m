From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/4] omap: Fix broken pbias device creation
Date: Mon, 27 Jul 2015 17:46:37 +0530
Message-ID: <1437999401-3519-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, t-kristo@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

pbias device creation got broken once SCM cleanup got merged.
This patch series re-enables device creation by adding
"simple-bus" in the compatible property of the syscon
dt node.

validated this series in DRA72, OMAP4 PANDA and OMAP5 UEVM
boards.

Kishon Vijay Abraham I (4):
  ARM: dts: omap24xx: Fix broken pbias device creation
  ARM: dts: OMAP4: Fix broken pbias device creation
  ARM: dts: OMAP5: Fix broken pbias device creation
  ARM: dts: dra7: Fix broken pbias device creation

 arch/arm/boot/dts/dra7.dtsi     |    2 +-
 arch/arm/boot/dts/omap2430.dtsi |    3 ++-
 arch/arm/boot/dts/omap4.dtsi    |    3 ++-
 arch/arm/boot/dts/omap5.dtsi    |    3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.7.9.5
