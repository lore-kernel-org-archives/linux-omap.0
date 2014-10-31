From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] Add support for ADC on am437x-gp and am43x-epos-evm
Date: Fri, 31 Oct 2014 13:16:40 +0530
Message-ID: <1414741603-18233-1-git-send-email-vigneshr@ti.com>
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

Vignesh R (3):
  arm: mach-omap2: omap_hwmod_33xx_43xx_ipblock_data: Move
    am33xx_l4_hs_hwmod to ipblock_data
  arm: mach-omap2: omap_hwmod_43xx_data: add hwmod support for tscadc on
    am43x-evm
  arm: boot: dts: am4372: add tscadc DT entries for am437x-evm and
    am43x-epos-evm

 arch/arm/boot/dts/am4372.dtsi                      | 20 ++++++
 arch/arm/boot/dts/am437x-gp-evm.dts                |  8 +++
 arch/arm/boot/dts/am43x-epos-evm.dts               |  8 +++
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 79 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 64 ------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  1 +
 7 files changed, 118 insertions(+), 64 deletions(-)

-- 
1.9.1
