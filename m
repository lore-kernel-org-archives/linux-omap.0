From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
Date: Thu, 26 Jul 2012 11:35:41 +0200
Message-ID: <998296CC-2CC5-4EE1-AAFF-D5E6975C5E63@dominion.thruhere.net>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com> <1343219012-19472-2-git-send-email-anilkumar@ti.com> <9D2B44C8-820E-4E96-A480-7A650583BC92@dominion.thruhere.net> <331ABD5ECB02734CA317220B2BBEABC13EA04433@DBDE01.ent.ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38815 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab2GZJfu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 05:35:50 -0400
Received: by wibhr14 with SMTP id hr14so1708921wib.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 02:35:49 -0700 (PDT)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA04433@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>


Op 26 jul. 2012, om 11:03 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:

> On Thu, Jul 26, 2012 at 14:16:33, Koen Kooi wrote:
>> 
>> Op 25 jul. 2012, om 14:23 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:
>> 
>>> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
>>> by adding d_can device node with all the necessary parameters.
>>> 
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>> arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>>> 1 file changed, 5 insertions(+)
>>> 
>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>> index 9b974dc..2db2ffb 100644
>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>> @@ -163,5 +163,10 @@
>>> 			#size-cells = <0>;
>>> 			ti,hwmods = "i2c3";
>>> 		};
>>> +
>>> +		dcan1: d_can@481D0000 {
>>> +			compatible = "bosch,d_can";
>>> +			ti,hwmods = "d_can1";
>>> +		};
>>> 	};
>> 
>> I scanned the linux-networking mailinglist and l-o-ml, but I can't find the patchset that actually adds the d_can drivers, could you provide a link to that? I have 2 different CAN capes I'd like to test on beaglebone.
>> 
> 
> You can find it from linux-next or net-next trees, D_CAN support is added
> to C_CAN driver.
> 
> http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git;
> a=commitdiff;h=69927fccd96b15bd228bb82d356a7a2a0cfaeefb

Thanks! I'll try merging net-next into l-o master and see if I can get the CAN boards to work.

regards,

Koen