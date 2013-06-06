From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: omap5-uevm: Add USB Host support
Date: Thu, 6 Jun 2013 23:21:17 +0530
Message-ID: <51B0CC15.6010809@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com> <1370414770-1485-3-git-send-email-r.sricharan@ti.com> <20130605135739.GA11193@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39837 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543Ab3FFRvs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jun 2013 13:51:48 -0400
In-Reply-To: <20130605135739.GA11193@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Roger Quadros <rogerq@ti.com>

Hi,
On Wednesday 05 June 2013 07:27 PM, Nishanth Menon wrote:
> On 12:16-20130605, Sricharan R wrote:
>> From: Roger Quadros <rogerq@ti.com>
> [...]
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index 843a001..cf862df 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> <snip>
>> +	/* hsusb2_phy is clocked by FREF_CLK1 i.e. auxclk1 */
>> +	clock_alias {
>> +		clock-name = "auxclk1_ck";
>> +		clock-alias = "main_clk";
> is'nt this better to use with clock node?
Roger was suggesting to remove this for now. Posted
V2 following that.
Are you suggesting to go with your clock-binding patch ?

Regards,
 Sricharan
