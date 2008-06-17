From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 01/02] OMAP3 CPUidle driver
Date: Tue, 17 Jun 2008 10:30:11 -0700
Message-ID: <871w2w6kbg.fsf@paris.hilman.org>
References: <0a2401c8cac8$db978770$68bf18ac@ent.ti.com>
	<87skvd9dal.fsf@paris.hilman.org>
	<003001c8d034$194be460$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:42994 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbYFQRaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 13:30:21 -0400
In-Reply-To: <003001c8d034$194be460$68bf18ac@ent.ti.com> (Rajendra Nayak's message of "Tue\, 17 Jun 2008 10\:09\:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

>> "Rajendra Nayak" <rnayak@ti.com> writes:
>> 
>> > This patch adds the OMAP3 cpuidle driver. Irq enable/disable is done
>> > in the core cpuidle driver before it queries the governor for the
>> > next state.
>> 
>> Can you explain why you need the IRQ/FIQ disable added to 
>> cpuidle_idle_call()
>> 
>
> This was done to prevent any interrupts firing in between a 
> cpuidle_curr_governor->select() and target_state->enter().

I understand that, but I still don't understand exactly what you're
trying to prevent.  Did you have a specific bug that this prevented?

> An interrupt in between could end up with a previously selected 
> state to be programmed.

Remember that this function _is_ the idle loop, meaning when this runs
nothing else is happening.  After the select, if other system activity
has happened (e.g. and interrupt, or thread wakeup etc.), it will run
before the target_state->enter() because of the check for
need_resched().

> Any suggestions on a better way to handle this?

Just drop the IRQ/FIQ disables altogether.

Using previous versions of the CPUidle patches, I'm using unmodified
CPUidle code without any problems.

Kevin

