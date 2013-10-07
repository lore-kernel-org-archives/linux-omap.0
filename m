From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/3] ARM: dts: omap3-igep0020: Add USB OTG support
Date: Mon, 07 Oct 2013 18:05:37 +0200
Message-ID: <5252DBD1.3030308@collabora.co.uk>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk> <1380931479-16142-2-git-send-email-javier.martinez@collabora.co.uk> <52529048.1040606@ti.com> <5252A0FE.5070809@collabora.co.uk> <5252A1EA.9020909@baylibre.com> <5252A2ED.2070600@collabora.co.uk> <5252A468.5070801@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40735 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab3JGQGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 12:06:18 -0400
In-Reply-To: <5252A468.5070801@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On Mon, Oct 7, 2013 at 2:09 PM, Benoit Cousson <bcousson@baylibre.com> wrote:
> On 07/10/2013 14:02, Javier Martinez Canillas wrote:
>>
>> On 10/07/2013 01:58 PM, Benoit Cousson wrote:
>>>
>>> Hi Javier,
>>>
>>> On 07/10/2013 13:54, Javier Martinez Canillas wrote:
>>>>
>>>> On 10/07/2013 12:43 PM, Roger Quadros wrote:
>>>>>
>>>>> Javier,
>>>>>
>>>>> On 10/05/2013 03:04 AM, Javier Martinez Canillas wrote:
>>>>>>
>>>>>> Commit ad871c10b ("ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+
>>>>>> boards")
>>>>>> added USB OTG support for most OMAP boards but some OMAP3 boards
>>>>>> such as the IGEPv2 were not updated. This patch adds an USB OTG
>>>>>> device node to this board.
>>>>>>
>>>>>> Signed-off-by: Javier Martinez Canillas
>>>>>> <javier.martinez@collabora.co.uk>
>>>>>> ---
>>>>>>    arch/arm/boot/dts/omap3-igep0020.dts | 7 +++++++
>>>>>>    1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
>>>>>> b/arch/arm/boot/dts/omap3-igep0020.dts
>>>>>> index eedf0d8..903e944 100644
>>>>>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>>>>>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>>>>>> @@ -166,3 +166,10 @@
>>>>>>                 smsc,save-mac-address;
>>>>>>         };
>>>>>>    };
>>>>>> +
>>>>>> +&usb_otg_hs {
>>>>>> +       interface-type = <0>;
>>>>>> +       usb-phy = <&usb2_phy>;
>>>>>
>>>>>
>>>>> With the PHY generic framework in Greg's usb-next branch [1], you will
>>>>> also need to add
>>>>>
>>>>> +       phys = <&usb2_phy>;
>>>>> +       phy-names = "usb2-phy";
>>>>>
>>>>>> +       mode = <3>;
>>>>>> +       power = <50>;
>>>>>> +};
>>>>>>
>>>>>
>>>>> So it would be good to test with the usb-next branch.
>>>>>
>>>>> cheers,
>>>>> -roger
>>>>>
>>>>> [1] - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
>>>>>
>>>>
>>>> Hi Roger,
>>>>
>>>> Thanks for the pointer, I'll add those properties and test using the PHY
>>>> generic
>>>> framework.
>>>
>>>
>>> Should I expect a v3 then?
>>>
>>
>> Hi Benoit,
>>
>> Yes, I'll test it and send a v3 in the next few hours, sorry for not being
>> clear
>> about that.
>
>
>
> That's OK, I was applying your series when I saw your email ;-)
>

Yes, fortunately Roger pointed out that OMAP otg device node required additional
properties to work with the new generic PHY framework that will land on v3.13.
Otherwise it would only work until Greg send his pull request to Linus :)

> I'm waiting for the next one.
>

Great, I had already sent the v3 [1] that has the necessary changes for the PHY
framework and tested it using usb-next

> Thanks,
> Benoit
>

Thanks a lot and best regards,
Javier

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg96583.html
