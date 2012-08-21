From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
Date: Tue, 21 Aug 2012 09:48:21 -0600
Message-ID: <5033ADC5.4030002@wwwdotorg.org>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com> <1345547850-29761-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51935 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab2HUPs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 11:48:26 -0400
In-Reply-To: <1345547850-29761-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com

On 08/21/2012 05:17 AM, AnilKumar Ch wrote:
> Add device tree data for tps65910 regulator by adding all tps65910
> regulator nodes. Regulator is initialized based on compatiable
> name provided in tps65910 DT file.
> 
> All tps65910 PMIC regulator device tree nodes are placed in a
> seperate device tree include file (tps65910.dtsi). This patch
> was tested on AM335x-EVM.

This .dtsi file adds a node for every single regulator within the
TPS65910, which in turn means that of_regulator_match() will find a node
for every regulator, and in turn every regulator will be registered. On
some boards, not all of those regulators will be used, and hence we
don't want all of them to be registered.

If we backport the /delete-node/ feature I implemented, perhaps we could
solve that; see:

http://comments.gmane.org/gmane.linux.drivers.devicetree/19170

> diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi

I wonder if there shouldn't be some better common location for .dtsi
files that are ancilliary chips, rather than ARM-specific?

> +&tps {
> +	compatible = "ti,tps65910";

Perhaps this file should expect some more unique label than just "tps".
Many boards have many power-related chips, all with model names that
start with "tps"; I foresee conflict here.

If dtc allowed /include/ inside a node rather than just at the
top-level, that might solve this. Or, #defines to the board .dts could
define the label name, and the .dtsi reference that label name.
