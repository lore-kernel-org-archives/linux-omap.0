From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 4/4] ARM: dts: am33xx: adopt to cpsw-phy-sel driver
 to configure phy mode
Date: Tue, 10 Sep 2013 16:55:32 +0400
Message-ID: <522F16C4.5030600@cogentembedded.com>
References: <1378639438-27686-1-git-send-email-mugunthanvnm@ti.com> <1378639438-27686-5-git-send-email-mugunthanvnm@ti.com> <522CBC15.5060008@cogentembedded.com> <522D6DE7.5080305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:58006 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab3IJMzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 08:55:33 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so6047631lbh.7
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 05:55:32 -0700 (PDT)
In-Reply-To: <522D6DE7.5080305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, zonque@gmail.com, davem@davemloft.net, bcousson@baylibre.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

On 09-09-2013 10:42, Mugunthan V N wrote:

>>> Add DT entries for the phy mode selection in AM33xx SoC using
>>> cpsw-phy-sel
>>> driver.

>>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>>> ---
>>>    arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
>>>    1 file changed, 6 insertions(+)

>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi
>>> b/arch/arm/boot/dts/am33xx.dtsi
>>> index f9c5da9..4359672 100644
>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>> @@ -594,6 +594,12 @@
>>>                    /* Filled in by U-Boot */
>>>                    mac-address = [ 00 00 00 00 00 00 ];
>>>                };
>>> +
>>> +            phy_sel: cpsw_phy_sel@44e10650 {

>>     Dashes are preferred to uderscores in the device tree names.

> I tried with dashes but i get the below error.

> $ make CROSS_COMPILE=arm-linux-gnueabihf- ARCH=arm dtbs
>    DTC     arch/arm/boot/dts/am335x-evm.dtb
> Error: arch/arm/boot/dts/am33xx.dtsi:598.11-12 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-evm.dtb] Error 1
> make: *** [dtbs] Error 2

    Hm, perhaps the dashes can't be used in the labels but I was talking of 
the names. Dashes in the node names should be definitely valid.

> Regards
> Mugunthan V N

WBR, Sergei


