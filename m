From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 10:31:59 -0500
Message-ID: <4C92386F.2070600@ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com> <87sk19eneu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab0IPPcF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 11:32:05 -0400
In-Reply-To: <87sk19eneu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Kevin Hilman had written, on 09/16/2010 10:08 AM, the following:
[..]
>> more than that you name
>> some functions omap_*, and how hard would it be to put it under
>> arch/arm/common/*.c
>> arch/arm/include/asm/*.h
>>
>> Possible even higher up in the directory hiearchy in include/linux/opp.h
>> for the header and drivers/opp/*.c, because I think SuperH and power
>> are not that different in this respect.
> 
> Yeah, I guess this isn't ARM specific either, so should be at a higher
> level. 
> 
> Nishanth, can take my hack below and continue this evolution?  As I
> demonstrate with this hack, this won't really change anything for us.

thanks..  The only contention ahead is: where do we want this?
Is drivers/opp/opp_core.c the right place? Given that this is just a 
support library and not really a driver? for some reason lib/opp.c 
does'nt sound just right either :(

[..]

-- 
Regards,
Nishanth Menon
