From: Kevin Hilman <khilman@ti.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Wed, 20 Apr 2011 16:59:16 -0700
Message-ID: <87r58w4gq3.fsf@ti.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37350 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752292Ab1DTX7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 19:59:19 -0400
Received: by mail-pw0-f53.google.com with SMTP id 7so840071pwj.40
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 16:59:18 -0700 (PDT)
In-Reply-To: <20110419062633.GA15620@atomide.com> (Tony Lindgren's message of
	"Tue, 19 Apr 2011 09:26:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

Hi Tony,

Tony Lindgren <tony@atomide.com> writes:

> * Varadarajan, Charulatha <charu@ti.com> [110418 18:00]:
>> From: Charulatha V <charu@ti.com>
>> 
>> Use PM runtime framework in OMAP GPIO driver.
> ...
>  
>>  arch/arm/mach-omap2/gpio.c             |    6 +
>>  arch/arm/mach-omap2/pm34xx.c           |   22 +-
>>  arch/arm/plat-omap/gpio.c              |  766 ++++++++++++++++++--------------
>>  arch/arm/plat-omap/include/plat/gpio.h |    3 +-
>>  4 files changed, 439 insertions(+), 358 deletions(-)
>
> Before this series gets merged we first need to do the following:
> - Pass some registers in platform_data so we can have common
>   functions in gpio.c instead of having to test for the bank->method
>   in each function. This allows getting rid of the ifdefs as
>   discussed in the ARM Linux consolidation thread.

I have a series that starts this process, will post it shortly.

> - Move it to drivers/gpio
>
> - Further consolidate with whatever common GPIO code might
>   be coming up.

Is the above order required?

IMO, before we move it to drivers/gpio, this code needs to be runtime PM
converted (using this series from Charu.)  The runtime PM conversion
removes a bunch of platform-specific hacks that should be moved into
drivers/*.

Personally, I think we should go in this order

- runtime PM conversion
- #ifdef cleanup
- move to drivers/gpio
- look at consolidation with other drivers

I'm willing to queue the GPIO work in my tree while it's under way if
you like as well.

Kevin
