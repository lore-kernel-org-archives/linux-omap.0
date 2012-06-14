From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 12:57:08 +0800
Message-ID: <4FD96F24.3080304@windriver.com>
References: <zumeng.chen@gmail.com> <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com> <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com> <20120612064757.GE12766@atomide.com> <CA+Y31wdGaMDrT6ySE1y2Z5sw5ah8fE7im_=BvH=s+U+P619O=g@mail.gmail.com> <20120613125543.GU12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33090 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab2FNE6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 00:58:07 -0400
In-Reply-To: <20120613125543.GU12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Zumeng Chen <zumeng.chen@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8813=E6=97=A5 20:55, Tony Lindgren =E5=86=
=99=E9=81=93:
> * Zumeng Chen<zumeng.chen@gmail.com>  [120612 09:41]:
>> 2012/6/12 Tony Lindgren<tony@atomide.com>
>>
>>> * Zumeng Chen<zumeng.chen@gmail.com>  [120611 07:05]:
>>>> If we don't set proper debouce time for ads7846, then there are
>>>> flooded interrupt counters of ads7846 responding to one time
>>>> touch on screen, so the driver couldn't work well.
>>>>
>>>> And since most OMAP3 series boards pass NULL pointer of board_pdat=
a
>>>> to omap_ads7846_init, so it's more proper to set it in driver leve=
l
>>>> after having gpio_request done.
>>>>
>>>> This patch has been validated on 3530evm.
>>>>
>>>> Signed-off-by: Zumeng Chen<zumeng.chen@gmail.com>
>>>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>>>> Signed-off-by: Tony Lindgren<tony@atomide.com>
>>> Please remove my Signed-off-by, where does that come from?
>>>
>> HI Tony,
>>
>> This comes from git://arago-project.org/git/projects/linux-omap3.git
>> The commit ID is 53c5ec31, we set gpio_debounce in arch/board
>> level.
> Weird, I have no recollection of doing anything with that file..
> Just remove my Signed-off-by please.
NP, Tony, done, sorry for inconvenience.

Regards,
Zumeng
> Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
