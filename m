From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing
 pen-down GPIO
Date: Fri, 27 Jul 2012 13:02:34 +0800
Message-ID: <501220EA.3020009@windriver.com>
References: <1342048700-15040-1-git-send-email-khilman@ti.com> <500D494D.8020606@compulab.co.il> <500D4F2A.9090706@compulab.co.il> <87zk6mpbfa.fsf@ti.com> <5011B465.70605@windriver.com> <87ipdambgg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:47249 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab2G0FDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 01:03:34 -0400
In-Reply-To: <87ipdambgg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "zumeng.chen" <zchen@windriver.com>, Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

=E4=BA=8E 2012=E5=B9=B407=E6=9C=8827=E6=97=A5 05:58, Kevin Hilman =E5=86=
=99=E9=81=93:
> "zumeng.chen"<zchen@windriver.com>  writes:
>
>> On 2012=E5=B9=B407=E6=9C=8827=E6=97=A5 03:30, Kevin Hilman wrote:
>>> + Zumeng Chen
>>>
>>> Igor Grinberg<grinberg@compulab.co.il>   writes:
>>>
>>>> Hi Kevin,
>>>>
>>>> I've just noticed that the patch has been modified by Arnd in a wa=
y
>>>> that of course will trigger GPIO use without being requested.
>>>> I'm sorry, I was not available by that time Arnd changed the patch=
=2E
>>> Your right, your original patch isn't the problem.  I found the roo=
t
>>> cause.
>>>
>>> The real problem is actually introduced by the merge of your patch =
from
>>> the arm-soc/cleanup branch, and this one from Zumeng Chen: commit
>>> 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce time f=
or
>>> ads7846) from the arm-soc/boards branch.
>>>
>>> However, looking closer at the one from Zumeng, that one is clearly=
 not
>>> right.  It unconditionally adds a *board-specific* ->get_pendown_st=
ate
>>> function to the pdata that is common to *all* boards.  That's just =
wrong
>>> and has the side-effect of making ->get_pendown_state() wrong on ev=
ery
>>> board except the OMAP3EVM.  Oops.
>>>
>>> So, IMO, in addition to $SUBJECT patch, in order to get the touchsc=
reen
>>> GPIO working on non OMAP3EVM boards, we also need something like th=
is as
>>> well.
>> Definitely, thanks Kevin.
>>> Igor, Zumeng, could you try this out on your boards anc confirm if =
it's
>>> working?  I currently don't have a board setup with a touchscreen i=
n my
>>> board farm.
>> Acked
> Did you test this on your board?  If so, could you respond with a
> Tested-by tag?  Thanks.
Hi Kevin,

Your patch self has no problem, feel free to add
"Tested-by: Zumeng Chen <zumeng.chen@windriver.com>


But obviously, the current ads7846 doesn't work, I have found
one reason, another reason is about spi-dma update, I'm trying
to fix it.

Regards,
Zumeng
>
> Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
