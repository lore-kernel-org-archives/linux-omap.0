From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Fri, 19 Nov 2010 15:37:15 -0600
Message-ID: <4CE6EE0B.1090809@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com> <877hg92ep4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48676 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754143Ab0KSVhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 16:37:19 -0500
Received: by mail-vw0-f44.google.com with SMTP id 7so357166vws.17
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 13:37:18 -0800 (PST)
In-Reply-To: <877hg92ep4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Kevin Hilman had written, on 11/19/2010 03:20 PM, the following:

>> Request for testing this series for comparison between master and this
>> series requested for additional platforms where available.
> 
> I haven't yet been through the entire series, but some general comments
> to share before the weekend:
thanks for comments so far. I will wait for the complete series to be 
reviewed before reposting a v2.

> 
> The secure mode code is growing in size and complexity, so I think it
> should be removed from pm34xx.c and moved into it's own file
> (secure3xxx.c ?)   This will help keep pm34xx.c lean, and it can call
> into secure code as needed.    
IMHO - we should do that set of cleanups as part of Jean's patch series 
where we transition to sdram where possible - that will allow us to have 
C code replacement for sleep34xx.S and optimize better in conjunction 
with sram_idle function and helpers.

> Even better (and already suggested in some comments on patch 8), now
> that there are board-configurable knobs, this should be set up as a very
> simple platform driver/device so boards can pass configuration in a
> standard way instead of having new APIs for use by board code to set
> configuration settings.
in this specific context, having a platform data device is more of an 
overkill - 90% of the HS platforms (just a guess based on the limited 
devices I know of and is not a hard statistics) use the TI defaults - we 
do have exceptional customers who do their own PPA - and having a 
device-driver model IMHO is an overkill for that flexibility.

-- 
Regards,
Nishanth Menon
