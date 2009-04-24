From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: n800 high idle power consumption
Date: Fri, 24 Apr 2009 16:50:11 +0300
Message-ID: <87d4b2b1po.fsf@litku.valot.fi>
References: <877i1aejon.fsf@litku.valot.fi>
	<87zle6xj17.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:63151 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbZDXNuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 09:50:19 -0400
Received: by fg-out-1718.google.com with SMTP id 16so182341fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2009 06:50:17 -0700 (PDT)
In-Reply-To: <87zle6xj17.fsf@deeprootsystems.com> (Kevin Hilman's message of "Fri\, 24 Apr 2009 06\:45\:08 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Kalle Valo <kalle.valo@iki.fi> writes:
>
>> Hello all,
>>
>> I was testing 2.6.30-rc3-omap1 on n800 and noticed that idle power
>> consumption is very high, ten times compared to a 2.6.29 I tested few
>> weeks back. I'm guessing that CPU doesn't sleep at all.
>>
>> Is this a regression? How should I debug this further?
>
> Between .29 and .30, the PM code in l-o was dropped and re-sync'd to
> kernel.org code.  This is so that PM can be separated out into a
> separate branch and submitted upstream independently.

Ah, of course. I read about this but didn't understand the implications :)
Thanks for pointing this out to me.

> The current PM branch is in the process of being re-based onto 2.6.30.
> When it's ready, I'd appreciate any testing on n800.

Ok. Please let me know when it's ready.

-- 
Kalle Valo
