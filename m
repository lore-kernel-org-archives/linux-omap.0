From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] OMAP: GPIO: cleanup: first pass at ifdef removal
Date: Thu, 21 Apr 2011 08:12:52 -0700
Message-ID: <8739lb4ozv.fsf@ti.com>
References: <1303344831-7889-1-git-send-email-khilman@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037AD272CB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54949 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754448Ab1DUPM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 11:12:56 -0400
Received: by pxi1 with SMTP id 1so1283355pxi.9
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 08:12:54 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037AD272CB@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Thu, 21 Apr 2011 14:02:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

Hi Tarun,

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> [...]
>> 
>> This series is a first pass at the #ifdef removal cleanup.
>> 
>> To demonstrate the type of changes needed for the cleanup, the
>> direction and data input/output functions are handled first.  Register
>> offset fields are added to platform_data so #ifdefs can be removed.
>> 
>> Similar needs to be done for the remaining #ifdefs.
>> 
>> Currently boot tested on 3430/n900 only.
> Tested following on OMAP2420, OMAP2430, OMAP4430:
> -> request/free of gpio lines
> -> configure input/output mode
> -> interrupt configuration
> -> read/write

Thanks for testing!

Kevin
