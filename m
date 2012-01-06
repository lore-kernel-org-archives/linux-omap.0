From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 1/5] arm/dts: OMAP4: Update DTS file with new GIC bindings
Date: Fri, 06 Jan 2012 15:30:54 -0600
Message-ID: <4F07680E.8000404@gmail.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com> <1324388398-2683-2-git-send-email-b-cousson@ti.com> <20120106211558.GA7457@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44124 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab2AFVa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 16:30:57 -0500
Received: by ghbg21 with SMTP id g21so904117ghb.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 13:30:56 -0800 (PST)
In-Reply-To: <20120106211558.GA7457@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Benoit Cousson <b-cousson@ti.com>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/06/2012 03:15 PM, Grant Likely wrote:
> On Tue, Dec 20, 2011 at 02:39:54PM +0100, Benoit Cousson wrote:
>> The GIC binding was updated in 3.2 and expect 3 interrupt-cells.
>> - Update the #interrupt-cells
>> - interrupt-parent seems to be needed as well for the top level GIC
> 
> Hmmm... it shouldn't be.  If it is then it is a bug.
> 

I think this is an old comment which I fixed in 3.2, so interrupt-parent
can be removed.

Rob

> g.
> 
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  arch/arm/boot/dts/omap4.dtsi |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 4c61c82..bede009 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -95,7 +95,8 @@
>>  		gic: interrupt-controller@48241000 {
>>  			compatible = "arm,cortex-a9-gic";
>>  			interrupt-controller;
>> -			#interrupt-cells = <1>;
>> +			interrupt-parent;
>> +			#interrupt-cells = <3>;
>>  			reg = <0x48241000 0x1000>,
>>  			      <0x48240100 0x0100>;
>>  		};
>> -- 
>> 1.7.0.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
