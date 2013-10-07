From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap3-igep0020: Add USB OTG support
Date: Mon, 07 Oct 2013 14:09:12 +0200
Message-ID: <5252A468.5070801@baylibre.com>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk> <1380931479-16142-2-git-send-email-javier.martinez@collabora.co.uk> <52529048.1040606@ti.com> <5252A0FE.5070809@collabora.co.uk> <5252A1EA.9020909@baylibre.com> <5252A2ED.2070600@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:34197 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab3JGMJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 08:09:16 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so3235007eek.27
        for <linux-omap@vger.kernel.org>; Mon, 07 Oct 2013 05:09:15 -0700 (PDT)
In-Reply-To: <5252A2ED.2070600@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On 07/10/2013 14:02, Javier Martinez Canillas wrote:
> On 10/07/2013 01:58 PM, Benoit Cousson wrote:
>> Hi Javier,
>>
>> On 07/10/2013 13:54, Javier Martinez Canillas wrote:
>>> On 10/07/2013 12:43 PM, Roger Quadros wrote:
>>>> Javier,
>>>>
>>>> On 10/05/2013 03:04 AM, Javier Martinez Canillas wrote:
>>>>> Commit ad871c10b ("ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards")
>>>>> added USB OTG support for most OMAP boards but some OMAP3 boards
>>>>> such as the IGEPv2 were not updated. This patch adds an USB OTG
>>>>> device node to this board.
>>>>>
>>>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>>> ---
>>>>>    arch/arm/boot/dts/omap3-igep0020.dts | 7 +++++++
>>>>>    1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
>>>>> index eedf0d8..903e944 100644
>>>>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>>>>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>>>>> @@ -166,3 +166,10 @@
>>>>>    		smsc,save-mac-address;
>>>>>    	};
>>>>>    };
>>>>> +
>>>>> +&usb_otg_hs {
>>>>> +	interface-type = <0>;
>>>>> +	usb-phy = <&usb2_phy>;
>>>>
>>>> With the PHY generic framework in Greg's usb-next branch [1], you will also need to add
>>>>
>>>> +       phys = <&usb2_phy>;
>>>> +       phy-names = "usb2-phy";
>>>>
>>>>> +	mode = <3>;
>>>>> +	power = <50>;
>>>>> +};
>>>>>
>>>>
>>>> So it would be good to test with the usb-next branch.
>>>>
>>>> cheers,
>>>> -roger
>>>>
>>>> [1] - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
>>>>
>>>
>>> Hi Roger,
>>>
>>> Thanks for the pointer, I'll add those properties and test using the PHY generic
>>> framework.
>>
>> Should I expect a v3 then?
>>
>
> Hi Benoit,
>
> Yes, I'll test it and send a v3 in the next few hours, sorry for not being clear
> about that.


That's OK, I was applying your series when I saw your email ;-)

I'm waiting for the next one.

Thanks,
Benoit

