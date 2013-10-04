From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCHv3 0/2] ARM: dts: Add initial support for IGEP AQUILA
Date: Sat, 5 Oct 2013 00:13:11 +0200
Message-ID: <CAFqH_53O9=kLZxZ=M7GuUWPTULUGjz6-8KPJwXM0kqjMjeCypA@mail.gmail.com>
References: <1378824949-18792-1-git-send-email-eballetbo@gmail.com>
	<CAAwP0s2NOswrZPdeM7GG2J3e+2JeQSKUpX3cki+CbF9G4KyTpA@mail.gmail.com>
	<20131003181758.GS8949@atomide.com>
	<524EB77F.90205@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37546 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab3JDWNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Oct 2013 18:13:13 -0400
Received: by mail-wi0-f176.google.com with SMTP id cb5so2346261wib.9
        for <linux-omap@vger.kernel.org>; Fri, 04 Oct 2013 15:13:11 -0700 (PDT)
In-Reply-To: <524EB77F.90205@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Benoit,

2013/10/4 Benoit Cousson <bcousson@baylibre.com>:
> Hi Enric,
>
>
> On 03/10/2013 20:17, Tony Lindgren wrote:
>>
>> * Javier Martinez Canillas <martinez.javier@gmail.com> [130925 06:18]:
>>>
>>> On Tue, Sep 10, 2013 at 4:55 PM, Enric Balletbo i Serra
>>> <eballetbo@gmail.com> wrote:
>>>>
>>>> From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>>>>
>>>> Hi all,
>>>>
>>>> These two patches introduces initial support for the IGEP AM335x-based
>>>> platforms. The first patch add support for IGEP COM AQUILA products, and
>>>> the
>>>> second patch add support for the development board.
>>>>
>>>> These patches apply on top of bcousson/for_3.12/dts repository.
>>>>
>>>> Changes since v2:
>>>>    * Make it compatible with "isee,am335x-base0033",
>>>> "isee,am335x-igep0033",
>>>>      "ti,am33xx" since these boards are manufactured by ISEE not TI.
>>>> (Javier)
>>>> Changes since v1:
>>>>    * Use &node to reference the nodes already defined in dtsi files.
>>>> (Javier)
>>>>
>>>> Best regards,
>>>>
>>>> Enric Balletbo i Serra (2):
>>>>    ARM: dts: AM33XX: Add support for IGEP COM AQUILA
>>>>    ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.
>>>>
>>>>   arch/arm/boot/dts/Makefile             |   1 +
>>>>   arch/arm/boot/dts/am335x-base0033.dts  |  16 ++
>>>>   arch/arm/boot/dts/am335x-igep0033.dtsi | 265
>>>> +++++++++++++++++++++++++++++++++
>>>>   3 files changed, 282 insertions(+)
>>>>   create mode 100644 arch/arm/boot/dts/am335x-base0033.dts
>>>>   create mode 100644 arch/arm/boot/dts/am335x-igep0033.dtsi
>>>>
>>>> --
>>>> 1.8.1.2
>>>>
>>>
>>> Hi Benoit and Tony,
>>>
>>> Any comments on this series? I had already reviewed previous versions
>>> of the DT and it looks good to me now.
>>>
>>> It would be great if this can make it for 3.13.
>>
>>
>> Looks good to me, I would assume Benoit will be looking at this
>> shortly.
>
>
> I did :-)
>
> It looks good to me too, I've just fixed a conflict with my current branch
> in the Makefile and fix a typo in the header:
>
> +++ b/arch/arm/boot/dts/am335x-base0033.dts
> @@ -0,0 +1,16 @@
> +/*
> + * am335x-base0033.dtsi - Device Tree file for IGEP AQUILA EXPANSION
>
> Should be am335x-base0033.dts. I fixed it for you. Please check if the fix
> is ok in the branch.
>

Checked.

> Pushed on my for_3.13/dts branch.
>
> Thanks,
> Benoit
>

Thanks,
   Enric
