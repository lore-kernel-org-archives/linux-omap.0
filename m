From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Mon, 22 Nov 2010 08:08:33 -0800
Message-ID: <87sjytxrwe.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<877hg92ep4.fsf@deeprootsystems.com> <4CE6EE0B.1090809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47734 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab0KVQIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 11:08:38 -0500
Received: by gxk23 with SMTP id 23so4146600gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 08:08:38 -0800 (PST)
In-Reply-To: <4CE6EE0B.1090809@ti.com> (Nishanth Menon's message of "Fri, 19
	Nov 2010 15:37:15 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 11/19/2010 03:20 PM, the following:
>
>>> Request for testing this series for comparison between master and this
>>> series requested for additional platforms where available.
>>
>> I haven't yet been through the entire series, but some general comments
>> to share before the weekend:
> thanks for comments so far. I will wait for the complete series to be
> reviewed before reposting a v2.
>
>>
>> The secure mode code is growing in size and complexity, so I think it
>> should be removed from pm34xx.c and moved into it's own file
>> (secure3xxx.c ?)   This will help keep pm34xx.c lean, and it can call
>> into secure code as needed.    
>
> IMHO - we should do that set of cleanups as part of Jean's patch
> series where we transition to sdram where possible - that will allow
> us to have C code replacement for sleep34xx.S and optimize better in
> conjunction with sram_idle function and helpers.

No, I'd like to see the secure code in your patch all in a separate
file.  Jean's cleanups are independent of better organization and
structure of your code.

>> Even better (and already suggested in some comments on patch 8), now
>> that there are board-configurable knobs, this should be set up as a very
>> simple platform driver/device so boards can pass configuration in a
>> standard way instead of having new APIs for use by board code to set
>> configuration settings.
>
> in this specific context, having a platform data device is more of an
> overkill - 90% of the HS platforms (just a guess based on the limited
> devices I know of and is not a hard statistics) use the TI defaults -
> we do have exceptional customers who do their own PPA - and having a
> device-driver model IMHO is an overkill for that flexibility.

The board-level configuration is only one (minor) reason to have a
separate driver for the secure stuff.   Discussions on the other patches
suggested other reasons for this as well, including some reasons from
you as well. :)

Kevin

