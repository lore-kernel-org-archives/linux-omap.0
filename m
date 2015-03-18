From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie
 phy
Date: Wed, 18 Mar 2015 21:36:29 +0200
Message-ID: <5509D3BD.6030004@linaro.org>
References: <1424422274-27946-1-git-send-email-kishon@ti.com> <1424422274-27946-2-git-send-email-kishon@ti.com> <5509A998.2080509@ti.com> <20150318165706.GQ31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:32941 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbbCRTgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 15:36:35 -0400
Received: by ladw1 with SMTP id w1so44866522lad.0
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2015 12:36:34 -0700 (PDT)
In-Reply-To: <20150318165706.GQ31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, paul@pwsan.com, nsekhar@ti.com, linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, t-kristo@ti.com

On 03/18/2015 06:57 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [150318 09:37]:
>> As I can see Patch 1 from this series was merged in 4.0-rc4,
>> but this patch wasn't. As result, I can see below warning all the time during boot now:
>>
>> [    0.594591] platform 4a094000.pciephy: Cannot lookup hwmod 'pcie1-phy'
>   
> OK. Is this needed as a fix for the v4.0-rc series, or can this wait
> for v4.1?

I think, Yes. These two patches should go all together, because they are
interrelated.

>> On 02/20/2015 10:51 AM, Kishon Vijay Abraham I wrote:
>>> Now that we don't have hwmod entry for pcie PHY remove the
>>> ti,hwmod property from PCIE PHY's
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>    arch/arm/boot/dts/dra7.dtsi |    2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index 5827fed..18a904d 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -1111,7 +1111,6 @@
>>>    					      "wkupclk", "refclk",
>>>    					      "div-clk", "phy-div";
>>>    				#phy-cells = <0>;
>>> -				ti,hwmods = "pcie1-phy";
>>>    			};
>>>    
>>>    			pcie2_phy: pciephy@4a095000 {
>>> @@ -1130,7 +1129,6 @@
>>>    					      "wkupclk", "refclk",
>>>    					      "div-clk", "phy-div";
>>>    				#phy-cells = <0>;
>>> -				ti,hwmods = "pcie2-phy";
>>>    				status = "disabled";
>>>    			};
>>>    		};
>>>
>>


-- 
regards,
-grygorii
