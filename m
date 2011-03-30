From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module
 support
Date: Wed, 30 Mar 2011 11:45:46 +0530
Message-ID: <4D92CA92.50805@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com> <1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com> <20110328205027.GC30616@atomide.com> <5cbdd88c3ca3fe5c5a0f119be446ce99@mail.gmail.com> <20110329170113.GG4016@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44167 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753126Ab1C3GQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 02:16:06 -0400
Received: by yib18 with SMTP id 18so422885yib.28
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 23:16:03 -0700 (PDT)
In-Reply-To: <20110329170113.GG4016@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On 3/29/2011 10:31 PM, Tony Lindgren wrote:
> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110328 22:47]:
>>> From: Tony Lindgren [mailto:tony@atomide.com]
>>>
>>> Do you really need to initialize all of this that early?
>>>
>> Yes. It's a interrupt controller extension and needs to work
>> together with GIC.
>
> Hmm to me it seems that the gic_arch_extn functions should be
> all NULL during runtime operation, and the wake-up generator
> should be programmed only before entering an idle state.
>
> Then the wake-up generator can be cleared after delivering
> the wake-up event(s).
>
> Or am I missing something on why this should be enabled all
> the time?
>
Yep. The WakeupGen sits between GIC and CPU and can
gate the interrupts in normal operation too. It's
mandatory that the interrupt mask at GIC and WakeupGen
matches to deliver the interrupt to CPU.

This is the reason why all the necessary GIC hooks are
populated with it so that they work together.

So far without this patch all interrupts at WakeupGen
level were always enabled and hence there was no issue.

> BTW, looks like you got few typos in the comments in this
> patch, noticed these while reading:
>
> Hardware requirements is
> GIC rgeisters
> gic architecture specific fucntioms
>
I do lot of them :(
Will fix these typos.

Regards
Santosh



