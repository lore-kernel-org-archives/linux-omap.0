From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device Tree
Date: Tue, 13 May 2014 14:23:40 +0530
Message-ID: <5371DD94.1050400@ti.com>
References: <1399968246-21166-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399968246-21166-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony/Benoit

On Tuesday 13 May 2014 01:34 PM, Mugunthan V N wrote:
> Adding device tree entry for CPSW to make it work in Dual EMAC mode.
>
> DRA7 cpsw phy sel driver patch has been pulled in net-next git with the
> following commit id *d415fa1b88748d664b7b6a310dd8e699d2686cf7*
>
> Mugunthan V N (3):
>   pinctrl: dra7: dt-bindings: add pin off modes for dra7 SoC
>   arm/dts: dra7xx: Add CPSW and MDIO module nodes for dra7xx
>   arm/dts: dra7xx: Enable CPSW and MDIO for dra7xx EVM
>
>  arch/arm/boot/dts/dra7-evm.dts    | 103 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi       |  59 ++++++++++++++++++++++
>  include/dt-bindings/pinctrl/dra.h |   8 +++
>  3 files changed, 170 insertions(+)
>

This patch series depends on Cross bar dt patch set
http://comments.gmane.org/gmane.linux.drivers.devicetree/73025

Regards
Mugunthan V N
