From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP] [PATCH 2/2]: Change return value from ERR_PTR(..)
 to NULL in opp layer
Date: Fri, 15 Jan 2010 20:54:28 -0600
Message-ID: <4B512A64.8060807@ti.com>
References: <1263553383.3490.44.camel@boson>,<878wbz44qm.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301E196B370@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47596 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757767Ab0APCya (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 21:54:30 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E196B370@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dasgupta, Romit had written, on 01/15/2010 08:36 PM, the following:
>>> Returning NULL pointer from the OPP APIs instead of ERR_PTR where
>>> return struct omap_opp *. This is because there is no inherent value in
>>> returning ERR_PTR from the opp layer. Returning NULL serves the purpose.
> 
>> NAK.
> 
>> Using ERR_PTR allows returning different types of error conditions,
>> and is common practice across the kernel.
> Yes, it is true that it is a common practice but in case of the OPP layer I did not 
> see any purpose. The caller of the APIs returning struct omap_opp * can just
> check for NULL value for failure.
My initial intention of introducing ERR_PTR had the objective of being 
flexible:
I could not predict how each function would develop into - e.g. lists 
etc. They may prefer to return error values which could be independently 
handled. allow future flexibility. let me illustrate it - now that we 
are aligned that we are moving to enums:
The caller does not have an idea if mpu_opps was initialized or not.

opp_find_freq_exact can return: (examples ofcourse)
   -EDATA to say that the domain requested was not initialized
or
   -EAGAIN once we introduce locks to say that it is locked 
(non-blocking implementation)
or
   -ERANGE to say that the caller is asking for a frequency beyond the 
supported range.

Another example: opp_enable can now return -EEXIST to say that the the 
opp was already enabled etc..

The benefit I definitely see is that with an previously placed single 
pr_err of the return value by the caller, I can remotely debug an issue 
in code instead of having the developer to add printks/use lauterbach to 
debug.

ok, I might not have selected the best of return values, but I hope the 
idea is clear. NAK from myside too.

Regards,
Nishanth Menon
