From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: OMAP CLK / CM data move to /drivers/clk
Date: Thu, 28 Feb 2013 09:48:14 -0400
Message-ID: <512F601E.9070200@ti.com>
References: <1361954659.8362.70.camel@sokoban> <20130227184345.14870.23049@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37217 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab3B1Ns1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Feb 2013 08:48:27 -0500
In-Reply-To: <20130227184345.14870.23049@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Mike,

On 27-02-2013 14:43, Mike Turquette wrote:
> Quoting Tero Kristo (2013-02-27 00:44:19)
>> Hi Paul and Mike,
>>
>> It looks like we need to start putting more effort into this clock data
>> move now, as this is starting to hinder us on several fronts.
>> Unfortunately I still can't personally participate in this work myself
>> as I am now allocated to some hwmod related work, but Eduardo should
>> have plenty of time to help with this...
>>
>> Anyway, Paul, I think you have been working a bit with this topic, what
>> is the latest status with this? Do you see any areas Eduardo can help
>> with? If you have some partially finished work also which you don't have
>> time yourself, we can even take a look at that.
>>
>> Also, I would like to receive some initial comments about the approach
>> we should take, and I added Mike here for this as you are the maintainer
>> for the /drivers/clk. I believe we should start by moving the clock data
>> under /drivers/clk/omap, and potentially move also some other stuff
>> here, like CM code, clockdomain code and clockdomain data even. Do you
>> have any opinions on this?
>>
>
> My gut reaction is that I do not want the clockdomain or CM code under
> drivers/clk.  The clock code and data is welcome under drivers/clk.  If
> there are zero users of the CM and clockdomain code outside of the clock
> code, then I'll consider it, but otherwise the CM and clockdomain code
> must find a proper home.
>
> There was some discussion about a general place to put power controller
> code [1] and some stuff about power sequencing on the list [2], perhaps
> that is a better destination for the CM and clockdomain code?  I admit
> it is a stretch.
>
> There are two other points to consider when migrating this data:
>
> 1) Has the hwmod initialization been changed to run after early init,
> when slab is up?  If so then that removes the barrier keeping the OMAP
> clock data statically initialized via clk-private.h.  Whoever is going
> to migrate this data should think about registering the clocks
> dynamically and using clk-provider.h instead of clk-private.h.  I'd like
> to remove the latter header and after Tegra's latest CCF patches I
> believe that only OMAP is making use of it.

The documentation under "Documentation/clk.txt" states somewhat different:
"
To get around this problem struct clk's definition is exposed in
include/linux/clk-private.h along with some macros for more easily
initializing instances of the basic clock types.  These clocks must
still be initialized with the common clock framework via a call to
__clk_init."

Despite the fact that OMAP is the only real user of clk-private.h, I 
believe one must update the documentation to clear discourage the usage 
of clk-provider.h by any means, outside the core CCF code, even for 
static definition of clk data, considering your statement above.

>
> 2) Migrating the clock data to device tree.  This seems to be the way
> everyone is going.  I care less about this one as the maintainer of
> drivers/clk and more about getting rid of clk-private.h users once and
> for all.

Tegra folks has already stepped into that direction. I agree that this 
is ideal for declaring the clock static data. This is obviously more 
complicated for OMAP legacy code. That would need to be done into two 
steps at least, so that we won't break support on older OMAP versions.

>
> Regards,
> Mike
>
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/90425
> [2] http://article.gmane.org/gmane.linux.kernel/1395912/match=runtime+interpreted+power+sequences
>
>> -Tero
>
>

