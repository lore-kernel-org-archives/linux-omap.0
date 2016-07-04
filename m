From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/4] ARM: dts: TPS65218: Clean ups
Date: Mon, 4 Jul 2016 15:25:09 +0530
Message-ID: <1467626113-15705-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lee.jones@linaro.org, broonie@kernel.org, robh+dt@kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Now that all the driver patches are Acked by respective sub-system
Maintainers. Here is the set of Device Tree patches. Another set
of Device Tree patches were posted earlier which touch the same
files: https://lkml.org/lkml/2016/7/4/36

This series is on top of the above patch set. This series applies
cleanly on top of the above patchset.

Boot tested on am437x-sk-evm and am437x-gp-evm.

Keerthy (4):
  ARM: dts: AM437X-GP-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-CM-T43: Remove redundant regulator compatibles
  ARM: dts: AM43X-EPOS-EVM: Remove redundant regulator compatibles

 arch/arm/boot/dts/am437x-cm-t43.dts  | 6 ------
 arch/arm/boot/dts/am437x-gp-evm.dts  | 6 ------
 arch/arm/boot/dts/am437x-sk-evm.dts  | 5 -----
 arch/arm/boot/dts/am43x-epos-evm.dts | 7 -------
 4 files changed, 24 deletions(-)

-- 
1.9.1
