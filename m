From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
Date: Thu, 26 Jul 2012 10:36:55 +0200
Message-ID: <501101A7.2030503@gmail.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com> <1343219012-19472-2-git-send-email-anilkumar@ti.com> <500FE9FC.7070303@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43696 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab2GZIhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 04:37:00 -0400
Received: by wgbdr13 with SMTP id dr13so1579228wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 01:36:58 -0700 (PDT)
In-Reply-To: <500FE9FC.7070303@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, wg@grandegger.com

On 25.07.2012 14:43, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-07-2012 16:23, AnilKumar Ch wrote:
> 
>> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
>> by adding d_can device node with all the necessary parameters.
> 
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>>   arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>>   1 file changed, 5 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 9b974dc..2db2ffb 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -163,5 +163,10 @@
>>   			#size-cells = <0>;
>>   			ti,hwmods = "i2c3";
>>   		};
>> +
>> +		dcan1: d_can@481D0000 {
> 
>     Address postfix in the node name and no "reg" property?

This still works due to the hwmod mappings OMAP relies on. I would still
put it there, so the switch to real DT definitions will be less painful.


Daniel

