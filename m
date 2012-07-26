From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing pen-down GPIO
Date: Thu, 26 Jul 2012 14:58:23 -0700
Message-ID: <87ipdambgg.fsf@ti.com>
References: <1342048700-15040-1-git-send-email-khilman@ti.com>
	<500D494D.8020606@compulab.co.il> <500D4F2A.9090706@compulab.co.il>
	<87zk6mpbfa.fsf@ti.com> <5011B465.70605@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41196 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752662Ab2GZV62 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 17:58:28 -0400
Received: by pbbro2 with SMTP id ro2so4831313pbb.27
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 14:58:22 -0700 (PDT)
In-Reply-To: <5011B465.70605@windriver.com> (zumeng chen's message of "Fri, 27
	Jul 2012 05:19:33 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "zumeng.chen" <zchen@windriver.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Zumeng Chen <zumeng.chen@windriver.com>

"zumeng.chen" <zchen@windriver.com> writes:

> On 2012=E5=B9=B407=E6=9C=8827=E6=97=A5 03:30, Kevin Hilman wrote:
>> + Zumeng Chen
>>
>> Igor Grinberg<grinberg@compulab.co.il>  writes:
>>
>>> Hi Kevin,
>>>
>>> I've just noticed that the patch has been modified by Arnd in a way
>>> that of course will trigger GPIO use without being requested.
>>> I'm sorry, I was not available by that time Arnd changed the patch.
>> Your right, your original patch isn't the problem.  I found the root
>> cause.
>>
>> The real problem is actually introduced by the merge of your patch f=
rom
>> the arm-soc/cleanup branch, and this one from Zumeng Chen: commit
>> 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce time fo=
r
>> ads7846) from the arm-soc/boards branch.
>>
>> However, looking closer at the one from Zumeng, that one is clearly =
not
>> right.  It unconditionally adds a *board-specific* ->get_pendown_sta=
te
>> function to the pdata that is common to *all* boards.  That's just w=
rong
>> and has the side-effect of making ->get_pendown_state() wrong on eve=
ry
>> board except the OMAP3EVM.  Oops.
>>
>> So, IMO, in addition to $SUBJECT patch, in order to get the touchscr=
een
>> GPIO working on non OMAP3EVM boards, we also need something like thi=
s as
>> well.
> Definitely, thanks Kevin.
>> Igor, Zumeng, could you try this out on your boards anc confirm if i=
t's
>> working?  I currently don't have a board setup with a touchscreen in=
 my
>> board farm.
> Acked

Did you test this on your board?  If so, could you respond with a
Tested-by tag?  Thanks.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
