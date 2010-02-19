From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v4] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Fri, 19 Feb 2010 14:02:08 -0600
Message-ID: <4B7EEE40.3020003@ti.com>
References: <1265925284-7536-1-git-send-email-deepak.chitriki@ti.com> <1265926841.26484.0.camel@chotu.research.nokia.com> <7A436F7769CA33409C6B44B358BFFF0C0130998163@dlee02.ent.ti.com> <4B7D8659.5030609@ti.com> <7A436F7769CA33409C6B44B358BFFF0C0130EBC3B9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52482 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab0BSUCO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Feb 2010 15:02:14 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0130EBC3B9@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On 2/18/2010 2:36 PM, Menon, Nishanth wrote:
>
[...]
>>
>> Instead of pushing this patch I'll be reverting this one:
>>
>> http://marc.info/?l=linux-omap&m=125694410627720&w=2
>>
>> Explanation:
>>
>> After reviewing the scenario it seems that the patch "fixing a flood of
>> messages usecase" doesn't seem to be the proper way to fix it.
>>
>> If the dsp sends 10 messages in a shot for the same client and bridge
>> process them without interrupt, if the client is using
>> DSPManager_WaitForEvents, InputMsg function will notify of all of them
>> but "WaitForEvents" will only catch one notification, then client will
>> call GetMsg ioctl and pick one message from the queue leaving 9 of them
>> still there, whenever WaitForEvents is executed again there won't be a
>> Notification if the dsp stopped sending messages to the same queue, so
>> those 9 messages never will be retrieved because WaitForEvents will
>> timeout.
>>
>> The fix was only to re-notify the client that a message was still
>> available in its queue and that it needs to pick it up, all of this
>> during GetMsg, however this seems to be triggering a kernel warning
>> because of nested spinlocks called for separate objects.
>>
>> The reason to avoid pushing this patch is that it is leaving a part of
>> the code introduced by the "flooding" fix.
>>
>> Please let me know if anyone has comments.
>
> So, do we have a clean complete fix? Why not leave the partial fix which we have in place and incorporate the clean fix on top of that?  I would prefer to have something here instead of nothing at all.. but that is just me.
>

I wrongly pushed Deepak's fix when updating dspbridge, when I revert the 
old patch it will remove the other line too.

The partial fix is solving the kernel warning but is useless for the 
flooding of DSP messages, because the line left which is SYNC_SetEvent 
needs an actual event to be waiting, so right now it is not doing 
anything (in the original patch wasn't doing anything either), so before 
we forget that the line left there is useless I'm reverting the patch.

Regards,

Omar
