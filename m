From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/3] ARM: dts: Enable suspend configuration
Date: Mon, 4 Jul 2016 12:03:59 +0530
Message-ID: <1467614042-6838-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lee.jones@linaro.org, broonie@kernel.org, robh+dt@kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Now that all the driver patches are Acked-by the respective driver
Maintainers. Here is the set of Device Tree patches which were
dependent on the driver patches.

These are boot tested on am437x-sk-evm, am437x-gp-evm, am335x-bone,
am335x-boneblack.

Keerthy (1):
  ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3 dcdc5 and dcdc6
    enable during suspend

Tero Kristo (2):
  ARM: dts: am437x-gp-evm: disable DDR regulator in rtc-only/poweroff
    mode
  ARM: dts: am437x-sk-evm: disable DDR regulator in rtc-only/poweroff
    mode

 arch/arm/boot/dts/am437x-gp-evm.dts | 13 +++++++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts | 30 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
1.9.1
