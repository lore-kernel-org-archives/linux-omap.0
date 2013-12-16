From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 22/41] ARM: dts: omap5 clock data
Date: Mon, 16 Dec 2013 12:57:42 +0200
Message-ID: <52AEDCA6.2010706@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-23-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312161046530.31680@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab3LPK6L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 05:58:11 -0500
In-Reply-To: <alpine.DEB.2.02.1312161046530.31680@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 12/16/2013 12:51 PM, Paul Walmsley wrote:
> On Tue, 26 Nov 2013, Tero Kristo wrote:
>
>> This patch creates a unique node for each clock in the OMAP5 power,
>> reset and clock manager (PRCM).
>
> ...
>
>> +&cm_core_aon {
>> +	pad_clks_src_ck: pad_clks_src_ck {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <12000000>;
>> +	};
>> +
>> +	pad_clks_ck: pad_clks_ck {
>> +		#clock-cells = <0>;
>> +		compatible = "ti,gate-clock";
>> +		clocks = <&pad_clks_src_ck>;
>> +		ti,bit-shift = <8>;
>> +		reg = <0x0108>;
>> +	};
>
> All of the clock data should be underneath a "clocks {" node, for all of
> the chips.  Please see the Calxeda ECX clocks DT data as an example of how
> this should look:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ecx-common.dtsi#n141

Any reason why?

Should be relatively trivial to change though, however I am not too sure 
if this works:

&core_core_aon {
   &clocks {
     pad_clks_src_ck: ...
   };
};

... as I want to modify nodes under the structure. Does it?

-Tero

