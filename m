From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/3] Add support for ADC on am437x-gp and am43x-epos-evm
Date: Tue, 4 Nov 2014 16:45:25 +0530
Message-ID: <1415099728-10959-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

This series of patches enable ADC on am437x-gp-evm and am43x-epos-evm.
The ADC clock hwmod data of am33xx has been moved to commom place so that
both am43xx and am33xx can reuse them.
tscadc DT node has been adided to am437x-gp and am43x-epos dt files.
With these patches, ADC functionalities are now available on am43xx.

Changelog:

v2:
Removed phy addresses in hwmod. Using DT instead.
Removed unused "ti,am4372" compatible string.
Use macro to set clk domain name.
Fixed subject format of all patches

Vignesh R (3):
  ARM: OMAP2+: hwmod: AM335x/AM43x: Move am33xx_l4_hs_hwmod to
    ipblock_data
  ARM: OMAP2+: hwmod: AM335x/AM43x: add hwmod support for tscadc on
    am43x-evm
  ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and
    am43x-epos-evm

 arch/arm/boot/dts/am4372.dtsi                      | 20 ++++++
 arch/arm/boot/dts/am437x-gp-evm.dts                |  8 +++
 arch/arm/boot/dts/am43x-epos-evm.dts               |  8 +++
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 71 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 64 -------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  1 +
 7 files changed, 110 insertions(+), 64 deletions(-)

-- 
1.9.1
