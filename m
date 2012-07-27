From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing
 pen-down GPIO
Date: Fri, 27 Jul 2012 22:04:52 +0300
Message-ID: <5012E654.4040907@compulab.co.il>
References: <1342048700-15040-1-git-send-email-khilman@ti.com> <500D494D.8020606@compulab.co.il> <500D4F2A.9090706@compulab.co.il> <87zk6mpbfa.fsf@ti.com> <5012B42F.9040309@compulab.co.il> <87sjcdksgm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52765 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab2G0TFC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 15:05:02 -0400
In-Reply-To: <87sjcdksgm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Zumeng Chen <zumeng.chen@windriver.com>

On 07/27/12 20:46, Kevin Hilman wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
> 
>> On 07/26/12 22:30, Kevin Hilman wrote:
>>> + Zumeng Chen
>>>
>>> Igor Grinberg <grinberg@compulab.co.il> writes:
>>>
>>>> Hi Kevin,
>>>>
>>>> I've just noticed that the patch has been modified by Arnd in a way
>>>> that of course will trigger GPIO use without being requested.
>>>> I'm sorry, I was not available by that time Arnd changed the patch.
>>>
>>> Your right, your original patch isn't the problem.  I found the root
>>> cause.
>>>
>>> The real problem is actually introduced by the merge of your patch from
>>> the arm-soc/cleanup branch, and this one from Zumeng Chen: commit
>>> 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce time for
>>> ads7846) from the arm-soc/boards branch.
>>>
>>> However, looking closer at the one from Zumeng, that one is clearly not
>>> right.  It unconditionally adds a *board-specific* ->get_pendown_state
>>> function to the pdata that is common to *all* boards.  That's just wrong
>>> and has the side-effect of making ->get_pendown_state() wrong on every
>>> board except the OMAP3EVM.  Oops.
>>
>> Argh... that should not be applied in first place...
> 
> Agreed, but it's already in mainline.
> 
>> I double sorry, I was not available when that conflict was resolved...
>> The right resolution would be just to revert the 16aced80f6
>> (ARM: OMAP3530evm: set pendown_state and debounce time for ads7846),
>> but who cares now...
> 
> 
>>
>>>
>>> So, IMO, in addition to $SUBJECT patch, in order to get the touchscreen
>>> GPIO working on non OMAP3EVM boards, we also need something like this as
>>> well.
>>>
>>> Igor, Zumeng, could you try this out on your boards anc confirm if it's
>>> working?  I currently don't have a board setup with a touchscreen in my
>>> board farm.
>>
>> Since you have already dig into this, which branch would be good for testing?
> 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/fixes/ads7846
> 
> I just pushed this out, so it might take a bit to propagate to all the
> mirrors.

Thanks, Kevin, I've just sent the tested-by.
I would also like to see only one patch instead of current two patches,
can you please, amend them into one, write a correct message and resend?



-- 
Regards,
Igor.
