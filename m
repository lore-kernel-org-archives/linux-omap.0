From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 24/25] OMAP4: cpuidle: Switch to gptimer from twd in deeper
 C-states.
Date: Sun, 18 Sep 2011 14:18:17 +0530
Message-ID: <4E75B051.9000503@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-25-git-send-email-santosh.shilimkar@ti.com> <878vpope90.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46222 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750753Ab1IRIsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Sep 2011 04:48:23 -0400
Received: by gxk5 with SMTP id 5so10840024gxk.39
        for <linux-omap@vger.kernel.org>; Sun, 18 Sep 2011 01:48:21 -0700 (PDT)
In-Reply-To: <878vpope90.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Friday 16 September 2011 11:21 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> CPU local timer(TWD) stops when the CPU is transitioning into
>> deeper C-States. Since these timers are not wakeup capable, we
>> need the wakeup capable global timer to program the wakeup time
>> depending on the next timer expiry.
>>
>> It can be handled by registering a global wakeup capable timer along
>> with local timers marked with (mis)feature flag CLOCK_EVT_FEAT_C3STOP.
> 
> nit: this comment makes is sound like this patch adds the registration
> of this timer, when all this patch does is add the notification.
> 
> Changelog should be updated to make it clear that the global timer exists
> already, and is already marked with the C3STOP flag.
> 
 Will add couple of lines in the change log to make it clear.

>> Then notify the clock events layer from idle code using
>> CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT).
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
> 
> Other than that
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
Thanks.

Regards
Santosh
