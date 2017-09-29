From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: Re: [PATCH v3 0/4] Update TMDSEVM3530 support for omap3-evm
Date: Thu, 28 Sep 2017 21:04:10 -0500
Message-ID: <20170929020347.GA30051@exodus.localdomain>
References: <20170912034659.13184-1-woods.technical@gmail.com>
 <20170912234824.6706-1-woods.technical@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170912234824.6706-1-woods.technical@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 12, 2017 at 06:48:20PM -0500, Derald D. Woods wrote:
> This patch set allows TMDSEVM3530(omap3-evm.dts) to boot using common
> processor module data that is shared with 'omap3-evm-37xx.dts'. A new
> common file for processor module data is introduced to help facilitate
> the updated OMAP3530 support.
> 


Are there any further concerns after v3?

Derald


> Changes in v3
> -------------
> - Drop unnecessary compatible string change to Sharp LCD panel
> 
> Changes in v2
> -------------
> - Pull in change from linux-next
>   (ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc")
> - Add compatible and supply fix for LCD panel
> - Add supply references for DSS
> - Add "Signed-off-by" for each patch
> 
> Derald D. Woods (4):
>   ARM: dts: omap3-evm-37xx: Add common processor module support
>   ARM: dts: omap3-evm: Add OMAP3530 specific device tree processor data
>   ARM: dts: omap3: Add Sharp LS037V7DW01 'envdd' supply
>   ARM: dts: omap3-evm: Add DSS {vdds_dsi,vdda_video}-supply references
> 
>  arch/arm/boot/dts/omap3-evm-37xx.dts               | 209 +-------------------
>  arch/arm/boot/dts/omap3-evm-processor-common.dtsi  | 216 +++++++++++++++++++++
>  arch/arm/boot/dts/omap3-evm.dts                    |  76 +++++++-
>  .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   1 +
>  4 files changed, 290 insertions(+), 212 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-evm-processor-common.dtsi
> 
> -- 
> 2.14.1
> 
