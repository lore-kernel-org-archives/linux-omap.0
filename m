From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] ARM: OMAP: remove unnecessary locking in
	clk_get_rate()
Date: Wed, 4 Jun 2008 15:30:20 -0700
Message-ID: <20080604223019.GJ6992@atomide.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com> <1211323550-5318-2-git-send-email-khilman@mvista.com> <1211323550-5318-3-git-send-email-khilman@mvista.com> <1211323550-5318-4-git-send-email-khilman@mvista.com> <1211323550-5318-5-git-send-email-khilman@mvista.com> <1211323550-5318-6-git-send-email-khilman@mvista.com> <alpine.DEB.1.00.0806040058450.1170@utopia.booyaka.com> <4846C44E.9090102@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60657 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbYFDWaY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2008 18:30:24 -0400
Content-Disposition: inline
In-Reply-To: <4846C44E.9090102@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [080604 09:37]:
> Paul Walmsley wrote:
>>
>> Hi Kevin,
>>
>> On Tue, 20 May 2008, Kevin Hilman wrote:
>>
>>  > The locking in the get_rate() hook is unnecessary, and causes problems
>>  > when used with the -rt patch, since it may be called recursively.
>>  >
>>  > Signed-off-by: Kevin Hilman <khilman@mvista.com>
>>
>> Acked-by: Paul Walmsley <paul@pwsan.com>
>>
>> BTW, looks like we could probably get rid of some of the other spinlocking
>> in plat-omap/clock.c also -- clk_get_usecount() ?
>
> I agree, most of the locking in there seems unnecessary, but this was  
> the only one that could be removed without looking closer at at all the  
> platform specific clock code.
>
> Basically, I think there minimal (maybe no) locking in the generic  
> layer, and the locking should be done if necessary in the platform  
> specific parts.

To me it seems locking is needed. What if something is changing a clock's
rate and then something else calls get_rate() while the other thread is
changing the rate?

If get_rate() is not locking, get_rate() may get invalid rate between
something else programming the hardware and changing clk->rate. I guess
just locking set_rate() would still work with local irq disabled,
but would not be SMP safe.

Anyways, ideally the spin_lock would be specific to the clocks accessing
the same clock registers... But that would mean adding yet another field
to struct clk or clock domains. Anybody got better ideas?

And of course anything going through the clocks list needs to be protected
by the mutex.

Tony
