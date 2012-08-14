From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 0/4] Add AM33XX regulators device tree data
Date: Tue, 14 Aug 2012 14:25:11 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA12932@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35725 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756473Ab2HNOZX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 10:25:23 -0400
In-Reply-To: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

Hi Mark,

On Tue, Jul 24, 2012 at 11:48:51, AnilKumar, Chimata wrote:
> This patch series add AM33XX regulators (tps65910/tps65217) device
> tree data to am335x-evm and am335x-bone dts files. These patches
> are based on Tony L "devel-dt" tree and tested on AM335x EVM and
> Bone devices.
> 
> Changes from v1:
> 	- Incorporated all Mark Brown's review comments on v1 by
> 	  * moving all the regulator constraints to corresponding
> 	    DTS file
> 	  * Regulator constraints are added according to board.
> 	- regulator name is added.
> 
> AnilKumar Ch (4):
>   ARM: OMAP2+: AM33XX: Add tps65910 device tree data
>   ARM: OMAP2+: AM33XX: Add tps65217 device tree data
>   arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
>   arm/dts: Add tps65217 regulator DT data to am335x-bone.dts
> 
>  arch/arm/boot/dts/am335x-bone.dts |   28 ++++++++++++
>  arch/arm/boot/dts/am335x-evm.dts  |   28 ++++++++++++
>  arch/arm/boot/dts/tps65217.dtsi   |   56 ++++++++++++++++++++++++
>  arch/arm/boot/dts/tps65910.dtsi   |   86 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tps65217.dtsi
>  create mode 100644 arch/arm/boot/dts/tps65910.dtsi
> 
> -- 
> 1.7.9.5

With the recent changes in the regulator core driver which disables all
the regulators if always-on flag is not present. So I have to update
these patch to add all the regulator nodes with always-on flag.

I will submit the updated version of patch series.

Regards
AnilKumar
