From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection instead
 of always dummy
Date: Wed, 13 Mar 2013 21:07:01 +0530
Message-ID: <51409D1D.9000500@ti.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com> <514046B6.9020005@ti.com> <alpine.LFD.2.02.1303131516090.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53867 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932391Ab3CMPgF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 11:36:05 -0400
In-Reply-To: <alpine.LFD.2.02.1303131516090.22263@ionos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>

On Wednesday 13 March 2013 07:49 PM, Thomas Gleixner wrote:
> On Wed, 13 Mar 2013, Santosh Shilimkar wrote:
>> On Wednesday 13 March 2013 02:36 PM, Santosh Shilimkar wrote:
>>> With recent arm broadcast time clean-up from Mark Rutland, the dummy
>>> broadcast device is always registered with timer subsystem. And since
>>> the rating of the dummy clock event is very high, it is preferred
>>> over a real broad-cast clock event.
>>>
>>> This is a change in behavior from past and not an intended
>>> one. So reduce the rating of the dummy clockevent so that
>>> real broadcast device is selected when available.
>>>
>>> Without this all the C states with C3STOP won't work since
>>> the broad cast notifier will take an abort.
>>>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>> Its a regression so hopefully can get into the 3.9-rcx. Noticed
>>> this one on A15 platform. A9 platform the issue may not be seen
>>> since the local timer check avoids dummy timer registration.
>>>
>> Some one pointed me to a fix made by Mark which was discussed
>> under '[BUG] ARM Architected timers appear broken in 3.9-rc1' subject.
>> That patch seems to be more of work around since the root of the
>> problem is incorrect dummy timer rating. Either way, both patches
>> fix the issue.
> 
> Well, using a dummy timer as the broadcast event device is a bug, no
> matter what the rating is. The fix is in Linus tree already.
>
Agree.
 
> Though making the rating of the dummy lower is definitely a good
> thing, so a real hardware device which is detected later can replace
> the dummy device. So yes, the rating should be low for the dummy
> timer.
> 
Exactly. As Mark pointed out, you have already applied Mark's patch.
I was just wondering whether you can take the $subject patch as well
with ack from Russell, Mark.

Regards,
Santosh

