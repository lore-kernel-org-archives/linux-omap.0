From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: patch "phy: Add a driver for dm816x USB PHY" added to linux-phy
 tree
Date: Fri, 10 Apr 2015 17:48:07 +0530
Message-ID: <5527BF7F.20108@ti.com>
References: <20150325233606.GA7549@a0393678ub> <CAALWOA9ZHM6S+7WUffu0LF=9=fEO+PxfERpu=D9JpAbKSo1yNA@mail.gmail.com> <20150326160416.GG31346@atomide.com> <551ACCFE.3070703@ti.com> <20150331165133.GR10805@atomide.com> <20150409182228.GS18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40489 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964AbbDJMSW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Apr 2015 08:18:22 -0400
In-Reply-To: <20150409182228.GS18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Felipe Balbi <balbi@ti.com>, Brian Hutchinson <b.hutchman@gmail.com>, Bin Liu <binmlist@gmail.com>, pebolle@tiscali.nl, rusty@rustcorp.com.au, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

On Thursday 09 April 2015 11:52 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150331 09:56]:
>> * Kishon Vijay Abraham I <kishon@ti.com> [150331 09:37]:
>>> Hi Tony,
>>>
>>> On Thursday 26 March 2015 09:34 PM, Tony Lindgren wrote:
>>>> * Matthijs van Duin <matthijsvanduin@gmail.com> [150326 00:02]:
>>>>> On 26 March 2015 at 00:36, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>> Let me know if you find any problems with this patch.
>>>>>
>>>>> I spotted a minor issue in drivers/phy/Kconfig:
>>>>>
>>>>>> +         Enable this for dm81xx USB to work.
>>>>>
>>>>> This should say dm816x instead.
>>>>
>>>> Yes that's correct, the phy on dm814x seems to be like on am335x,
>>>> not like on dm816x. Kishon, let me know if you prefer a follow-up
>>>> patch to fix this.
>>>
>>> No. I've fixed this in my tree
>>> https://git.kernel.org/cgit/linux/kernel/git/kishon/linux-phy.git/commit
>>> /?h=next&id=9fa9fd4ffc90582091b8c6219f2054265f71e4ef
>>
>> OK thanks!
>
> Kishon, looks like your next branch is not getting merged into
> Linux next for some reason?

Greg merged it just now. So you should start seeing tomorrow.

Cheers
Kishon
