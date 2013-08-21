From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP4: dts: Add main and optional clock data
 into DT
Date: Wed, 21 Aug 2013 13:58:26 +0530
Message-ID: <52147A2A.60105@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com> <1374560679-14666-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.02.1308202352330.6426@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab3HUI3M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 04:29:12 -0400
In-Reply-To: <alpine.DEB.2.02.1308202352330.6426@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, t-kristo@ti.com, benoit.cousson@gmail.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, mark.rutland@arm.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tomasz.figa@gmail.com, rob.herring@calxeda.com, ian.campbell@citrix.com, galak@codeaurora.org, mturquette@linaro.org

On Wednesday 21 August 2013 05:27 AM, Paul Walmsley wrote:
> Hi
> 
> On Tue, 23 Jul 2013, Rajendra Nayak wrote:
> 
>> With support to parse clock data from DT, move all main and optional
>> clock information from hwmod to DT.
>>
>> We still retain clocks in hwmod for devices which do not have a DT node.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  112 ----------------------------
>>  2 files changed, 100 insertions(+), 112 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 8e142f9..4dddf64 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -106,6 +106,8 @@
>>  			compatible = "ti,omap-counter32k";
>>  			reg = <0x4a304000 0x20>;
>>  			ti,hwmods = "counter_32k";
>> +			clocks = <&sys_32k_ck>;
>> +			clock-names = "fck";
> 
> Shouldn't these patches be using the official DT clock binding format?

They are, already.
 
> Either the 'clocks' property should be something like:
> 
>     clocks = <&prm 10>;

That depends on the #clock-cells for the clock provider node. These patches
are based on Teros series to move all OMAP clocks to DT [1], and the clock providers
in his series have the #clock-cells set to 0.

So the clock bindings do not mandate
	clocks = <&clk-provider index>
or
	clocks = <&clk-provider>

It just depends on how the clk-provider node is defined.

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/100117

> 
> or a change to the bindings needs to be discussed and implemented.
> 
> 
> - Paul
> 

