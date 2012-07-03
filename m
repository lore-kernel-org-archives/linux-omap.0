From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] gpio/omap: fix invalid context restore of gpio bank-0
Date: Mon, 2 Jul 2012 19:20:48 -0500
Message-ID: <4FF23AE0.7050509@ti.com>
References: <1340990551-19426-1-git-send-email-jon-hunter@ti.com> <87mx3i595b.fsf@ti.com> <4FF1E7DE.10409@ti.com> <20120703093404.2a9b5aba@notabene.brown> <87txxp4skw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37810 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab2GCAV3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 20:21:29 -0400
In-Reply-To: <87txxp4skw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: NeilBrown <neilb@suse.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Franky Lin <frankyl@broadcom.com>


On 07/02/2012 07:05 PM, Kevin Hilman wrote:
> NeilBrown <neilb@suse.de> writes:
> 
>> On Mon, 2 Jul 2012 13:26:38 -0500 Jon Hunter <jon-hunter@ti.com> wrote:
>>
>>>
>>> On 07/02/2012 01:07 PM, Kevin Hilman wrote:
>>>> + Neil Brown
>>>>
>>>> Hi Jon,
>>>>
>>>> Jon Hunter <jon-hunter@ti.com> writes:
>>>>
>>>>> Currently the gpio _runtime_resume/suspend functions are calling the
>>>>> get_context_loss_count() platform function if the function is populated for
>>>>> a gpio bank. This function is used to determine if the gpio bank logic state
>>>>> needs to be restored due to a power transition. This function will be populated
>>>>> for all banks, but it should only be called for banks that have the
>>>>> "loses_context" variable set. It is pointless to call this if loses_context is
>>>>> false as we know the context will never be lost and will not need restoring.
>>>>>
>>>>> For all OMAP2+ devices gpio bank-0 is in an always-on power domain and so will
>>>>> never lose context. We found that the get_context_loss_count() was being called
>>>>> for bank-0 during the probe and returning 1 instead of 0 indicating that the
>>>>> context had been lost. This was causing the context restore function to be
>>>>> called at probe time for this bank and because the context had never been saved,
>>>>> was restoring an invalid state. This ultimately resulted in a crash [1].
>>>>>
>>>>> There are multiple bugs here that need to be addressed ...
>>>>>
>>>>> 1. Why the always-on power domain returns a context loss count of 1? This needs
>>>>>    to be fixed in the power domain code. However, the gpio driver should not
>>>>>    assume the loss count is 0 to begin with.
>>>>> 2. The omap gpio driver should never be calling get_context_loss_count for a
>>>>>    gpio bank in a always-on domain. This is pointless and adds unneccessary
>>>>>    overhead.
>>>>> 3. The OMAP gpio driver assumes that the initial power domain context loss count
>>>>>    will be 0 at the time the gpio driver is probed. However, it could be
>>>>>    possible that this is not the case and an invalid context restore could be
>>>>>    performed during the probe. To avoid this otherwise only populated the
>>>>
>>>> The 'To avoid this...' sentence here doesn't read well.  Looks like you
>>>> need to:
>>>>
>>>> s/otherwise//
>>>
>>> Yes, I meant to have dropped "otherwise" here. Thanks!
>>>
>>>> s/populated/populate/
>>>
>>> Yes that too! I must have re-worded and screwed it up royally :-(
>>>
>>>> ?
>>>>
>>>>>    get_context_loss_count() function pointer after the initial call to
>>>>>    pm_runtime_get() has occurred. This will ensure that the first
>>>>>    pm_runtime_put() initialised the loss count correctly.
>>>>>
>>>>> This patch addresses issues 2 and 3 above.
>>>>> [1] http://marc.info/?l=linux-omap&m=134065775323775&w=2
>>>>>
>>>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>>>> Cc: Linus Walleij <linus.walleij@stericsson.com>
>>>>> Cc: Kevin Hilman <khilman@ti.com>
>>>>> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>>>> Cc: Franky Lin <frankyl@broadcom.com>
>>>>>
>>>>> Reported-by: Franky Lin <frankyl@broadcom.com>
>>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>>
>>>> Thanks for digging inot this bug Jon.  The same bug was brought up by
>>>> Neil Brown (Cc'd) in a different thread.
>>>>
>>>> Neil, it looks to me that this fix will address the problems you were
>>>> seeing as well.  Care to test, and respond with your ack/tested-by if it
>>>> works for you?  Thanks.
>>>
>>> Neil let me know your thoughts and if you are ok, I can clean-up the
>>> changelog and re-send.
>>
>> Yes, works for me and looks sensible.
>>
>>  Tested-by: NeilBrown <neilb@suse.de>
>>
> 
> Great!  Thanks for testing.
> 
> Jon, please make the minor changelog edits, collect the reviewed-by and
> tested-by tags and repost.  I'll then queue this up for Grant.

Ok, will do that tomorrow.

> Based on your earlier comments, this only affects v3.5, so no
> need to push it into stable, correct?

As far as I can tell. However, not sure if any of the other fixes should
be back ported.

Cheers
Jon
